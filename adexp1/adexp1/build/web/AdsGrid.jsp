<%@ include file="Common.jsp" %><%!//
//   Filename: AdsGrid.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//
    static final String sFileName = "AdsGrid.jsp";
    static final String PageBODY = "bgcolor=\"#FFFFFF\"";
    static final String FormTABLE = "";
    static final String FormHeaderTD = "bgcolor=\"#808080\" align=\"center\"";
    static final String FormHeaderFONT = "face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\"";
    static final String FieldCaptionTD = "bgcolor=\"#CCCCCC\"";
    static final String FieldCaptionFONT = "face=\"arial\" size=\"2\" style=\"font:bold\"";
    static final String DataTD = "bgcolor=\"#EEEEEE\"";
    static final String DataFONT = "face=\"arial\" size=\"2\"";
    static final String ColumnFONT = "face=\"arial\" size=\"2\" style=\"font:bold\"";
    static final String ColumnTD = "bgcolor=\"#CCCCCC\"";
%><%

            boolean bDebug = false;

            String sAction = getParam(request, "FormAction");
            String sForm = getParam(request, "FormName");
            String sAdsErr = "";
            String sSearchErr = "";
            String sMenuErr = "";

            java.sql.Connection conn = null;
            java.sql.Statement stat = null;
            String sErr = loadDriver();
            conn = cn();
            stat = conn.createStatement();
            if (!sErr.equals("")) {
                try {
                    out.println(sErr);
                } catch (Exception e) {
                }
            }

%>            
<html>
    <head>
        <title>Classifieds</title>
        <link rel="stylesheet" href="css.css" />
        <meta http-equiv="pragma" content="no-cache"/>
        <meta http-equiv="expires" content="0"/>
        <meta http-equiv="cache-control" content="no-cache"/>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    </head>
    <body bgcolor="#FFFFFF">
        <jsp:include page="Header.jsp" flush="true"/>
        <div id="Layer1"><img src="imges/Reklama-Majas-lapu-izstrade.jpg" width="694" height="344" /></div>
<div id="Layer1"><img src="imges/add4.jpg" alt="olig" width="694" height="344" /></div>

        <div id="Layer23">
            <table width="693" border="0">
                <tr>
                    <th width="683" scope="col"><div align="left">
                            <table>
                                <tr>

                                    <td valign="top">
                                        <% Search_Show(request, response, session, out, sSearchErr, sForm, sAction, conn, stat);%>

                                    </td>
                                    <td valign="top">
                                        <% Menu_Show(request, response, session, out, sMenuErr, sForm, sAction, conn, stat);%>

                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td valign="top">
                                        <% Ads_Show(request, response, session, out, sAdsErr, sForm, sAction, conn, stat);%>

                                    </td>
                                </tr>
                            </table>
                           </div></th>
                </tr>
            </table>
        </div>
        <jsp:include page="Addlogde.jsp"/>
        <jsp:include page="Footer.jsp" flush="true"/>

    </body>
</html>
<%%>
<%
            if (stat != null) {
                stat.close();
            }
            if (conn != null) {
                conn.close();
            }
%>
<%!    void Ads_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAdsErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {

        String sWhere = "";
        int iCounter = 0;
        int iPage = 0;
        boolean bIsScroll = true;
        boolean hasParam = false;
        String sOrder = "";
        String sSQL = "";
        String transitParams = "";
        String sQueryString = "";
        String sPage = "";
        int RecordsPerPage = 20;
        String sSortParams = "";
        String formParams = "";

        String pcategory_id = "";
        String pname = "";
        String ppricemax = "";
        String ppricemin = "";


        transitParams = "category_id=" + toURL(getParam(request, "category_id")) + "&name=" + toURL(getParam(request, "name")) + "&pricemin=" + toURL(getParam(request, "pricemin")) + "&pricemax=" + toURL(getParam(request, "pricemax")) + "&";
        formParams = "category_id=" + toURL(getParam(request, "category_id")) + "&name=" + toURL(getParam(request, "name")) + "&pricemin=" + toURL(getParam(request, "pricemin")) + "&pricemax=" + toURL(getParam(request, "pricemax")) + "&";
        // Build WHERE statement

        //-- Check category_id parameter and create a valid sql for where clause

        pcategory_id = getParam(request, "category_id");
        if (!isNumber(pcategory_id)) {
            pcategory_id = "";
        }

        if (pcategory_id != null && !pcategory_id.equals("")) {

            hasParam = true;
            sWhere += "a.category_id=" + pcategory_id;
        }

        //-- Check name parameter and create a valid sql for where clause

        pname = getParam(request, "name");
        if (pname != null && !pname.equals("")) {

            if (!sWhere.equals("")) {
                sWhere += " and ";
            }
            hasParam = true;
            sWhere += "a.name like '%" + replace(pname, "'", "''") + "%'";
        }

        //-- Check pricemax parameter and create a valid sql for where clause

        ppricemax = getParam(request, "pricemax");
        if (!isNumber(ppricemax)) {
            ppricemax = "";
        }

        if (ppricemax != null && !ppricemax.equals("")) {

            if (!sWhere.equals("")) {
                sWhere += " and ";
            }
            hasParam = true;
            sWhere += "a.price<=" + ppricemax;
        }

        //-- Check pricemin parameter and create a valid sql for where clause

        ppricemin = getParam(request, "pricemin");
        if (!isNumber(ppricemin)) {
            ppricemin = "";
        }

        if (ppricemin != null && !ppricemin.equals("")) {

            if (!sWhere.equals("")) {
                sWhere += " and ";
            }
            hasParam = true;
            sWhere += "a.price>=" + ppricemin;
        }

        if (hasParam) {
            sWhere = " AND (" + sWhere + ")";
        }
        // Build ORDER statement
        sOrder = " order by a.date_posted Desc";
        String sSort = getParam(request, "FormAds_Sorting");
        String sSorted = getParam(request, "FormAds_Sorted");
        String sDirection = "";
        String sForm_Sorting = "";
        int iSort = 0;
        try {
            iSort = Integer.parseInt(sSort);
        } catch (NumberFormatException e) {
            sSort = "";
        }
        if (iSort == 0) {
            sForm_Sorting = "";
        } else {
            if (sSort.equals(sSorted)) {
                sSorted = "0";
                sForm_Sorting = "";
                sDirection = " DESC";
                sSortParams = "FormAds_Sorting=" + sSort + "&FormAds_Sorted=" + sSort + "&";
            } else {
                sSorted = sSort;
                sForm_Sorting = sSort;
                sDirection = " ASC";
                sSortParams = "FormAds_Sorting=" + sSort + "&FormAds_Sorted=" + "&";
            }

            if (iSort == 1) {
                sOrder = " order by a.date_posted" + sDirection;
            }
            if (iSort == 2) {
                sOrder = " order by a.name" + sDirection;
            }
            if (iSort == 3) {
                sOrder = " order by c.name" + sDirection;
            }
            if (iSort == 4) {
                sOrder = " order by m.member_login" + sDirection;
            }
            if (iSort == 5) {
                sOrder = " order by a.price" + sDirection;
            }
        }


        // Build full SQL statement

        sSQL = "select a.ad_id as a_ad_id, "
                + "a.category_id as a_category_id, "
                + "a.date_posted as a_date_posted, "
                + "a.member_id as a_member_id, "
                + "a.name as a_name, "
                + "a.price as a_price, "
                + "c.category_id as c_category_id, "
                + "c.name as c_name, "
                + "m.member_id as m_member_id, "
                + "m.member_login as m_member_login "
                + " from ads a, categories c, members m"
                + " where c.category_id=a.category_id and m.member_id=a.member_id  ";

        sSQL = sSQL + sWhere + sOrder;

        String sNoRecords = "     <tr>\n      <td colspan=\"5\" bgcolor=\"#EEEEEE\"><font face=\"arial\" size=\"2\">No records</font></td>\n     </tr>";


        String tableHeader = "";
        tableHeader = "     <tr>\n      <td bgcolor=\"#CCCCCC\"><a href=\"" + sFileName + "?" + formParams + "FormAds_Sorting=1&FormAds_Sorted=" + sSorted + "&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Date Posted</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\"" + sFileName + "?" + formParams + "FormAds_Sorting=2&FormAds_Sorted=" + sSorted + "&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\"" + sFileName + "?" + formParams + "FormAds_Sorting=3&FormAds_Sorted=" + sSorted + "&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Category</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\"" + sFileName + "?" + formParams + "FormAds_Sorting=4&FormAds_Sorted=" + sSorted + "&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Member</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\"" + sFileName + "?" + formParams + "FormAds_Sorting=5&FormAds_Sorted=" + sSorted + "&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Price</font></a></td>\n     </tr>";


        try {
            out.println("    <table >");
            out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"5\"><a name=\"Ads\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Classifieds</font></a></td>\n     </tr>");
            out.println(tableHeader);

        } catch (Exception e) {
        }


        try {
            // Select current page
            iPage = Integer.parseInt(getParam(request, "FormAds_Page"));
        } catch (NumberFormatException e) {
            iPage = 0;
        }

        if (iPage == 0) {
            iPage = 1;
        }
        RecordsPerPage = 20;
        try {
            java.sql.ResultSet rs = null;
            // Open recordset
            rs = openrs(stat, sSQL);
            iCounter = 0;
            absolute(rs, (iPage - 1) * RecordsPerPage + 1);
            java.util.Hashtable rsHash = new java.util.Hashtable();
            String[] aFields = getFieldsName(rs);

            // Show main table based on recordset
            while ((iCounter < RecordsPerPage) && rs.next()) {

                getRecordToHash(rs, rsHash, aFields);
                String fldcategory_id = (String) rsHash.get("c_name");
                String flddate_posted = (String) rsHash.get("a_date_posted");
                String fldmember_id = (String) rsHash.get("m_member_login");
                String fldname = (String) rsHash.get("a_name");
                String fldprice = (String) rsHash.get("a_price");

                out.println("     <tr>");

                out.print("      <td bgcolor=\"#EEEEEE\">");
                out.print("<font face=\"arial\" size=\"2\">" + toHTML(flddate_posted) + "&nbsp;</font>");
                out.println("</td>");
                out.print("      <td bgcolor=\"#EEEEEE\">");
                out.print("<a href=\"AdView.jsp?" + transitParams + "ad_id=" + toURL((String) rsHash.get("a_ad_id")) + "&\"><font face=\"arial\" size=\"2\">" + toHTML(fldname) + "</font></a>");

                out.println("</td>");
                out.print("      <td bgcolor=\"#EEEEEE\">");
                out.print("<font face=\"arial\" size=\"2\">" + toHTML(fldcategory_id) + "&nbsp;</font>");
                out.println("</td>");
                out.print("      <td bgcolor=\"#EEEEEE\">");
                out.print("<a href=\"MemberInfo.jsp?" + transitParams + "member_id=" + toURL((String) rsHash.get("a_member_id")) + "&\"><font face=\"arial\" size=\"2\">" + toHTML(fldmember_id) + "</font></a>");

                out.println("</td>");
                out.print("      <td bgcolor=\"#EEEEEE\">");
                out.print("<font face=\"arial\" size=\"2\">" + toHTML(fldprice) + "&nbsp;</font>");
                out.println("</td>");
                out.println("     </tr>");

                iCounter++;
            }
            if (iCounter == 0) {
                // Recordset is empty
                out.println(sNoRecords);

                iCounter = RecordsPerPage + 1;
                bIsScroll = false;
            } else {


                // Parse scroller
                boolean bInsert = false;
                boolean bNext = rs.next();
                if (!bNext && iPage == 1) {
                } else {
                    out.print("     <tr>\n      <td colspan=\"5\" bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">");

                    if (iPage == 1) {
                        out.print("\n       <a href_=\"#\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Previous</font></a>");
                    } else {
                        out.print("\n       <a href=\"" + sFileName + "?" + formParams + sSortParams + "FormAds_Page=" + (iPage - 1) + "#Form\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Previous</font></a>");
                    }

                    out.print("\n       [ " + iPage + " ]");

                    if (!bNext) {
                        out.print("\n       <a href_=\"#\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Next</font></a><br>");
                    } else {
                        out.print("\n       <a href=\"" + sFileName + "?" + formParams + sSortParams + "FormAds_Page=" + (iPage + 1) + "#Form\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Next</font></a><br>");
                    }

                    out.println("</td>\n     </tr>");
                }

            }

            if (rs != null) {
                rs.close();
            }
            out.println("    </table>");

        } catch (Exception e) {
            out.println(e.toString());
        }
    }

    void Search_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sSearchErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
        try {


            String fldname = "";


            String sSQL = "";
            String transitParams = "";
            String sQueryString = "";
            String sPage = "";


            out.println("    <table >");
            out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"3\"><a name=\"Search\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Search</font></a></td>\n     </tr>");
            out.println("     <form method=\"get\" action=\"AdsGrid.jsp\" name=\"Search\">\n     <tr>");
            // Set variables with search parameters

            fldname = getParam(request, "name");

            // Show fields


            out.println("      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></td>");
            out.print("      <td bgcolor=\"#EEEEEE\">");
            out.print("<input type=\"text\"  name=\"name\" maxlength=\"20\" value=\"" + toHTML(fldname) + "\" size=\"20\">");
            out.println("</td>");

            out.println("      <td ><input type=\"submit\" value=\"Search\"/></td>");
            out.println("     </tr>\n     </form>\n    </table>");
            out.println("");
        } catch (Exception e) {
            out.println(e.toString());
        }
    }

    void Menu_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sMenuErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
        try {

            out.println("    <table >");

            out.print("     <tr>");
            // Set URLs

            String fldField1 = "AdvSearch.jsp";
            // Show fields

            out.print("\n      <td bgcolor=\"#EEEEEE\"><a href=\"" + fldField1 + "\"><font face=\"arial\" size=\"2\">Advanced Search</font></a></td>");

            out.println("\n     </tr>\n    </table>");

        } catch (Exception e) {
            out.println(e.toString());
        }
    }
%>
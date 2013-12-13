<%@ include file="Common.jsp" %><%!//
//   Filename: Login.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//
    static final String sFileName = "Login.jsp";
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
            String sLoginErr = "";

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
            if (sForm.equals("Login")) {
                sLoginErr = LoginAction(request, response, session, out, sAction, sForm, conn, stat);
                if ("sendRedirect".equals(sLoginErr)) {
                    return;
                }
            }

%>            
<html>
    <head>
        <title>Classifieds</title>

        <meta http-equiv="pragma" content="no-cache"/>
        <meta http-equiv="expires" content="0"/>
        <meta http-equiv="cache-control" content="no-cache"/>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    </head>
    <body bgcolor="#FFFFFF">
        <jsp:include page="Header.jsp" flush="true"/>
        <div id="Layer23" align="center">

            <table>
                <tr>

                    <td valign="top">
                        <% Login_Show(request, response, session, out, sLoginErr, sForm, sAction, conn, stat);%>

                    </td>
                </tr>
            </table>

        </div>

        <jsp:include page="Footer.jsp" flush="true"/>
        <div id="Layer1"><img src="imges/add4.jpg" alt="olig" width="694" height="344" /></div>

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
<%!    String LoginAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
        String sLoginErr = "";
        try {
            final int iloginAction = 1;
            final int ilogoutAction = 2;
            String transitParams = "";
            String sQueryString = "";
            String sPage = "";
            String sSQL = "";
            int iAction = 0;

            if (sAction.equals("login")) {
                iAction = iloginAction;
            }
            if (sAction.equals("logout")) {
                iAction = ilogoutAction;
            }

            switch (iAction) {
                case iloginAction: {
                    // Login action

                    String sLogin = getParam(request, "Login");
                    String sPassword = getParam(request, "Password");
                    java.sql.ResultSet rs = null;
                    rs = openrs(stat, "select member_id, member_level from members where member_login =" + toSQL(sLogin, adText) + " and member_password=" + toSQL(sPassword, adText));

                    if (rs.next()) {
                        // Login and password passed
                        session.setAttribute("UserID", rs.getString(1));

                        session.setAttribute("UserRights", rs.getString(2));
                        sQueryString = getParam(request, "querystring");
                        sPage = getParam(request, "ret_page");
                        if (!sPage.equals(request.getRequestURI()) && !"".equals(sPage)) {
                            try {
                                if (stat != null) {
                                    stat.close();
                                }
                                if (conn != null) {
                                    conn.close();
                                }
                            } catch (java.sql.SQLException ignore) {
                            }
                            response.sendRedirect(sPage + "?" + sQueryString);
                            return "sendRedirect";
                        } else {
                            try {
                                if (stat != null) {
                                    stat.close();
                                }
                                if (conn != null) {
                                    conn.close();
                                }
                            } catch (java.sql.SQLException ignore) {
                            }
                            response.sendRedirect("Default.jsp");
                            return "sendRedirect";
                        }
                    } else {
                        sLoginErr = "Login or Password is incorrect.";
                    }
                    rs.close();

                    break;
                }
                case ilogoutAction: {
                    // Logout action

                    session.setAttribute("UserID", "");
                    session.setAttribute("UserRights", "");

                    break;
                }
            }
        } catch (Exception e) {
            out.println(e.toString());
        }
        return (sLoginErr);
    }

    void Login_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sLoginErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
        try {


            String sSQL = "";
            String transitParams = "";
            String sQueryString = getParam(request, "querystring");
            String sPage = getParam(request, "ret_page");

            out.println("    <table  border=0>");
            out.println("     <tr>\n      <td  align=\"center\" colspan=\"2\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\"><b>Enter Login and Password</b></font></td>\n     </tr>");

            if (sLoginErr.compareTo("") != 0) {
                out.println("     <tr>\n      <td colspan=\"2\" ><font color=\"#ffffff\" face=\"arial\" size=\"2\">" + sLoginErr + "</font></td>\n     </tr>");
            }
            sLoginErr = "";
            out.println("     <form action=\"" + sFileName + "\" method=\"POST\">");
            out.println("     <input type=\"hidden\" name=\"FormName\" value=\"Login\">");
            if (session.getAttribute("UserID") == null || ((String) session.getAttribute("UserID")).compareTo("") == 0) {
                // User did not login
                out.println("     <tr>\n      <td  ><font color=\"#ffffff\" face=\"arial\" size=\"2\" style=\"font:bold\">Login</font></td><td ><input type=\"text\" name=\"Login\" maxlength=\"50\" value=\"" + toHTML(getParam(request, "Login")) + "\"></td>\n     </tr>");
                out.println("     <tr>\n      <td  ><font color=\"#ffffff\" face=\"arial\" size=\"2\" style=\"font:bold\">Password</font></td><td ><input type=\"password\" name=\"Password\" maxlength=\"50\"></td>\n     </tr>");
                out.print("     <tr>\n      <td colspan=\"2\"><input type=\"hidden\" name=\"FormAction\" value=\"login\"><input type=\"submit\" value=\"Login\">");
                out.println("<input type=\"hidden\" name=\"ret_page\" value=\"" + sPage + "\"><input type=\"hidden\" name=\"querystring\" value=\"" + sQueryString + "\"></td>\n     </form>\n     </tr>");
            } else {
                // User logged in
                String sUserID = dLookUp(stat, "members", "member_login", "member_id =" + session.getAttribute("UserID"));
                out.print("     <tr><td bgcolor=\"#EEEEEE\"><font face=\"arial\" size=\"2\">" + sUserID + "&nbsp;&nbsp;" + "</font><input type=\"hidden\" name=\"FormAction\" value=\"logout\"/><input type=\"submit\" value=\"Logout\"/>");
                out.print("<input type=\"hidden\" name=\"ret_page\" value=\"" + sPage + "\"><input type=\"hidden\" name=\"querystring\" value=\"" + sQueryString + "\">");
                out.println("</td>\n     </form>\n     </tr>");
            }
            out.println("    </table>");


        } catch (Exception e) {
            out.println(e.toString());
        }
    }
%>
<%@ include file="Common.jsp" %><%!
//
//   Filename: AdView.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "AdView.jsp";
              
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

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sViewErr = "";

java.sql.Connection conn = null;
java.sql.Statement stat = null;
String sErr = loadDriver();
conn = cn();
stat = conn.createStatement();
if ( ! sErr.equals("") ) {
 try {
   out.println(sErr);
 }
 catch (Exception e) {}
}
if ( sForm.equals("View") ) {
  sViewErr = ViewAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sViewErr)) return;
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



<div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">
 <table>
  <tr>
   
   <td valign="top">
<% View_Show(request, response, session, out, sViewErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
             dfsdfdfdfdfdfdfdfdf
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
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!


  String ViewAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String sViewErr ="";
    try {

      if (sAction.equals("")) return "";

      String sSQL="";
      String transitParams = "";
      String primaryKeyParams = "";
      String sQueryString = "";
      String sPage = "";
      String sParams = "";
      String sActionFileName = "AdsGrid.jsp";
      String sWhere = " ";
      boolean bErr = false;
      long iCount = 0;

  
      String pPKad_id = "";

      final int iinsertAction = 1;
      final int iupdateAction = 2;
      final int ideleteAction = 3;
      int iAction = 0;

      if ( sAction.equalsIgnoreCase("insert") ) { iAction = iinsertAction; }
      if ( sAction.equalsIgnoreCase("update") ) { iAction = iupdateAction; }
      if ( sAction.equalsIgnoreCase("delete") ) { iAction = ideleteAction; }

      // Create WHERE statement


      String fldad_id="";
      String fldprice="";
      String fldcategory_id="";
      String fldmember_id="";

      // Load all form fields into variables
    

      sSQL = "";
      // Create SQL statement

      if ( sViewErr.length() > 0 ) return sViewErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        sViewErr = e.toString(); return (sViewErr);
      }
  
      try {
        if ( stat != null ) stat.close();
        if ( conn != null ) conn.close();
      }
      catch ( java.sql.SQLException ignore ) {}
      response.sendRedirect (sActionFileName);

      return "sendRedirect";
    }
    catch (Exception e) {out.println(e.toString()); }
    return (sViewErr);
  }

  


  void View_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sViewErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {

      String sSQL="";
      String sQueryString = "";
      String sPage = "";
      String sWhere = "";
      String transitParams = "";
      String transitParamsHidden = "";
      String requiredParams = "";
      String primaryKeyParams ="";
      java.util.Hashtable rsHash = new java.util.Hashtable();
      
      String pad_id = "";

      String fldcategory_id="";
      String fldmember_id="";
      String fldad_id="";
      String fldname="";
      String fldprice="";
      String flddate_posted="";
      String fldad_description="";


      boolean bPK = true;

      if ( "".equals(sViewErr)) {
        // Load primary key and form parameters
        pad_id = getParam( request, "ad_id");
      }
      else {
        // Load primary key, form parameters and form fields
        pad_id = getParam( request, "PK_ad_id");
      }

      
      if ( isEmpty(pad_id)) { bPK = false; }
      
      sWhere += "ad_id=" + toSQL(pad_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_ad_id\" value=\""+pad_id+"\"/>";

      sSQL = "select * from ads where " + sWhere;


      out.println("    <table >");
      out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"2\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Ad Info</font></td>\n     </tr>");
      if ( ! sViewErr.equals("")) {
        out.println("     <tr>\n      <td bgcolor=\"#EEEEEE\" colspan=\"2\"><font face=\"arial\" size=\"2\">"+sViewErr+"</font></td>\n     </tr>");
      }
      sViewErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"View\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "View".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        fldad_id = (String) rsHash.get("ad_id");
        fldname = (String) rsHash.get("name");
        fldprice = (String) rsHash.get("price");
        flddate_posted = (String) rsHash.get("date_posted");
        fldcategory_id = (String) rsHash.get("category_id");
        fldad_description = (String) rsHash.get("ad_description");
        fldmember_id = (String) rsHash.get("member_id");

        if (sAction.equals("") || ! "View".equals(sForm)) {
      
          fldad_id = (String) rsHash.get("ad_id");
          fldname = (String) rsHash.get("name");
          fldprice = (String) rsHash.get("price");
          flddate_posted = (String) rsHash.get("date_posted");
          fldcategory_id = (String) rsHash.get("category_id");
          fldad_description = (String) rsHash.get("ad_description");
          fldmember_id = (String) rsHash.get("member_id");
        }
        else {
          fldad_id = (String) rsHash.get("ad_id");
          fldname = (String) rsHash.get("name");
          fldprice = (String) rsHash.get("price");
          flddate_posted = (String) rsHash.get("date_posted");
          fldcategory_id = (String) rsHash.get("category_id");
          fldad_description = (String) rsHash.get("ad_description");
          fldmember_id = (String) rsHash.get("member_id");
        }
        
      }
      else {
      }
      
      // Set lookup fields
          fldcategory_id = dLookUp( stat, "categories", "name", "category_id=" + toSQL(fldcategory_id, adNumber));
          fldmember_id = dLookUp( stat, "members", "member_login", "member_id=" + toSQL(fldmember_id, adNumber));


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Ad #</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldad_id)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldname)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Price</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldprice)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Date Posted</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(flddate_posted)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Category</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldcategory_id)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Description</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldad_description)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Member info and ads</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<a href=\"MemberInfo.jsp?"+transitParams+"member_id="+toURL((String) rsHash.get("member_id"))+"&\"><font face=\"arial\" size=\"2\">"+toHTML(fldmember_id)+"</font></a>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "View".equals(sForm))) {
        
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"View\"><input type=\"hidden\" value=\"\" name=\"FormAction\">");
      }
      
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %>
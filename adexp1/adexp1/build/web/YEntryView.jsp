<%@ include file="YCommon.jsp" %><%!
//
//   Filename: EntryView.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "YEntryView.jsp";
              
static final String PageBODY = "bgcolor=\"#FFFFFF\" text=\"#000000\" link=\"#0000FF\" vlink=\"#800080\" alink=\"#FF0000\"";
static final String FormTABLE = "border=\"0\" cellspacing=\"0\" cellpadding=\"2\"";
static final String FormHeaderTD = "align=\"center\" bgcolor=\"#99CCFF\"";
static final String FormHeaderFONT = "style=\"font-size: 12pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\"";
static final String FieldCaptionTD = "bgcolor=\"#FFFF99\"";
static final String FieldCaptionFONT = "style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\"";
static final String DataTD = "bgcolor=\"#F5F5F5\"";
static final String DataFONT = "style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\"";
static final String ColumnFONT = "style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\"";
static final String ColumnTD = "bgcolor=\"#FFD9E5\"";
%><%

boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sEntryViewErr = "";

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
if ( sForm.equals("EntryView") ) {
  sEntryViewErr = EntryViewAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sEntryViewErr)) return;
}

%>            
<html>
<head>
<title>YellowPages</title>
<link rel="stylesheet" href="css.css" />
<meta name="GENERATOR" content="YesSoftware CodeCharge v.1.2.0 / JSP.ccp build 05/21/01"/>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#800080" alink="#FF0000">
<jsp:include page="Header.jsp" flush="true"/>

<div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">

<jsp:include page="YHeader.jsp" flush="true"/>
 <table>
  <tr>
   
   <td valign="top">
<% EntryView_Show(request, response, session, out, sEntryViewErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
 </div></th>
    </tr>
  </table>
</div>
<jsp:include page="Addlogde.jsp"/>
<jsp:include page="Footer.jsp"/>


</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!


  String EntryViewAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String sEntryViewErr ="";
    try {

      if (sAction.equals("")) return "";

      String sSQL="";
      String transitParams = "";
      String primaryKeyParams = "";
      String sQueryString = "";
      String sPage = "";
      String sParams = "";
      String sActionFileName = "YEntries.jsp";
      String sWhere = " ";
      boolean bErr = false;
      long iCount = 0;

  
      sParams = "?";
      sParams += "address=" + toURL(getParam( request, "Trn_address")) + "&";
      sParams += "name=" + toURL(getParam( request, "Trn_name")) + "&";
      sParams += "city=" + toURL(getParam( request, "Trn_city")) + "&";
      sParams += "zip=" + toURL(getParam( request, "Trn_zip")) + "&";
      sParams += "state=" + toURL(getParam( request, "Trn_state")) + "&";
      sParams += "category_id=" + toURL(getParam( request, "Trn_category_id"));
      String pPKitem_id = "";
      if (sAction.equalsIgnoreCase("cancel") ) {
        try {
          if ( stat != null ) stat.close();
          if ( conn != null ) conn.close();
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect (sActionFileName + sParams);
        return "sendRedirect";
      }

      final int iinsertAction = 1;
      final int iupdateAction = 2;
      final int ideleteAction = 3;
      int iAction = 0;

      if ( sAction.equalsIgnoreCase("insert") ) { iAction = iinsertAction; }
      if ( sAction.equalsIgnoreCase("update") ) { iAction = iupdateAction; }
      if ( sAction.equalsIgnoreCase("delete") ) { iAction = ideleteAction; }

      // Create WHERE statement


      String flditem_id="";
      String fldcategory_id="";

      // Load all form fields into variables
    

      sSQL = "";
      // Create SQL statement

      if ( sEntryViewErr.length() > 0 ) return sEntryViewErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        sEntryViewErr = e.toString(); return (sEntryViewErr);
      }
  
      try {
        if ( stat != null ) stat.close();
        if ( conn != null ) conn.close();
      }
      catch ( java.sql.SQLException ignore ) {}
      response.sendRedirect (sActionFileName + sParams);

      return "sendRedirect";
    }
    catch (Exception e) {out.println(e.toString()); }
    return (sEntryViewErr);
  }

  


  void EntryView_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sEntryViewErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
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
      
      String pitem_id = "";

      String fldcategory_id="";
      String fldname="";
      String fldaddress="";
      String fldcity="";
      String fldzip="";
      String fldstate="";
      String flditem_id="";
      String fldphone="";
      String fldemail="";
      String fldurl="";
      String fldnotes="";


      boolean bPK = true;

      if ( "".equals(sEntryViewErr)) {
        // Load primary key and form parameters
        fldaddress = getParam( request, "address");
        fldname = getParam( request, "name");
        fldcity = getParam( request, "city");
        fldzip = getParam( request, "zip");
        fldstate = getParam( request, "state");
        fldcategory_id = getParam( request, "category_id");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_address\" value=\""+getParam( request, "address")+"\">";
        transitParams += "Trn_address="+getParam( request, "address")+"&";
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_name\" value=\""+getParam( request, "name")+"\">";
        transitParams += "Trn_name="+getParam( request, "name")+"&";
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_city\" value=\""+getParam( request, "city")+"\">";
        transitParams += "Trn_city="+getParam( request, "city")+"&";
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_zip\" value=\""+getParam( request, "zip")+"\">";
        transitParams += "Trn_zip="+getParam( request, "zip")+"&";
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_state\" value=\""+getParam( request, "state")+"\">";
        transitParams += "Trn_state="+getParam( request, "state")+"&";
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_category_id\" value=\""+getParam( request, "category_id")+"\">";
        transitParams += "Trn_category_id="+getParam( request, "category_id")+"&";
        pitem_id = getParam( request, "item_id");
      }
      else {
        // Load primary key, form parameters and form fields
        flditem_id = getParam( request, "item_id");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_address\" value=\""+getParam( request, "Trn_address")+"\">";
        transitParams += "Trn_address="+getParam( request, "Trn_address")+"&";
        
        fldname = getParam( request, "Trn_name");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_name\" value=\""+getParam( request, "Trn_name")+"\">";
        transitParams += "Trn_name="+getParam( request, "Trn_name")+"&";
        
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_city\" value=\""+getParam( request, "Trn_city")+"\">";
        transitParams += "Trn_city="+getParam( request, "Trn_city")+"&";
        
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_zip\" value=\""+getParam( request, "Trn_zip")+"\">";
        transitParams += "Trn_zip="+getParam( request, "Trn_zip")+"&";
        
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_state\" value=\""+getParam( request, "Trn_state")+"\">";
        transitParams += "Trn_state="+getParam( request, "Trn_state")+"&";
        
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_category_id\" value=\""+getParam( request, "Trn_category_id")+"\">";
        transitParams += "Trn_category_id="+getParam( request, "Trn_category_id")+"&";
        
        pitem_id = getParam( request, "PK_item_id");
      }

      
      if ( isEmpty(pitem_id)) { bPK = false; }
      
      sWhere += "item_id=" + toSQL(pitem_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_item_id\" value=\""+pitem_id+"\"/>";

      sSQL = "select * from items where " + sWhere;


      out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">");
      out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#99CCFF\" colspan=\"2\"><font style=\"font-size: 12pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Entry</font></td>\n     </tr>");
      if ( ! sEntryViewErr.equals("")) {
        out.println("     <tr>\n      <td bgcolor=\"#F5F5F5\" colspan=\"2\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+sEntryViewErr+"</font></td>\n     </tr>");
      }
      sEntryViewErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"EntryView\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "EntryView".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        flditem_id = (String) rsHash.get("item_id");
        fldname = (String) rsHash.get("name");
        fldaddress = (String) rsHash.get("address");
        fldcity = (String) rsHash.get("city");
        fldstate = (String) rsHash.get("state");
        fldzip = (String) rsHash.get("zip");
        fldcategory_id = (String) rsHash.get("category_id");
        fldphone = (String) rsHash.get("phone");
        fldemail = (String) rsHash.get("email");
        fldurl = (String) rsHash.get("url");
        fldnotes = (String) rsHash.get("notes");

        if (sAction.equals("") || ! "EntryView".equals(sForm)) {
      
          flditem_id = (String) rsHash.get("item_id");
          fldname = (String) rsHash.get("name");
          fldaddress = (String) rsHash.get("address");
          fldcity = (String) rsHash.get("city");
          fldstate = (String) rsHash.get("state");
          fldzip = (String) rsHash.get("zip");
          fldcategory_id = (String) rsHash.get("category_id");
          fldphone = (String) rsHash.get("phone");
          fldemail = (String) rsHash.get("email");
          fldurl = (String) rsHash.get("url");
          fldnotes = (String) rsHash.get("notes");
        }
        else {
          flditem_id = (String) rsHash.get("item_id");
          fldname = (String) rsHash.get("name");
          fldaddress = (String) rsHash.get("address");
          fldcity = (String) rsHash.get("city");
          fldstate = (String) rsHash.get("state");
          fldzip = (String) rsHash.get("zip");
          fldcategory_id = (String) rsHash.get("category_id");
          fldphone = (String) rsHash.get("phone");
          fldemail = (String) rsHash.get("email");
          fldurl = (String) rsHash.get("url");
          fldnotes = (String) rsHash.get("notes");
        }
        
      }
      else {
        if ( "".equals(sEntryViewErr)) {
          fldname = toHTML(getParam(request,"name"));
          fldaddress = toHTML(getParam(request,"address"));
          fldcity = toHTML(getParam(request,"city"));
          fldstate = toHTML(getParam(request,"state"));
          fldzip = toHTML(getParam(request,"zip"));
          fldcategory_id = toHTML(getParam(request,"category_id"));
        }
      }
      
      // Set lookup fields
          fldcategory_id = dLookUp( stat, "pages", "name", "category_id=" + toSQL(fldcategory_id, adNumber));
      if ( "".equals(sEntryViewErr)) {
      
fldemail="<a href=mailto:" + fldemail + ">" + fldemail + "</a>";
      }


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Name</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldname)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Address</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldaddress)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">City</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldcity)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">State</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldstate)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">ZIP</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldzip)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Category</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldcategory_id)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Phone</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldphone)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">E-mail</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+fldemail+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">URL</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<a href=\""+(String) rsHash.get("url")+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+fldurl+"</font></a>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Notes</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+fldnotes+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "EntryView".equals(sForm))) {
        out.print("<input type=\"submit\" value=\"Back\" onclick=\"document.EntryView.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"EntryView\"><input type=\"hidden\" value=\"\" name=\"FormAction\">");
      }
      out.print("<input type=\"hidden\" name=\"item_id\" value=\""+toHTML(flditem_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %>
<%@ include file="Common.jsp" %><%!
//
//   Filename: MyAdRecord.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "MyAdRecord.jsp";
              
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

String cSec = checkSecurity(1, session, response, request);
if ("sendRedirect".equals(cSec) ) return;
                
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sRecordErr = "";

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
if ( sForm.equals("Record") ) {
  sRecordErr = RecordAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sRecordErr)) return;
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
<% Record_Show(request, response, session, out, sRecordErr, sForm, sAction, conn, stat); %>
    <SCRIPT Language="JavaScript">
if (document.forms["Record"])
document.Record.onsubmit=delconf;
function delconf() {
if (document.Record.FormAction.value == 'delete')
  return confirm('Delete record?');
}
</SCRIPT>
   </td>
  </tr>
 </table>
dfsdfdfdfdfdfdfdfdf</div></th>
    </tr>
  </table>
</div>
<div id="Layer1"><img src="imges/5.jpg" alt="5ad" width="694" height="344" /></div>

<jsp:include page="Footer.jsp" flush="true"/>
<jsp:include page="Addlogde.jsp"/>

</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!


  String RecordAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String sRecordErr ="";
    try {

      if (sAction.equals("")) return "";

      String sSQL="";
      String transitParams = "";
      String primaryKeyParams = "";
      String sQueryString = "";
      String sPage = "";
      String sParams = "";
      String sActionFileName = "MyClassifieds.jsp";
      String sWhere = " ";
      boolean bErr = false;
      long iCount = 0;

  
      sParams = "?";
      sParams += "category_id=" + toURL(getParam( request, "Trn_category_id"));
      String pPKad_id = "";
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

      if ( iAction == iupdateAction || iAction == ideleteAction ) { 
        pPKad_id = getParam( request, "PK_ad_id");
        if ( isEmpty(pPKad_id)) return sRecordErr;
        sWhere = "ad_id=" + toSQL(pPKad_id, adNumber);
      }


      String fldUserID="";
      String fldcategory_id="";
      String fldname="";
      String flddate_posted="";
      String fldprice="";
      String fldad_description="";
      String fldad_id="";

      // Load all form fields into variables
    
      fldUserID = (String) session.getAttribute("UserID");
      fldcategory_id = getParam( request, "Rqd_category_id");
      fldname = getParam(request, "name");
      flddate_posted = getParam(request, "date_posted");
      fldprice = getParam(request, "price");
      fldad_description = getParam(request, "ad_description");
      // Validate fields
      if ( iAction == iinsertAction || iAction == iupdateAction ) {
        if ( isEmpty(fldname) ) {
          sRecordErr = sRecordErr + "The value in field Name* is required.<br>";
        }
        if ( isEmpty(flddate_posted) ) {
          sRecordErr = sRecordErr + "The value in field Date Posted* is required.<br>";
        }
        if ( ! isNumber(fldprice)) {
          sRecordErr = sRecordErr + "The value in field Price is incorrect.<br>";
        }
        if (sRecordErr.length() > 0 ) {
          return (sRecordErr);
        }
      }


      sSQL = "";
      // Create SQL statement

      switch (iAction) {
  
        case iinsertAction :
          
            sSQL = "insert into ads (" + 
                "member_id," + 
                "category_id," +
                "name," +
                "date_posted," +
                "price," +
                "ad_description)" +

                " values (" + 
                toSQL(fldUserID, adNumber) + "," +
                toSQL(fldcategory_id, adNumber) + "," +
                toSQL(fldname, adText) + "," +
                toSQL(flddate_posted, adText) + "," +
                toSQL(fldprice, adNumber) + "," +
                toSQL(fldad_description, adText) + ")";
          break;
  
      case iupdateAction:
        
          sSQL = "update ads set " +
                "name=" + toSQL(fldname, adText) +
                ",date_posted=" + toSQL(flddate_posted, adText) +
                ",price=" + toSQL(fldprice, adNumber) +
                ",ad_description=" + toSQL(fldad_description, adText);
          sSQL = sSQL + " where " + sWhere;
        break;
      
      case ideleteAction:
           sSQL = "delete from ads where " + sWhere;
          
        break;
  
      }

      if ( sRecordErr.length() > 0 ) return sRecordErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        sRecordErr = e.toString(); return (sRecordErr);
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
    return (sRecordErr);
  }

  


  void Record_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sRecordErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
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
      String fldUserID="";
      String fldad_id="";
      String fldname="";
      String flddate_posted="";
      String fldprice="";
      String fldad_description="";


      boolean bPK = true;

      if ( "".equals(sRecordErr)) {
        // Load primary key and form parameters
        fldcategory_id = getParam( request, "category_id");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_category_id\" value=\""+getParam( request, "category_id")+"\">";
        transitParams += "Trn_category_id="+getParam( request, "category_id")+"&";
        requiredParams += "<input type=\"hidden\" name=\"Rqd_category_id\" value=\""+getParam( request, "category_id")+"\">";
        pad_id = getParam( request, "ad_id");
      }
      else {
        // Load primary key, form parameters and form fields
        fldad_id = getParam( request, "ad_id");
        fldname = getParam( request, "name");
        flddate_posted = getParam( request, "date_posted");
        fldprice = getParam( request, "price");
        fldad_description = getParam( request, "ad_description");
        requiredParams += "<input type=\"hidden\" name=\"Rqd_category_id\" value=\""+getParam( request, "Rqd_category_id")+"\">";
        fldcategory_id = getParam( request, "Trn_category_id");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_category_id\" value=\""+getParam( request, "Trn_category_id")+"\">";
        transitParams += "Trn_category_id="+getParam( request, "Trn_category_id")+"&";
        
        pad_id = getParam( request, "PK_ad_id");
      }

      
      if ( isEmpty(pad_id)) { bPK = false; }
      
      sWhere += "ad_id=" + toSQL(pad_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_ad_id\" value=\""+pad_id+"\"/>";

      sSQL = "select * from ads where " + sWhere;


      out.println("    <table >");
      out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"2\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">My Ad</font></td>\n     </tr>");
      if ( ! sRecordErr.equals("")) {
        out.println("     <tr>\n      <td bgcolor=\"#EEEEEE\" colspan=\"2\"><font face=\"arial\" size=\"2\">"+sRecordErr+"</font></td>\n     </tr>");
      }
      sRecordErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"Record\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "Record".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        fldad_id = (String) rsHash.get("ad_id");
        fldcategory_id = (String) rsHash.get("category_id");
        if ( "".equals(sRecordErr)) {
          // Load data from recordset when form displayed first time
          fldname = (String) rsHash.get("name");
          flddate_posted = (String) rsHash.get("date_posted");
          fldprice = (String) rsHash.get("price");
          fldad_description = (String) rsHash.get("ad_description");
        }

        if (sAction.equals("") || ! "Record".equals(sForm)) {
      
          fldad_id = (String) rsHash.get("ad_id");
          fldname = (String) rsHash.get("name");
          flddate_posted = (String) rsHash.get("date_posted");
          fldprice = (String) rsHash.get("price");
          fldcategory_id = (String) rsHash.get("category_id");
          fldad_description = (String) rsHash.get("ad_description");
        }
        else {
          fldad_id = (String) rsHash.get("ad_id");
          fldcategory_id = (String) rsHash.get("category_id");
        }
        
      }
      else {
        if ( "".equals(sRecordErr)) {
          fldcategory_id = toHTML(getParam(request,"category_id"));
        }
flddate_posted= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
      }
      
      // Set lookup fields
          fldcategory_id = dLookUp( stat, "categories", "name", "category_id=" + toSQL(fldcategory_id, adNumber));


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name*</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"50\" value=\""+toHTML(fldname)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Date Posted*</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"date_posted\" maxlength=\"10\" value=\""+toHTML(flddate_posted)+"\" size=\"10\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Price</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"price\" maxlength=\"50\" value=\""+toHTML(fldprice)+"\" size=\"10\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Category</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldcategory_id)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Description</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<textarea name=\"ad_description\" cols=\"50\" rows=\"4\">"+toHTML(fldad_description)+"</textarea>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "Record".equals(sForm))) {
        out.print("<input type=\"submit\" value=\"Update\" onclick=\"document.Record.FormAction.value = 'update';\">");out.print("<input type=\"submit\" value=\"Delete\" onclick=\"document.Record.FormAction.value = 'delete';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Record.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Record\"><input type=\"hidden\" value=\"update\" name=\"FormAction\">");
      }
      
      else {
        out.print("<input type=\"submit\" value=\"Insert\" onclick=\"document.Record.FormAction.value = 'insert';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Record.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Record\"><input type=\"hidden\" value=\"insert\" name=\"FormAction\">");
      }out.print("<input type=\"hidden\" name=\"ad_id\" value=\""+toHTML(fldad_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %>
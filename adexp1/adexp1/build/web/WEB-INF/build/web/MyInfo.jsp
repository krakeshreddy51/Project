<%@ include file="Common.jsp" %><%!
//
//   Filename: MyInfo.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "MyInfo.jsp";
              
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
    
   </td>
  </tr>
 </table>
dfsdfdfdfdfdfdfdfdf</div></th>
    </tr>
  </table>
</div>
<div id="Layer1"><img src="imges/add4.jpg" alt="olig" width="694" height="344" /></div>

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

  
      String pPKmember_id = "";
      if (sAction.equalsIgnoreCase("cancel") ) {
        try {
          if ( stat != null ) stat.close();
          if ( conn != null ) conn.close();
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect (sActionFileName);
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
        pPKmember_id = getParam( request, "PK_member_id");
        if ( isEmpty(pPKmember_id)) return sRecordErr;
        sWhere = "member_id=" + toSQL(pPKmember_id, adNumber);
      }


      String fldUserID="";
      String fldname="";
      String fldmember_password="";
      String fldemail="";
      String fldlocation="";
      String fldhome_phone="";
      String fldwork_phone="";
      String fldmember_id="";

      // Load all form fields into variables
    
      fldUserID = (String) session.getAttribute("UserID");
      fldname = getParam(request, "name");
      fldmember_password = getParam(request, "member_password");
      fldemail = getParam(request, "email");
      fldlocation = getParam(request, "location");
      fldhome_phone = getParam(request, "home_phone");
      fldwork_phone = getParam(request, "work_phone");

      sSQL = "";
      // Create SQL statement

      switch (iAction) {
  
      case iupdateAction:
        
          sSQL = "update members set " +
                "name=" + toSQL(fldname, adText) +
                ",member_password=" + toSQL(fldmember_password, adText) +
                ",email=" + toSQL(fldemail, adText) +
                ",location=" + toSQL(fldlocation, adText) +
                ",home_phone=" + toSQL(fldhome_phone, adText) +
                ",work_phone=" + toSQL(fldwork_phone, adText);
          sSQL = sSQL + " where " + sWhere;
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
      response.sendRedirect (sActionFileName);

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
      

      String fldUserID="";
      String fldmember_id="";
      String fldname="";
      String fldmember_password="";
      String fldemail="";
      String fldlocation="";
      String fldhome_phone="";
      String fldwork_phone="";
      String fldmember_login="";


      boolean bPK = true;

      if ( "".equals(sRecordErr)) {
        // Load primary key and form parameters
      }
      else {
        // Load primary key, form parameters and form fields
        fldmember_id = getParam( request, "member_id");
        fldname = getParam( request, "name");
        fldmember_password = getParam( request, "member_password");
        fldemail = getParam( request, "email");
        fldlocation = getParam( request, "location");
        fldhome_phone = getParam( request, "home_phone");
        fldwork_phone = getParam( request, "work_phone");
      }

      
      String pmember_id = (String) session.getAttribute("UserID");
      if ( isEmpty(pmember_id)) { bPK = false; }
      
      sWhere += "member_id=" + toSQL(pmember_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_member_id\" value=\""+pmember_id+"\"/>";

      sSQL = "select * from members where " + sWhere;


      out.println("    <table >");
      out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"2\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">My Info</font></td>\n     </tr>");
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
        fldmember_id = (String) rsHash.get("member_id");
        fldmember_login = (String) rsHash.get("member_login");
        if ( "".equals(sRecordErr)) {
          // Load data from recordset when form displayed first time
          fldname = (String) rsHash.get("name");
          fldmember_password = (String) rsHash.get("member_password");
          fldemail = (String) rsHash.get("email");
          fldlocation = (String) rsHash.get("location");
          fldhome_phone = (String) rsHash.get("home_phone");
          fldwork_phone = (String) rsHash.get("work_phone");
        }

        if (sAction.equals("") || ! "Record".equals(sForm)) {
      
          fldmember_id = (String) rsHash.get("member_id");
          fldmember_login = (String) rsHash.get("member_login");
          fldname = (String) rsHash.get("name");
          fldmember_password = (String) rsHash.get("member_password");
          fldemail = (String) rsHash.get("email");
          fldlocation = (String) rsHash.get("location");
          fldhome_phone = (String) rsHash.get("home_phone");
          fldwork_phone = (String) rsHash.get("work_phone");
        }
        else {
          fldmember_id = (String) rsHash.get("member_id");
          fldmember_login = (String) rsHash.get("member_login");
        }
        
      }
      else {
        if ( "".equals(sRecordErr)) {
          fldmember_id = toHTML((String) session.getAttribute("UserID"));
        }
      }
      


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Login</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldmember_login)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"50\" value=\""+toHTML(fldname)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Password</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"password\"  name=\"member_password\" maxlength=\"20\" value=\""+toHTML(fldmember_password)+"\" size=\"20\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">E-mail</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"email\" maxlength=\"50\" value=\""+toHTML(fldemail)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Location</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<textarea name=\"location\" cols=\"50\" rows=\"3\">"+toHTML(fldlocation)+"</textarea>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Home Phone</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"home_phone\" maxlength=\"50\" value=\""+toHTML(fldhome_phone)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Work Phone</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"work_phone\" maxlength=\"50\" value=\""+toHTML(fldwork_phone)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "Record".equals(sForm))) {
        out.print("<input type=\"submit\" value=\"Update\" onclick=\"document.Record.FormAction.value = 'update';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Record.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Record\"><input type=\"hidden\" value=\"update\" name=\"FormAction\">");
      }
      
      else {
        out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Record.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Record\"><input type=\"hidden\" value=\"insert\" name=\"FormAction\">");
      }out.print("<input type=\"hidden\" name=\"member_id\" value=\""+toHTML(fldmember_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %>
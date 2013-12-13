<%@ include file="Common.jsp" %>




<%!
//
//   Filename: Registration.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "Registration.jsp";
              
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
String sFormErr = "";

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
if ( sForm.equals("Form") ) {
  sFormErr = FormAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sFormErr)) return;
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
 <div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">
<% Form_Show(request, response, session, out, sFormErr, sForm, sAction, conn, stat); %>
    
     dfsdfdfdfdfdfdfdfdf</div></th>
    </tr>
  </table>
</div>
<jsp:include page="Footer.jsp" flush="true"/>
<div id="Layer1"><img src="imges/Reklama-3D-vizualizacija.jpg" alt="reg" width="694" height="344" /></div>

</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!


  String FormAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String sFormErr ="";
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

      final int iinsertAction = 1;
      final int iupdateAction = 2;
      final int ideleteAction = 3;
      int iAction = 0;

      if ( sAction.equalsIgnoreCase("insert") ) { iAction = iinsertAction; }
      if ( sAction.equalsIgnoreCase("update") ) { iAction = iupdateAction; }
      if ( sAction.equalsIgnoreCase("delete") ) { iAction = ideleteAction; }

      // Create WHERE statement


      String fldmember_login="";
      String fldmember_password="";
      String fldname="";
      String fldemail="";
      String fldlocation="";
      String fldwork_phone="";
      String fldhome_phone="";
      String fldmember_id="";

      // Load all form fields into variables
    
      fldmember_login = getParam(request, "member_login");
      fldmember_password = getParam(request, "member_password");
      fldname = getParam(request, "name");
      fldemail = getParam(request, "email");
      fldlocation = getParam(request, "location");
      fldwork_phone = getParam(request, "work_phone");
      fldhome_phone = getParam(request, "home_phone");
      // Validate fields
      if ( iAction == iinsertAction || iAction == iupdateAction ) {
        if ( isEmpty(fldmember_login) ) {
          sFormErr = sFormErr + "The value in field Login* is required.<br>";
        }
        if ( isEmpty(fldmember_password) ) {
          sFormErr = sFormErr + "The value in field Password* is required.<br>";
        }
        if ( isEmpty(fldname) ) {
          sFormErr = sFormErr + "The value in field Name* is required.<br>";
        }
        if ( isEmpty(fldemail) ) {
          sFormErr = sFormErr + "The value in field E-mail* is required.<br>";
        }
        if ( ! isEmpty(fldmember_login)) {
          iCount = 0;
          if ( iAction == iinsertAction ) {
            iCount = dCountRec(stat, "members", "member_login=" + toSQL(fldmember_login, adText));
          }
          else {
            if ( iAction == iupdateAction ) {
              iCount = dCountRec( stat, "members", "member_login=" + toSQL(fldmember_login, adText) + " and not(" + sWhere + ")");
            }
          }
          if (iCount > 0) {
            sFormErr = sFormErr + "The value in field Login* is already in database.<br>";
          }
        }
        if (sFormErr.length() > 0 ) {
          return (sFormErr);
        }
      }


      sSQL = "";
      // Create SQL statement

      switch (iAction) {
  
        case iinsertAction :
          
            sSQL = "insert into members (" + 
                "member_login," +
                "member_password," +
                "name," +
                "email," +
                "location," +
                "work_phone," +
                "home_phone)" +

                " values (" + 
                toSQL(fldmember_login, adText) + "," +
                toSQL(fldmember_password, adText) + "," +
                toSQL(fldname, adText) + "," +
                toSQL(fldemail, adText) + "," +
                toSQL(fldlocation, adText) + "," +
                toSQL(fldwork_phone, adText) + "," +
                toSQL(fldhome_phone, adText) + ")";
          break;
  
      }

      if ( sFormErr.length() > 0 ) return sFormErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        sFormErr = e.toString(); return (sFormErr);
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
    return (sFormErr);
  }

  


  void Form_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sFormErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
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
      
      String pmember_id = "";

      String fldmember_id="";
      String fldmember_login="";
      String fldmember_password="";
      String fldname="";
      String fldemail="";
      String fldlocation="";
      String fldwork_phone="";
      String fldhome_phone="";


      boolean bPK = true;

      if ( "".equals(sFormErr)) {
        // Load primary key and form parameters
        pmember_id = getParam( request, "member_id");
      }
      else {
        // Load primary key, form parameters and form fields
        fldmember_id = getParam( request, "member_id");
        fldmember_login = getParam( request, "member_login");
        fldmember_password = getParam( request, "member_password");
        fldname = getParam( request, "name");
        fldemail = getParam( request, "email");
        fldlocation = getParam( request, "location");
        fldwork_phone = getParam( request, "work_phone");
        fldhome_phone = getParam( request, "home_phone");
        pmember_id = getParam( request, "PK_member_id");
      }

      
      if ( isEmpty(pmember_id)) { bPK = false; }
      
      sWhere += "member_id=" + toSQL(pmember_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_member_id\" value=\""+pmember_id+"\"/>";

      sSQL = "select * from members where " + sWhere;


      out.println("    <table >");
      out.println("     <tr>\n      <td  align=\"center\" colspan=\"2\"><font face=\"arial\" color=\"#eeeeee\" style=\"font:bold\">Registration</font></td>\n     </tr>");
      if ( ! sFormErr.equals("")) {
        out.println("     <tr>\n      <td bgcolor=\"#ffffff\" colspan=\"2\"><font color=\"#FF0000\" face=\"arial\" size=\"2\">"+sFormErr+"</font></td>\n     </tr>");
      }
      sFormErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"Form\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "Form".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        fldmember_id = (String) rsHash.get("member_id");
        if ( "".equals(sFormErr)) {
          // Load data from recordset when form displayed first time
          fldmember_login = (String) rsHash.get("member_login");
          fldmember_password = (String) rsHash.get("member_password");
          fldname = (String) rsHash.get("name");
          fldemail = (String) rsHash.get("email");
          fldlocation = (String) rsHash.get("location");
          fldwork_phone = (String) rsHash.get("work_phone");
          fldhome_phone = (String) rsHash.get("home_phone");
        }

        if (sAction.equals("") || ! "Form".equals(sForm)) {
      
          fldmember_id = (String) rsHash.get("member_id");
          fldmember_login = (String) rsHash.get("member_login");
          fldmember_password = (String) rsHash.get("member_password");
          fldname = (String) rsHash.get("name");
          fldemail = (String) rsHash.get("email");
          fldlocation = (String) rsHash.get("location");
          fldwork_phone = (String) rsHash.get("work_phone");
          fldhome_phone = (String) rsHash.get("home_phone");
        }
        
      }
      else {
      }
      


      // Show form field
      
      out.print("     <tr>\n      <td  ><font color=\"#FFFFFF\"face=\"arial\" size=\"2\" style=\"font:bold\">Login*</font></td><td   >"); out.print("<input type=\"text\"  name=\"member_login\" maxlength=\"20\" value=\""+toHTML(fldmember_login)+"\" size=\"20\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td  ><font color=\"#FFFFFF\"face=\"arial\" size=\"2\" style=\"font:bold\">Password*</font></td><td   >"); out.print("<input type=\"password\"  name=\"member_password\" maxlength=\"20\" value=\""+toHTML(fldmember_password)+"\" size=\"20\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td  ><font color=\"#FFFFFF\"face=\"arial\" size=\"2\" style=\"font:bold\">Name*</font></td><td   >"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"50\" value=\""+toHTML(fldname)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td  ><font color=\"#FFFFFF\"face=\"arial\" size=\"2\" style=\"font:bold\">E-mail*</font></td><td   >"); out.print("<input type=\"text\"  name=\"email\" maxlength=\"50\" value=\""+toHTML(fldemail)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td  ><font color=\"#FFFFFF\"face=\"arial\" size=\"2\" style=\"font:bold\">Location</font></td><td   >"); out.print("<textarea name=\"location\" cols=\"50\" rows=\"2\">"+toHTML(fldlocation)+"</textarea>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td  ><font color=\"#FFFFFF\"face=\"arial\" size=\"2\" style=\"font:bold\">Work Phone</font></td><td   >"); out.print("<input type=\"text\"  name=\"work_phone\" maxlength=\"50\" value=\""+toHTML(fldwork_phone)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td ><font color=\"#FFFFFF\"face=\"arial\" size=\"2\" style=\"font:bold\">Home Phone</font></td><td   >"); out.print("<input type=\"text\"  name=\"home_phone\" maxlength=\"50\" value=\""+toHTML(fldhome_phone)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "Form".equals(sForm))) {
        
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Form\"><input type=\"hidden\" value=\"\" name=\"FormAction\">");
      }
      
      else {
        out.print("<input type=\"submit\" value=\"Register\" onclick=\"document.Form.FormAction.value = 'insert';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Form\"><input type=\"hidden\" value=\"insert\" name=\"FormAction\">");
      }out.print("<input type=\"hidden\" name=\"member_id\" value=\""+toHTML(fldmember_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %>
  
  <jsp:include page="Addlogde.jsp"/>
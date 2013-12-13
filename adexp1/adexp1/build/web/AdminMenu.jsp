<%@ include file="Common.jsp" %><%!
//
//   Filename: AdminMenu.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "AdminMenu.jsp";
              
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

String cSec = checkSecurity(3, session, response, request);
if ("sendRedirect".equals(cSec) ) return;
                
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sMenuErr = "";

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
<% Menu_Show(request, response, session, out, sMenuErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
</div></th>
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

  void Menu_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sMenuErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
  
      out.println("    <table >");
      out.println("     <tr>\n      <td  bgcolor=\"#808080\" align=\"center\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Administration</font></td>\n     </tr>");
      out.print("     <tr>");
      // Set URLs
      
      String fldField1 = "Members.jsp";
      String fldField2 = "Categories.jsp";
      // Show fields
      
      out.print("\n      <td bgcolor=\"#EEEEEE\"><a href=\""+fldField1+"\"><font face=\"arial\" size=\"2\">Members</font></a></td>\n\n      </tr>\n\n      <tr>");
      out.print("\n      <td bgcolor=\"#EEEEEE\"><a href=\""+fldField2+"\"><font face=\"arial\" size=\"2\">Categories</font></a></td>");

      out.println("\n     </tr>\n    </table>");
  
    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
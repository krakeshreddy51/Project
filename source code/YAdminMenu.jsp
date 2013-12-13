<%@ include file="YCommon.jsp" %><%!
//
//   Filename: AdminMenu.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "YAdminMenu.jsp";
              
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

String cSec = checkSecurity(3, session, response, request);
if ("sendRedirect".equals(cSec) ) return;
                
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sAdminErr = "";
String sLoginErr = "";

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
if ( sForm.equals("Login") ) {
  sLoginErr = LoginAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sLoginErr)) return;
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
<% Admin_Show(request, response, session, out, sAdminErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
 <table>
  <tr>
   <td valign="top">
<% //Login_Show(request, response, session, out, sLoginErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
           dfsdfdfdfdfdfdfdfdf
          </div></th>
    </tr>
  </table>
</div>
<jsp:include page="Addlogde.jsp"/>
<jsp:include page="Footer.jsp"/>


<center><font face="Arial"></small></font></center>
</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!

  void Admin_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAdminErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
  
      out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">");
      out.println("     <tr>\n      <td  align=\"center\" bgcolor=\"#99CCFF\"><font style=\"font-size: 12pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Administartion</font></td>\n     </tr>");
      out.print("     <tr>");
      // Set URLs
      
      String fldField1 = "YAdminEntriesGrid.jsp";
      String fldField2 = "YAdminUsersGrid.jsp";
      String fldField3 = "YAdminCategoriesGrid.jsp";
      // Show fields
      
      out.print("\n      <td bgcolor=\"#F5F5F5\"><a href=\""+fldField1+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Entries</font></a></td>\n\n      </tr>\n\n      <tr>");
      out.print("\n      <td bgcolor=\"#F5F5F5\"><a href=\""+fldField3+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">pages</font></a></td>");

      out.println("\n     </tr>\n    </table>");
  
    }
    catch (Exception e) { out.println(e.toString()); }
  }


  String LoginAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    String sLoginErr = "";
    try {
      final int iloginAction = 1;
      final int ilogoutAction = 2;
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      String sSQL="";
      int iAction = 0;

      if ( sAction.equals("login") )  iAction = iloginAction;
      if ( sAction.equals("logout") ) iAction = ilogoutAction;

      switch (iAction) {
        case iloginAction: {
          // Login action
         
          String sLogin = getParam( request, "Login");
          String sPassword = getParam( request, "Password");
          java.sql.ResultSet rs = null;
          rs = openrs( stat, "select user_id, user_level from members where user_login =" + toSQL(sLogin, adText) + " and user_password=" + toSQL(sPassword, adText));
          
          if ( rs.next() ) {
            // Login and password passed
            session.setAttribute("UserID", rs.getString(1));
            
            session.setAttribute("UserRights", rs.getString(2));
            sQueryString = getParam( request, "querystring");
            sPage = getParam( request, "ret_page");
            if ( ! sPage.equals(request.getRequestURI() ) && ! "".equals(sPage)) {
              try {
                if ( stat != null ) stat.close();
                if ( conn != null ) conn.close();
              }
              catch ( java.sql.SQLException ignore ) {}
              response.sendRedirect(sPage + "?" + sQueryString);
              return "sendRedirect";
            }
            
          }
          else sLoginErr = "Login or Password is incorrect.";
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
    }
    catch (Exception e) { out.println(e.toString()); }
    return (sLoginErr);
  }

  void Login_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sLoginErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {

  
      String sSQL="";
      String transitParams = "";
      String sQueryString = getParam( request, "querystring");
      String sPage = getParam( request, "ret_page");
  
      out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\" border=1>");
      out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#99CCFF\" colspan=\"2\"><font style=\"font-size: 12pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Login</font></td>\n     </tr>");

      if ( sLoginErr.compareTo("") != 0 ) {
        out.println("     <tr>\n      <td colspan=\"2\" bgcolor=\"#F5F5F5\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+sLoginErr+"</font></td>\n     </tr>");
      }
      sLoginErr="";
      out.println("     <form action=\""+sFileName+"\" method=\"POST\">");
      out.println("     <input type=\"hidden\" name=\"FormName\" value=\"Login\">");
      if ( session.getAttribute("UserID") == null || ((String) session.getAttribute("UserID")).compareTo("") == 0 ) {
        // User did not login
        out.println("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Login</font></td><td bgcolor=\"#F5F5F5\"><input type=\"text\" name=\"Login\" maxlength=\"50\" value=\""+toHTML(getParam( request, "Login"))+"\"></td>\n     </tr>");
        out.println("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Password</font></td><td bgcolor=\"#F5F5F5\"><input type=\"password\" name=\"Password\" maxlength=\"50\"></td>\n     </tr>");
        out.print("     <tr>\n      <td colspan=\"2\"><input type=\"hidden\" name=\"FormAction\" value=\"login\"><input type=\"submit\" value=\"Login\">");
        out.println("<input type=\"hidden\" name=\"ret_page\" value=\""+sPage+"\"><input type=\"hidden\" name=\"querystring\" value=\""+sQueryString+"\"></td>\n     </form>\n     </tr>");
      }
      else {
        // User logged in
        String sUserID = dLookUp( stat, "members", "user_login", "user_id =" + session.getAttribute("UserID"));
        out.print("     <tr><td bgcolor=\"#F5F5F5\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+sUserID+"&nbsp;&nbsp;"+"</font><input type=\"hidden\" name=\"FormAction\" value=\"logout\"/><input type=\"submit\" value=\"Logout\"/>");
        out.print("<input type=\"hidden\" name=\"ret_page\" value=\""+sPage+"\"><input type=\"hidden\" name=\"querystring\" value=\""+sQueryString+"\">");
        out.println("</td>\n     </form>\n     </tr>");
      }
      out.println("    </table>");
  

    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
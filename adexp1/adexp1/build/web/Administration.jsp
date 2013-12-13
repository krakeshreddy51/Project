<%@ include file="TCommon.jsp" %><%!
//
//   Filename: Administration.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "Administration.jsp";
              
static final String PageBODY = "bgcolor=\"#ffffff\"";
static final String FormTABLE = "bgcolor=\"#FFFFFF\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\"";
static final String FormHeaderTD = "bgcolor=\"#1262C4\" align=\"center\"";
static final String FormHeaderFONT = "face=\"tahoma\" style=\"font: bold\" size=\"2\" color=\"#ffffff\"";
static final String FieldCaptionTD = "bgcolor=\"#92BBEE\"";
static final String FieldCaptionFONT = "face=\"tahoma\" size=\"2\" color=\"#000000\"";
static final String DataTD = "bgcolor=\"#F2F8FF\"";
static final String DataFONT = "face=\"tahoma\" size=\"2\"";
static final String ColumnFONT = "face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\"";
static final String ColumnTD = "bgcolor=\"#92BBEE\"";
%><%

String cSec = checkSecurity(3, session, response, request);
if ("sendRedirect".equals(cSec) ) return;
                
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sAdministrationErr = "";
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
<title>Administration</title>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body bgcolor="#ffffff">
<jsp:include page="Header.jsp" flush="true"/>
<div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">

<jsp:include page="THeader.jsp" flush="true"/>
 <table>
  <tr>
   
   <td valign="top">
<% Administration_Show(request, response, session, out, sAdministrationErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
 <table>
  <tr>
   <td valign="top">
<% Login_Show(request, response, session, out, sLoginErr, sForm, sAction, conn, stat); %>
    
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

  void Administration_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAdministrationErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
  
      out.println("    <table bgcolor=\"#FFFFFF\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">");
      out.println("     <tr>\n      <td  bgcolor=\"#1262C4\" align=\"center\"><font face=\"tahoma\" style=\"font: bold\" size=\"2\" color=\"#ffffff\">Administration</font></td>\n     </tr>");
      out.print("     <tr>");
      // Set URLs
      
      String fldemployees = "EmployeeList.jsp";
      String fldpriorities = "PrioritiesList.jsp";
      String fldprojects = "ProjectList.jsp";
      String fldstatus = "StatusList.jsp";
      // Show fields
      
      out.print("\n      <td bgcolor=\"#F2F8FF\"><a href=\""+fldpriorities+"\"><font face=\"tahoma\" size=\"2\">Priorities</font></a></td>\n\n      </tr>\n\n      <tr>");
      out.print("\n      <td bgcolor=\"#F2F8FF\"><a href=\""+fldprojects+"\"><font face=\"tahoma\" size=\"2\">Clients</font></a></td>\n\n      </tr>\n\n      <tr>");
      out.print("\n      <td bgcolor=\"#F2F8FF\"><a href=\""+fldstatus+"\"><font face=\"tahoma\" size=\"2\">Statuses</font></a></td>");

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
          rs = openrs( stat, "select employee_id, security_level from employees where login =" + toSQL(sLogin, adText) + " and pass=" + toSQL(sPassword, adText));
          
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
  
      out.println("    <table bgcolor=\"#FFFFFF\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\" border=1>");
      out.println("     <tr>\n      <td bgcolor=\"#1262C4\" align=\"center\" colspan=\"2\"><font face=\"tahoma\" style=\"font: bold\" size=\"2\" color=\"#ffffff\">Login</font></td>\n     </tr>");

      if ( sLoginErr.compareTo("") != 0 ) {
        out.println("     <tr>\n      <td colspan=\"2\" bgcolor=\"#F2F8FF\"><font face=\"tahoma\" size=\"2\">"+sLoginErr+"</font></td>\n     </tr>");
      }
      sLoginErr="";
      out.println("     <form action=\""+sFileName+"\" method=\"POST\">");
      out.println("     <input type=\"hidden\" name=\"FormName\" value=\"Login\">");
      if ( session.getAttribute("UserID") == null || ((String) session.getAttribute("UserID")).compareTo("") == 0 ) {
        // User did not login
        out.println("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Login</font></td><td bgcolor=\"#F2F8FF\"><input type=\"text\" name=\"Login\" maxlength=\"50\" value=\""+toHTML(getParam( request, "Login"))+"\"></td>\n     </tr>");
        out.println("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Password</font></td><td bgcolor=\"#F2F8FF\"><input type=\"password\" name=\"Password\" maxlength=\"50\"></td>\n     </tr>");
        out.print("     <tr>\n      <td colspan=\"2\"><input type=\"hidden\" name=\"FormAction\" value=\"login\"><input type=\"submit\" value=\"Login\">");
        out.println("<input type=\"hidden\" name=\"ret_page\" value=\""+sPage+"\"><input type=\"hidden\" name=\"querystring\" value=\""+sQueryString+"\"></td>\n     </form>\n     </tr>");
      }
      else {
        // User logged in
        String sUserID = dLookUp( stat, "employees", "login", "employee_id =" + session.getAttribute("UserID"));
        out.print("     <tr><td bgcolor=\"#F2F8FF\"><font face=\"tahoma\" size=\"2\">"+sUserID+"&nbsp;&nbsp;"+"</font><input type=\"hidden\" name=\"FormAction\" value=\"logout\"/><input type=\"submit\" value=\"Logout\"/>");
        out.print("<input type=\"hidden\" name=\"ret_page\" value=\""+sPage+"\"><input type=\"hidden\" name=\"querystring\" value=\""+sQueryString+"\">");
        out.println("</td>\n     </form>\n     </tr>");
      }
      out.println("    </table>");
  

    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
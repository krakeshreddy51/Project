<%@ include file="TCommon.jsp" %>
<%!
//
//   Filename: Header.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "THeader.jsp";
              
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
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sMenuErr = "";

java.sql.Connection conn = null;
java.sql.Statement stat = null;
conn = cn();
stat = conn.createStatement();
%><center>
 <table>
  <tr>
   <td valign="top"><table border="0" cellspacing="0" cellpadding="0" width="506">
<tr><td>
<% Menu_Show(request, response, session, out, sMenuErr, sForm, sAction, conn, stat); %>   </td>
</tr>
</table><br>
   </td>
  </tr>
 </table>

<%!

  void Menu_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sMenuErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
  
      out.println("    <table bgcolor=\"#FFFFFF\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">");
      
      out.print("     <tr>");
      // Set URLs
      
      String fldField1 = "TDefault.jsp";
      String fldField2 = "TaskRecord.jsp";
      String fldField3 = "Administration.jsp";
      // Show fields
      
      out.print("\n      <td bgcolor=\"#F2F8FF\"><a href=\""+fldField1+"\"><font face=\"tahoma\" size=\"2\">Task List</font></a></td>");
      out.print("\n      <td bgcolor=\"#F2F8FF\"><a href=\""+fldField2+"\"><font face=\"tahoma\" size=\"2\">Add Task</font></a></td>");
      out.print("\n      <td bgcolor=\"#F2F8FF\"><a href=\""+fldField3+"\"><font face=\"tahoma\" size=\"2\">Administrator</font></a></td>");

      out.println("\n     </tr>\n    </table>");
  
    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
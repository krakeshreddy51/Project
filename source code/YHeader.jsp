<%@ include file="YCommon.jsp" %><%!
//
//   Filename: Header.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "YHeader.jsp";
              
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
String sHeaderErr = "";

java.sql.Connection conn = null;
java.sql.Statement stat = null;
conn = cn();
stat = conn.createStatement();
%>
 <table>
  <tr>
   <td valign="top">
<% Header_Show(request, response, session, out, sHeaderErr, sForm, sAction, conn, stat); %>   
   </td>
  </tr>
 </table>

<%!

  void Header_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sHeaderErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
  
      out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">");
      
      out.print("     <tr>");
      // Set URLs
      
      String fldField3 = "YDefault.jsp";
      String fldField1 = "YDefault.jsp";
      String fldField2 = "YAdminMenu.jsp";
      // Show fields
      
      out.print("\n      <td bgcolor=\"#F5F5F5\"><a href=\""+fldField1+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Home</font></a></td>");
      out.print("\n      <td bgcolor=\"#F5F5F5\"><a href=\""+fldField2+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Administration</font></a></td>");

      out.println("\n     </tr>\n    </table>");
  
    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
<%@ include file="Common.jsp" %><%!
//
//   Filename: AdvSearch.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "AdvSearch.jsp";
              
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

 <div id="Layer22">
  <table width="693" height="348" border="0">
    <tr>
        <td><% Form_Show(request, response, session, out, sFormErr, sForm, sAction, conn, stat); %>
  </td>
    </tr>
  </table>
</div>
  <div id="Layer1"><img src="imges/Poligrafija-Bukleti.jpg" alt="olig" width="694" height="344" /></div>

   
  

<jsp:include page="Footer.jsp" flush="true"/>
</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!

  void Form_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sFormErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
      

      String fldname="";
      String fldpricemin="";
      String fldpricemax="";
      String fldFormAds_Sorting="";


      String sSQL="";
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      

      out.println("    <table >");
      out.println("     <tr>\n      <td  align=\"center\" colspan=\"9\"><a name=\"Form\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Advanced Search</font></a></td>\n     </tr>");
      out.println("     <form method=\"get\" action=\"AdsGrid.jsp\" name=\"Form\">\n     <tr>");
      // Set variables with search parameters
      
      fldname = getParam( request, "name");
      fldpricemin = getParam( request, "pricemin");
      fldpricemax = getParam( request, "pricemax");
      fldFormAds_Sorting = getParam( request, "FormAds_Sorting");

      // Show fields
      

      out.println("      <td ><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></td>");
      out.print("      <td >"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"\" value=\""+toHTML(fldname)+"\" size=\"\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td ><font face=\"arial\" size=\"2\" style=\"font:bold\">Price more then</font></td>");
      out.print("      <td >"); out.print("<input type=\"text\"  name=\"pricemin\" maxlength=\"\" value=\""+toHTML(fldpricemin)+"\" size=\"\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td><font face=\"arial\" size=\"2\" style=\"font:bold\">Price less then</font></td>");
      out.print("      <td >"); out.print("<input type=\"text\"  name=\"pricemax\" maxlength=\"\" value=\""+toHTML(fldpricemax)+"\" size=\"\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td ><font face=\"arial\" size=\"2\" style=\"font:bold\">Order by</font></td>");
      out.print("      <td >"); 
      out.print("<select name=\"FormAds_Sorting\">"+getOptionsLOV(";;2;Title;3;Category;4;Member;5;Price",true,false,fldFormAds_Sorting)+"</select>");
       out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td align=\"right\" colspan=\"3\"><input type=\"submit\" value=\"Search\"/></td>");
      out.println("     </tr>\n     </form>\n    </table>");
      out.println("");
    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
<%@ include file="Common.jsp" %><%!
//
//   Filename: Members.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "Members.jsp";
              
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
String sGridErr = "";
String sSearchErr = "";

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
<% Search_Show(request, response, session, out, sSearchErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
 <table>
  <tr>
   <td valign="top">
<% Grid_Show(request, response, session, out, sGridErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
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

  void Grid_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sGridErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
    String sWhere = "";
    int iCounter=0;
    int iPage = 0;
    boolean bIsScroll = true;
    boolean hasParam = false;
    String sOrder = "";
    String sSQL="";
    String transitParams = "";
    String sQueryString = "";
    String sPage = "";
    int RecordsPerPage = 20;
    String sSortParams = "";
    String formParams = "";

      String pname="";


    transitParams = "name=" + toURL(getParam( request, "name")) + "&";
    formParams = "name=" + toURL(getParam( request, "name")) + "&"; 
    // Build WHERE statement
    // Check Grid parameter and create a valid sql for where clause 
   
    pname = getParam( request, "name");


    if ( ! pname.equals("") ) { 
      hasParam = true;
      sWhere = "m.member_login like '%" + replace(pname, "'", "''") + "%'" + " or " + "m.name like '%" + replace(pname, "'", "''") + "%'";}
    if (hasParam) { sWhere = " WHERE (" + sWhere + ")"; }
    // Build ORDER statement
    String sSort = getParam( request, "FormGrid_Sorting");
    String sSorted = getParam( request, "FormGrid_Sorted");
    String sDirection = "";
    String sForm_Sorting = "";
    int iSort = 0;
    try {
      iSort = Integer.parseInt(sSort);
    }
    catch (NumberFormatException e ) {
      sSort = "";
    }
    if ( iSort == 0 ) {
      sForm_Sorting = "";
    }
    else {
      if ( sSort.equals(sSorted)) { 
        sSorted="0";
        sForm_Sorting = "";
        sDirection = " DESC";
        sSortParams = "FormGrid_Sorting=" + sSort + "&FormGrid_Sorted=" + sSort + "&";
      }
      else {
        sSorted=sSort;
        sForm_Sorting = sSort;
        sDirection = " ASC";
        sSortParams = "FormGrid_Sorting=" + sSort + "&FormGrid_Sorted=" + "&";
      }
    
      if ( iSort == 1) { sOrder = " order by m.member_login" + sDirection; }
      if ( iSort == 2) { sOrder = " order by m.name" + sDirection; }
      if ( iSort == 3) { sOrder = " order by m.member_level" + sDirection; }
    }
  

  // Build full SQL statement
  
  sSQL = "select m.member_id as m_member_id, " +
    "m.member_level as m_member_level, " +
    "m.member_login as m_member_login, " +
    "m.name as m_name " +
    " from members m ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"4\" bgcolor=\"#EEEEEE\"><font face=\"arial\" size=\"2\">No records</font></td>\n     </tr>";


  String tableHeader = "";
      tableHeader = "     <tr>\n      <td bgcolor=\"#CCCCCC\"><a &\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Edit</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=1&FormGrid_Sorted="+sSorted+"&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Login</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=2&FormGrid_Sorted="+sSorted+"&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=3&FormGrid_Sorted="+sSorted+"&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Member Level</font></a></td>\n     </tr>";
  
  
  try {
    out.println("    <table >");
    out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"4\"><a name=\"Grid\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Members</font></a></td>\n     </tr>");
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    // Select current page
    iPage = Integer.parseInt(getParam( request, "FormGrid_Page"));
  }
  catch (NumberFormatException e ) {
    iPage = 0;
  }

  if (iPage == 0) { iPage = 1; }
  RecordsPerPage = 20;
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, sSQL);
    iCounter = 0;
    absolute (rs, (iPage-1)*RecordsPerPage+1);
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( (iCounter < RecordsPerPage) && rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String fldmember_level = (String) rsHash.get("m_member_level");
      String fldmember_login = (String) rsHash.get("m_member_login");
      String fldname = (String) rsHash.get("m_name");
      String fldField1= "Edit";

      out.println("     <tr>");
      
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<a href=\"MemberRecord.jsp?"+transitParams+"member_id="+toURL((String) rsHash.get("m_member_id"))+"&\"><font face=\"arial\" size=\"2\">"+toHTML(fldField1)+"</font></a>");

      out.println("</td>");
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldmember_login)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldname)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#EEEEEE\">"); 
        fldmember_level = getValFromLOV(fldmember_level, "1;Member;3;Admin");out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldmember_level)+"&nbsp;</font>");
      out.println("</td>");
      out.println("     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      out.print("     <tr>\n      <td colspan=\"4\" bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">");
      out.print("<a href=\"MemberRecord.jsp?"+formParams+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.println("</td>\n     </tr>");
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    else {

  
    // Parse scroller
    boolean bInsert = false;
    boolean bNext = rs.next();
    if ( !bNext && iPage == 1 ) {
    
      out.print("     <tr>\n      <td colspan=\"4\" bgcolor=\"#CCCCCC\">\n       <font face=\"arial\" size=\"2\" style=\"font:bold\">");
      out.print("\n        <a href=\"MemberRecord.jsp?"+formParams+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.println("\n      </td>\n     </tr>");
    
    }
    else {
      out.print("     <tr>\n      <td colspan=\"4\" bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">");
    
      out.print("\n       <a href=\"MemberRecord.jsp?"+formParams+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      bInsert = true;
    
      if ( iPage == 1 ) {
        out.print("\n       <a href_=\"#\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Previous</font></a>");
      }
      else {
        out.print("\n       <a href=\""+sFileName+"?"+formParams+sSortParams+"FormGrid_Page="+(iPage - 1)+"#Form\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Previous</font></a>");
      }
  
      out.print("\n       [ "+iPage+" ]");
  
      if (!bNext) { 
        out.print("\n       <a href_=\"#\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Next</font></a><br>");
      }
      else {
        out.print("\n       <a href=\""+sFileName+"?"+formParams+sSortParams+"FormGrid_Page="+(iPage + 1)+"#Form\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Next</font></a><br>");
      }
    
      if ( ! bInsert ) {
        out.print("     <tr>\n      <td colspan=\"4\" bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">");
        out.print("\n        <a href=\"MemberRecord.jsp?"+formParams+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      }
    
      out.println("</td>\n     </tr>");
    }
  
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}


  void Search_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sSearchErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
      

      String fldname="";


      String sSQL="";
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      

      out.println("    <table >");
      out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"3\"><a name=\"Search\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Search</font></a></td>\n     </tr>");
      out.println("     <form method=\"get\" action=\"Members.jsp\" name=\"Search\">\n     <tr>");
      // Set variables with search parameters
      
      fldname = getParam( request, "name");

      // Show fields
      

      out.println("      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></td>");
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"50\" value=\""+toHTML(fldname)+"\" size=\"10\">");
 out.println("</td>");
      
      out.println("      <td ><input type=\"submit\" value=\"Search\"/></td>");
      out.println("     </tr>\n     </form>\n    </table>");
      out.println("");
    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
<%@ include file="YCommon.jsp" %><%!
//
//   Filename: Entries.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "YEntries.jsp";
              
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
String sEntriesErr = "";
String sSearchErr = "";
String sTotalErr = "";

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
<% Search_Show(request, response, session, out, sSearchErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
 <table>
  <tr>
   <td valign="top">
<% Total_Show(request, response, session, out, sTotalErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
 <table>
  <tr>
   <td valign="top">
<% Entries_Show(request, response, session, out, sEntriesErr, sForm, sAction, conn, stat); %>
    
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

</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!

  void Entries_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sEntriesErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
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

      String paddress="";
      String pcategory_id="";
      String pcity="";
      String pname="";
      String pstate="";
      String pzip="";


    transitParams = "address=" + toURL(getParam( request, "address")) + "&city=" + toURL(getParam( request, "city")) + "&name=" + toURL(getParam( request, "name")) + "&state=" + toURL(getParam( request, "state")) + "&zip=" + toURL(getParam( request, "zip")) + "&category_id=" + toURL(getParam( request, "category_id")) + "&";
    formParams = "address=" + toURL(getParam( request, "address")) + "&city=" + toURL(getParam( request, "city")) + "&name=" + toURL(getParam( request, "name")) + "&state=" + toURL(getParam( request, "state")) + "&zip=" + toURL(getParam( request, "zip")) + "&category_id=" + toURL(getParam( request, "category_id")) + "&"; 
    // Build WHERE statement
        
    //-- Check address parameter and create a valid sql for where clause
  
    paddress = getParam( request, "address");
    if (paddress != null && ! paddress.equals("")) {
            
        hasParam = true;
        sWhere += "i.address like '%" + replace(paddress, "'", "''") + "%'";
    }
    
    //-- Check category_id parameter and create a valid sql for where clause
  
    pcategory_id = getParam( request, "category_id");
    if ( ! isNumber (pcategory_id)) {
      pcategory_id = "";
    }
    
    if (pcategory_id != null && ! pcategory_id.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.category_id=" + pcategory_id;
    }
    
    //-- Check city parameter and create a valid sql for where clause
  
    pcity = getParam( request, "city");
    if (pcity != null && ! pcity.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.city like '%" + replace(pcity, "'", "''") + "%'";
    }
    
    //-- Check name parameter and create a valid sql for where clause
  
    pname = getParam( request, "name");
    if (pname != null && ! pname.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.name like '%" + replace(pname, "'", "''") + "%'";
    }
    
    //-- Check state parameter and create a valid sql for where clause
  
    pstate = getParam( request, "state");
    if (pstate != null && ! pstate.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.state='" + replace(pstate, "'", "''") + "'";
    }
    
    //-- Check zip parameter and create a valid sql for where clause
  
    pzip = getParam( request, "zip");
    if (pzip != null && ! pzip.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.zip like '%" + replace(pzip, "'", "''") + "%'";
    }
    
    if (hasParam) { sWhere = " AND (" + sWhere + ")"; }
    // Build ORDER statement
    sOrder = " order by i.name Asc";
    String sSort = getParam( request, "FormEntries_Sorting");
    String sSorted = getParam( request, "FormEntries_Sorted");
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
        sSortParams = "FormEntries_Sorting=" + sSort + "&FormEntries_Sorted=" + sSort + "&";
      }
      else {
        sSorted=sSort;
        sForm_Sorting = sSort;
        sDirection = " ASC";
        sSortParams = "FormEntries_Sorting=" + sSort + "&FormEntries_Sorted=" + "&";
      }
    
      if ( iSort == 1) { sOrder = " order by i.name" + sDirection; }
      if ( iSort == 2) { sOrder = " order by i.address" + sDirection; }
      if ( iSort == 3) { sOrder = " order by i.city" + sDirection; }
      if ( iSort == 4) { sOrder = " order by i.state" + sDirection; }
      if ( iSort == 5) { sOrder = " order by i.zip" + sDirection; }
      if ( iSort == 6) { sOrder = " order by c.name" + sDirection; }
    }
  

  // Build full SQL statement
  
  sSQL = "select i.address as i_address, " +
    "i.category_id as i_category_id, " +
    "i.city as i_city, " +
    "i.item_id as i_item_id, " +
    "i.name as i_name, " +
    "i.state as i_state, " +
    "i.zip as i_zip, " +
    "c.category_id as c_category_id, " +
    "c.name as c_name " +
    " from items i, pages c" +
    " where c.category_id=i.category_id  ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"6\" bgcolor=\"#F5F5F5\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">No records</font></td>\n     </tr>";


  String tableHeader = "";
      tableHeader = "     <tr>\n      <td bgcolor=\"#FFD9E5\"><a href=\""+sFileName+"?"+formParams+"FormEntries_Sorting=1&FormEntries_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Name</font></a></td>\n      <td bgcolor=\"#FFD9E5\"><a href=\""+sFileName+"?"+formParams+"FormEntries_Sorting=2&FormEntries_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Address</font></a></td>\n      <td bgcolor=\"#FFD9E5\"><a href=\""+sFileName+"?"+formParams+"FormEntries_Sorting=3&FormEntries_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">City</font></a></td>\n      <td bgcolor=\"#FFD9E5\"><a href=\""+sFileName+"?"+formParams+"FormEntries_Sorting=4&FormEntries_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">State</font></a></td>\n      <td bgcolor=\"#FFD9E5\"><a href=\""+sFileName+"?"+formParams+"FormEntries_Sorting=5&FormEntries_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">ZIP</font></a></td>\n      <td bgcolor=\"#FFD9E5\"><a href=\""+sFileName+"?"+formParams+"FormEntries_Sorting=6&FormEntries_Sorted="+sSorted+"&\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Category</font></a></td>\n     </tr>";
  
  
  try {
    out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">");
    out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#99CCFF\" colspan=\"6\"><a name=\"Entries\"><font style=\"font-size: 12pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Entries</font></a></td>\n     </tr>");
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    // Select current page
    iPage = Integer.parseInt(getParam( request, "FormEntries_Page"));
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
      String fldaddress = (String) rsHash.get("i_address");
      String fldcategory_id = (String) rsHash.get("c_name");
      String fldcity = (String) rsHash.get("i_city");
      String fldname = (String) rsHash.get("i_name");
      String fldstate = (String) rsHash.get("i_state");
      String fldzip = (String) rsHash.get("i_zip");

      out.println("     <tr>");
      
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<a href=\"YEntryView.jsp?"+transitParams+"item_id="+toURL((String) rsHash.get("i_item_id"))+"&\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldname)+"</font></a>");

      out.println("</td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldaddress)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldcity)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldstate)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldzip)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(fldcategory_id)+"&nbsp;</font>");
      out.println("</td>");
      out.println("     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    else {

  
    // Parse scroller
    boolean bInsert = false;
    boolean bNext = rs.next();
    if ( !bNext && iPage == 1 ) {
    
    }
    else {
      out.print("     <tr>\n      <td colspan=\"6\" bgcolor=\"#FFD9E5\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">");
    
      if ( iPage == 1 ) {
        out.print("\n       <a href_=\"#\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Previous</font></a>");
      }
      else {
        out.print("\n       <a href=\""+sFileName+"?"+formParams+sSortParams+"FormEntries_Page="+(iPage - 1)+"#Form\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Previous</font></a>");
      }
  
      out.print("\n       [ "+iPage+" ]");
  
      if (!bNext) { 
        out.print("\n       <a href_=\"#\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Next</font></a><br>");
      }
      else {
        out.print("\n       <a href=\""+sFileName+"?"+formParams+sSortParams+"FormEntries_Page="+(iPage + 1)+"#Form\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Next</font></a><br>");
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
      String fldaddress="";
      String fldcity="";
      String fldstate="";
      String fldzip="";


      String sSQL="";
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      

      out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">");
      out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#99CCFF\" colspan=\"11\"><a name=\"Search\"><font style=\"font-size: 12pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Search</font></a></td>\n     </tr>");
      out.println("     <form method=\"get\" action=\"YEntries.jsp\" name=\"Search\">\n     <tr>");
      // Set variables with search parameters
      
      fldname = getParam( request, "name");
      fldaddress = getParam( request, "address");
      fldcity = getParam( request, "city");
      fldstate = getParam( request, "state");
      fldzip = getParam( request, "zip");

      // Show fields
      

      out.println("      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Name</font></td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"100\" value=\""+toHTML(fldname)+"\" size=\"50\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Address</font></td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"address\" maxlength=\"255\" value=\""+toHTML(fldaddress)+"\" size=\"50\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">City</font></td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"city\" maxlength=\"50\" value=\""+toHTML(fldcity)+"\" size=\"50\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">State</font></td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"state\" maxlength=\"2\" value=\""+toHTML(fldstate)+"\" size=\"2\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">ZIP</font></td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"zip\" maxlength=\"10\" value=\""+toHTML(fldzip)+"\" size=\"10\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td align=\"right\" colspan=\"3\"><input type=\"submit\" value=\"Search\"/></td>");
      out.println("     </tr>\n     </form>\n    </table>");
      out.println("");
    }
    catch (Exception e) { out.println(e.toString()); }
  }


  void Total_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sTotalErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
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

      String paddress="";
      String pcategory_id="";
      String pcity="";
      String pname="";
      String pstate="";
      String pzip="";


    formParams = "category_id=" + toURL(getParam( request, "category_id")) + "&city=" + toURL(getParam( request, "city")) + "&name=" + toURL(getParam( request, "name")) + "&zip=" + toURL(getParam( request, "zip")) + "&address=" + toURL(getParam( request, "address")) + "&state=" + toURL(getParam( request, "state")) + "&"; 
    // Build WHERE statement
        
    //-- Check address parameter and create a valid sql for where clause
  
    paddress = getParam( request, "address");
    if (paddress != null && ! paddress.equals("")) {
            
        hasParam = true;
        sWhere += "i.address like '%" + replace(paddress, "'", "''") + "%'";
    }
    
    //-- Check category_id parameter and create a valid sql for where clause
  
    pcategory_id = getParam( request, "category_id");
    if ( ! isNumber (pcategory_id)) {
      pcategory_id = "";
    }
    
    if (pcategory_id != null && ! pcategory_id.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.category_id=" + pcategory_id;
    }
    
    //-- Check city parameter and create a valid sql for where clause
  
    pcity = getParam( request, "city");
    if (pcity != null && ! pcity.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.city like '%" + replace(pcity, "'", "''") + "%'";
    }
    
    //-- Check name parameter and create a valid sql for where clause
  
    pname = getParam( request, "name");
    if (pname != null && ! pname.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.name like '%" + replace(pname, "'", "''") + "%'";
    }
    
    //-- Check state parameter and create a valid sql for where clause
  
    pstate = getParam( request, "state");
    if (pstate != null && ! pstate.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.state like '%" + replace(pstate, "'", "''") + "%'";
    }
    
    //-- Check zip parameter and create a valid sql for where clause
  
    pzip = getParam( request, "zip");
    if (pzip != null && ! pzip.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "i.zip like '%" + replace(pzip, "'", "''") + "%'";
    }
    
    if (hasParam) { sWhere = " WHERE (" + sWhere + ")"; }

  // Build full SQL statement
  
  sSQL = "select i.address as i_address, " +
    "i.category_id as i_category_id, " +
    "i.city as i_city, " +
    "i.item_id as i_item_id, " +
    "i.name as i_name, " +
    "i.state as i_state, " +
    "i.zip as i_zip " +
    " from items i ";
  
sSQL="select count(item_id) as i_item_id from items as i";
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"1\" bgcolor=\"#F5F5F5\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">No records</font></td>\n     </tr>";


  String tableHeader = "";
    tableHeader = "     <tr>\n      <td colspan=\"1\" bgcolor=\"#FFD9E5\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Items found:</font></td>\n     </tr>";
  
  
  try {
    out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">");
    
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, sSQL);
    iCounter = 0;
    
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String flditem_id = (String) rsHash.get("i_item_id");

      out.println("     <tr>");
      
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+toHTML(flditem_id)+"&nbsp;</font>");
      out.println("</td>");
      out.println("     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}
%>
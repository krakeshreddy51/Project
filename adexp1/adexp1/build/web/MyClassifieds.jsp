<%@ include file="Common.jsp" %><%!
//
//   Filename: MyClassifieds.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "MyClassifieds.jsp";
              
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

String cSec = checkSecurity(1, session, response, request);
if ("sendRedirect".equals(cSec) ) return;
                
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sRecordErr = "";
String sGridErr = "";
String sAdMenuErr = "";

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
 <table>
  <tr>
   <td valign="top">
<% AdMenu_Show(request, response, session, out, sAdMenuErr, sForm, sAction, conn, stat); %>
    
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
      String sActionFileName = ".jsp";
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


      String fldUserID="";
      String fldmember_id="";

      // Load all form fields into variables
    
      fldUserID = (String) session.getAttribute("UserID");

      sSQL = "";
      // Create SQL statement

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
      String fldemail="";
      String fldmember_login="";


      boolean bPK = true;

      if ( "".equals(sRecordErr)) {
        // Load primary key and form parameters
      }
      else {
        // Load primary key, form parameters and form fields
        fldmember_id = getParam( request, "member_id");
      }

      
      String pmember_id = (String) session.getAttribute("UserID");
      if ( isEmpty(pmember_id)) { bPK = false; }
      
      sWhere += "member_id=" + toSQL(pmember_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_member_id\" value=\""+pmember_id+"\"/>";

      sSQL = "select * from members where " + sWhere;


      out.println("    <table >");
      out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"2\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">My Classifieds</font></td>\n     </tr>");
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
        fldname = (String) rsHash.get("name");
        fldemail = (String) rsHash.get("email");
        fldmember_login = (String) rsHash.get("member_login");

        if (sAction.equals("") || ! "Record".equals(sForm)) {
      
          fldmember_id = (String) rsHash.get("member_id");
          fldname = (String) rsHash.get("name");
          fldemail = (String) rsHash.get("email");
          fldmember_login = (String) rsHash.get("member_login");
        }
        else {
          fldmember_id = (String) rsHash.get("member_id");
          fldname = (String) rsHash.get("name");
          fldemail = (String) rsHash.get("email");
          fldmember_login = (String) rsHash.get("member_login");
        }
        
      }
      else {
        if ( "".equals(sRecordErr)) {
          fldmember_id = toHTML((String) session.getAttribute("UserID"));
        }
      }
      


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Welcome</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldname)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">E-mail</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldemail)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Edit my info</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<a href=\"MyInfo.jsp?"+transitParams+"member_id="+toURL((String) rsHash.get("member_id"))+"&\"><font face=\"arial\" size=\"2\">"+toHTML(fldmember_login)+"</font></a>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "Record".equals(sForm))) {
        
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Record\"><input type=\"hidden\" value=\"\" name=\"FormAction\">");
      }
      out.print("<input type=\"hidden\" name=\"member_id\" value=\""+toHTML(fldmember_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } 

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

      String pUserID="";

boolean bReq = true; 
    // Build WHERE statement
        
    //-- Check UserID parameter and create a valid sql for where clause
  
    pUserID = (String)session.getAttribute("UserID");
    if ( ! isNumber (pUserID)) {
      pUserID = "";
    }
    
    if (pUserID != null && ! pUserID.equals("")) {
            
        hasParam = true;
        sWhere += "a.member_id=" + pUserID;
    }
    
    else bReq = false;
    if (hasParam) { sWhere = " AND (" + sWhere + ")"; }
    // Build ORDER statement
    sOrder = " order by a.date_posted Desc";
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
    
      if ( iSort == 1) { sOrder = " order by a.date_posted" + sDirection; }
      if ( iSort == 2) { sOrder = " order by a.name" + sDirection; }
      if ( iSort == 3) { sOrder = " order by c.name" + sDirection; }
      if ( iSort == 4) { sOrder = " order by a.price" + sDirection; }
    }
  

  // Build full SQL statement
  
  sSQL = "select a.ad_id as a_ad_id, " +
    "a.category_id as a_category_id, " +
    "a.date_posted as a_date_posted, " +
    "a.member_id as a_member_id, " +
    "a.name as a_name, " +
    "a.price as a_price, " +
    "c.category_id as c_category_id, " +
    "c.name as c_name " +
    " from ads a, categories c" +
    " where c.category_id=a.category_id  ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"4\" bgcolor=\"#EEEEEE\"><font face=\"arial\" size=\"2\">No records</font></td>\n     </tr>";


  String tableHeader = "";
      tableHeader = "     <tr>\n      <td bgcolor=\"#CCCCCC\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=1&FormGrid_Sorted="+sSorted+"&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Date Posted</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=2&FormGrid_Sorted="+sSorted+"&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=3&FormGrid_Sorted="+sSorted+"&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Category</font></a></td>\n      <td bgcolor=\"#CCCCCC\"><a href=\""+sFileName+"?"+formParams+"FormGrid_Sorting=4&FormGrid_Sorted="+sSorted+"&\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Price</font></a></td>\n     </tr>";
  
  
  try {
    out.println("    <table >");
    out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"4\"><a name=\"Grid\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">My Ads</font></a></td>\n     </tr>");
    out.println(tableHeader);

    if ( ! bReq ) {
      out.println(sNoRecords);
      out.println("    </table>");
      return;
    }

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
      String fldcategory_id = (String) rsHash.get("c_name");
      String flddate_posted = (String) rsHash.get("a_date_posted");
      String fldname = (String) rsHash.get("a_name");
      String fldprice = (String) rsHash.get("a_price");

      out.println("     <tr>");
      
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(flddate_posted)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<a href=\"MyAdRecord.jsp?"+transitParams+"ad_id="+toURL((String) rsHash.get("a_ad_id"))+"&\"><font face=\"arial\" size=\"2\">"+toHTML(fldname)+"</font></a>");

      out.println("</td>");
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldcategory_id)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<font face=\"arial\" size=\"2\">"+toHTML(fldprice)+"&nbsp;</font>");
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


  void AdMenu_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAdMenuErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
  
      out.println("    <table >");
      
      out.print("     <tr>");
      // Set URLs
      
      String fldField1 = "MyAdSelCat.jsp";
      // Show fields
      
      out.print("\n      <td bgcolor=\"#EEEEEE\"><a href=\""+fldField1+"\"><font face=\"arial\" size=\"2\">New Ad</font></a></td>");

      out.println("\n     </tr>\n    </table>");
  
    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
<%@ include file="Common.jsp" %><%!
//
//   Filename: Categories.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "Categories.jsp";
              
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
String sGridErr = "";
String sTreeErr = "";
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
if ( sForm.equals("Tree") ) {
  sTreeErr = TreeAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sTreeErr)) return;
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
<% //Tree_Show(request, response, session, out, sTreeErr, sForm, sAction, conn, stat); %>
    
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
    int RecordsPerPage = 10;
    String sSortParams = "";
    String formParams = "";

      String pcategory_id="";
      String pname="";


    transitParams = "category_id=" + toURL(getParam( request, "category_id")) + "&name=" + toURL(getParam( request, "name")) + "&";
    formParams = "category_id=" + toURL(getParam( request, "category_id")) + "&name=" + toURL(getParam( request, "name")) + "&"; 
    // Build WHERE statement
        
    //-- Check category_id parameter and create a valid sql for where clause
  
    pcategory_id = getParam( request, "category_id");
    if ( ! isNumber (pcategory_id)) {
      pcategory_id = "";
    }
    
    if (pcategory_id != null && ! pcategory_id.equals("")) {
            
        hasParam = true;
        sWhere += "c.par_category_id=" + pcategory_id;
    }
    
    //-- Check name parameter and create a valid sql for where clause
  
    pname = getParam( request, "name");
    if (pname != null && ! pname.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "c.name like '%" + replace(pname, "'", "''") + "%'";
    }
    
    if (hasParam) { sWhere = " WHERE (" + sWhere + ")"; }
    // Build ORDER statement
    sOrder = " order by c.name Asc";

  // Build full SQL statement
  
  sSQL = "select c.category_id as c_category_id, " +
    "c.name as c_name, " +
    "c.par_category_id as c_par_category_id " +
    " from categories c ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"1\" bgcolor=\"#EEEEEE\"><font face=\"arial\" size=\"2\">No records</font></td>\n     </tr>";


  String tableHeader = "";
    tableHeader = "     <tr>\n      <td colspan=\"1\" bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></td>\n     </tr>";
  
  
  try {
    out.println("    <table >");
    out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\" colspan=\"1\"><a name=\"Grid\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Categories</font></a></td>\n     </tr>");
    
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
  RecordsPerPage =10;
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
      String fldname = (String) rsHash.get("c_name");

      out.println("     <tr>");
      
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<a href=\"CategoryRecord.jsp?"+transitParams+"cat_id="+toURL((String) rsHash.get("c_category_id"))+"&\"><font face=\"arial\" size=\"2\">"+toHTML(fldname)+"</font></a>");

      out.println("</td>");
      out.println("     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      out.print("     <tr>\n      <td colspan=\"1\" bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">");
      out.print("<a href=\"CategoryRecord.jsp?"+formParams+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.println("</td>\n     </tr>");
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    else {

  
    // Parse scroller
    boolean bInsert = false;
    boolean bNext = rs.next();
    if ( !bNext && iPage == 1 ) {
    
      out.print("     <tr>\n      <td colspan=\"1\" bgcolor=\"#CCCCCC\">\n       <font face=\"arial\" size=\"2\" style=\"font:bold\">");
      out.print("\n        <a href=\"CategoryRecord.jsp?"+formParams+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.println("\n      </td>\n     </tr>");
    
    }
    else {
      out.print("     <tr>\n      <td colspan=\"1\" bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">");
    
      out.print("\n       <a href=\"CategoryRecord.jsp?"+formParams+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
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
        out.print("     <tr>\n      <td colspan=\"1\" bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">");
        out.print("\n        <a href=\"CategoryRecord.jsp?"+formParams+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Insert</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      }
    
      out.println("</td>\n     </tr>");
    }
  
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}


  String sActionFileName = "Categories.jsp";

      
  String TreeAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
      
      String sCatId = getParam( request, "category_id");
      String sOp = "=";
      if ( isEmpty(sCatId) || ! isNumber(sCatId) ) {
        sCatId = "null";
        sOp = " is ";
      }
      long lNRec = dCountRec( stat, "categories", "par_category_id"+ sOp + sCatId);
      if ( lNRec == 0 ) {
        try {
          if ( stat != null ) stat.close();
          if ( conn != null ) conn.close();
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect("Categories.jsp?category_id=" + sCatId);
        return "sendRedirect";
      
      }
    }
    catch (Exception e) { out.println(e.toString()); };
    return ("");
  }
      
  void Tree_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sTreeErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
  
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      String sSQL = "select category_id, name, par_category_id from categories";
      String sCatID = getParam( request, "category_id");
      String sWhere = "";
      java.sql.ResultSet rs = null;
      String sCatPath = "";
      String sCatList = "";
      String sParCatID = "";
      String sCatName  = "";
      String sPath = "";
      String stCatID    = "";
      String stParCatID = "";
      String stCatName  = "";
  
      out.println("    <table >");
      
      out.println("     <tr>\n      <td bgcolor=\"#CCCCCC\"><nobr><font face=\"arial\" size=\"2\" style=\"font:bold\"><a href=\""+sActionFileName+"?FormName=Tree\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Top</font></a>");
  
      
      if (sCatID == null || sCatID.compareTo("") == 0 || ! isNumber(sCatID)) {
        // Root category
        sWhere = " where par_category_id is Null";
      }
      else {
        
        // Subcategory
        sWhere = " where category_id=" + sCatID;
        rs = openrs ( stat, sSQL + sWhere);
        if ( rs.next()) {
          java.util.Hashtable rsHash = new java.util.Hashtable();
          String[] aFields = getFieldsName( rs );
          getRecordToHash( rs, rsHash, aFields );
  
          sCatPath = "";
          sCatList = "";
          sParCatID = toHTML((String) rsHash.get("par_category_id"));
          sCatName  = toHTML((String) rsHash.get("name"));
        }
        rs.close();
        sPath = " > "+sCatName+"</font></nobr></td>\n     </tr>";
  
        
        // Build Path
        stParCatID = sParCatID;
        while ( stParCatID.compareTo("") != 0 ) {
          rs = openrs ( stat, sSQL + " where category_id=" + stParCatID);
          java.util.Hashtable rsHash = new java.util.Hashtable();
          String[] aFields = getFieldsName( rs );
          if ( rs.next() ) {
            getRecordToHash( rs, rsHash, aFields );
            stCatID    = toHTML((String) rsHash.get("category_id"));
            stParCatID = toHTML((String) rsHash.get("par_category_id"));
            stCatName  = toHTML((String) rsHash.get("name"));
            sPath = "> <a href=\""+sActionFileName+"?FormName=Tree&category_id="+stCatID+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">"+stCatName+"</font></a>" + sPath;
          }
          rs.close();
        }
        out.println(sPath);
        sWhere = " where par_category_id=" + sCatID;
      }
  
      
      // Categories list
      rs = openrs ( stat, sSQL + sWhere);
      if (rs != null) {
        java.util.Hashtable rsHash = new java.util.Hashtable();
        String[] aFields = getFieldsName( rs );
        while ( rs.next() ) {
          // Print subcategories
          getRecordToHash( rs, rsHash, aFields );
          stCatID    = toHTML((String) rsHash.get("category_id"));
          stParCatID = toHTML((String) rsHash.get("par_category_id"));
          stCatName  = toHTML((String) rsHash.get("name"));
          
          out.println("    <tr>\n     <td bgcolor=\"#EEEEEE\"><a href=\""+sActionFileName+"?FormName=Tree&category_id="+stCatID+"\"><font face=\"arial\" size=\"2\">"+stCatName+"</font></a></td>\n     </tr>");
        }
      }
      rs.close();
    
      out.println("    </table>");
    }
    catch (Exception e) { out.println(e.toString()); };
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
      out.println("     <form method=\"get\" action=\"Categories.jsp\" name=\"Search\">\n     <tr>");
      // Set variables with search parameters
      
      fldname = getParam( request, "name");

      // Show fields
      

      out.println("      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></td>");
      out.print("      <td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"50\" value=\""+toHTML(fldname)+"\" size=\"20\">");
 out.println("</td>");
      
      out.println("      <td ><input type=\"submit\" value=\"Search\"/></td>");
      out.println("     </tr>\n     </form>\n    </table>");
      out.println("");
    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
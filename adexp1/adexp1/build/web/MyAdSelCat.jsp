<%@ include file="Common.jsp" %><%!
//
//   Filename: MyAdSelCat.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "MyAdSelCat.jsp";
              
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
String sTreeErr = "";

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
<% Tree_Show(request, response, session, out, sTreeErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
</tr>
  </table>
</div>
<div id="Layer1"><img src="imges/5.jpg" alt="5ad" width="694" height="344" /></div>

<jsp:include page="Addlogde.jsp"/>
<jsp:include page="Footer.jsp" flush="true"/>

</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!

  String sActionFileName = "MyAdSelCat.jsp";

      
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
        response.sendRedirect("MyAdRecord.jsp?category_id=" + sCatId);
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
      out.println("     <tr>\n      <td bgcolor=\"#808080\" align=\"center\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Select Category</font></td>\n     </tr>");
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

%>
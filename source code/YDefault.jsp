<%@ include file="YCommon.jsp" %><%!
//
//   Filename: Default.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "YDefault.jsp";
              
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
String sSearchErr = "";
String sCategoriesErr = "";

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
if ( sForm.equals("pages") ) {
  sCategoriesErr = CategoriesAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sCategoriesErr)) return;
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
    
   </td><td></td>
   <td valign="top" align="right">
<% Categories_Show(request, response, session, out, sCategoriesErr, sForm, sAction, conn, stat); %>

   </td>
  </tr>
 </table>
 

 dfsdfdfdfdfdfdfdfdf
          </div></th>
    </tr>
  </table>
</div>
<div id="Layer1"><img src="imges/Poligrafija-Veidlapas-aploksnes.jpg" width="694" height="344" /></div>

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
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"50\" value=\""+toHTML(fldname)+"\" size=\"50\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Address</font></td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"address\" maxlength=\"255\" value=\""+toHTML(fldaddress)+"\" size=\"50\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">City</font></td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"city\" maxlength=\"50\" value=\""+toHTML(fldcity)+"\" size=\"50\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">State</font></td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"state\" maxlength=\"50\" value=\""+toHTML(fldstate)+"\" size=\"2\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">ZIP</font></td>");
      out.print("      <td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"zip\" maxlength=\"50\" value=\""+toHTML(fldzip)+"\" size=\"10\">");
 out.println("</td>\n     </tr>\n     <tr>");
      
      out.println("      <td align=\"right\" colspan=\"3\"><input type=\"submit\" value=\"Search\"/></td>");
      out.println("     </tr>\n     </form>\n    </table>");
      out.println("");
    }
    catch (Exception e) { out.println(e.toString()); }
  }


  String sActionFileName = "YDefault.jsp";

      
  String CategoriesAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
      
      String sCatId = getParam( request, "category_id");
      String sOp = "=";
      if ( isEmpty(sCatId) || ! isNumber(sCatId) ) {
        sCatId = "null";
        sOp = " is ";
      }
      long lNRec = dCountRec( stat, "pages", "par_category_id"+ sOp + sCatId);
      if ( lNRec == 0 ) {
        try {
          if ( stat != null ) stat.close();
          if ( conn != null ) conn.close();
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect("YEntries.jsp?category_id=" + sCatId);
        return "sendRedirect";
      
      }
    }
    catch (Exception e) { out.println(e.toString()); };
    return ("");
  }
      
  void Categories_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sCategoriesErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
  
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      String sSQL = "select category_id, name, par_category_id from pages";
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
  
      out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">");
      
      out.println("     <tr>\n      <td bgcolor=\"#FFD9E5\"><nobr><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\"><a href=\""+sActionFileName+"?FormName=pages\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Top</font></a>");
  
      
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
            sPath = "> <a href=\""+sActionFileName+"?FormName=pages&category_id="+stCatID+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">"+stCatName+"</font></a>" + sPath;
          }
          rs.close();
        }
        out.println(sPath);
        sWhere = " where par_category_id=" + sCatID;
      }
  
      
      // pages list
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
          
          out.println("    <tr>\n     <td bgcolor=\"#F5F5F5\"><a href=\""+sActionFileName+"?FormName=pages&category_id="+stCatID+"\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+stCatName+"</font></a></td>\n     </tr>");
        }
      }
      rs.close();
    
      out.println("    </table>");
    }
    catch (Exception e) { out.println(e.toString()); };
  }   

%>
<%@ include file="YCommon.jsp" %><%!
//
//   Filename: AdminCategoriesRecord.jsp
//   Generated with CodeCharge  v.1.1.19
//   JSP.ccp build 04/20/2001
//

static final String sFileName = "YAdminCategoriesRecord.jsp";
              
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

String cSec = checkSecurity(3, session, response, request);
if ("sendRedirect".equals(cSec) ) return;
                
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String scategoriesErr = "";

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
  scategoriesErr = categoriesAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(scategoriesErr)) return;
}

%>            
<html>
<head>
<title>YellowPages</title>
<link rel="stylesheet" href="css.css" />

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
<% categories_Show(request, response, session, out, scategoriesErr, sForm, sAction, conn, stat); %>
    
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

<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!


  String categoriesAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String scategoriesErr ="";
    try {

      if (sAction.equals("")) return "";

      String sSQL="";
      String transitParams = "";
      String primaryKeyParams = "";
      String sQueryString = "";
      String sPage = "";
      String sParams = "";
      String sActionFileName = "YAdminCategoriesGrid.jsp";
      String sWhere = " ";
      boolean bErr = false;
      long iCount = 0;

  
      sParams = "?";
      sParams += "cat_id=" + toURL(getParam( request, "Trn_cat_id")) + "&";
      sParams += "category_id=" + toURL(getParam( request, "Trn_category_id"));
      String pPKcategory_id = "";
      if (sAction.equalsIgnoreCase("cancel") ) {
        try {
          if ( stat != null ) stat.close();
          if ( conn != null ) conn.close();
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect (sActionFileName + sParams);
        return "sendRedirect";
      }

      final int iinsertAction = 1;
      final int iupdateAction = 2;
      final int ideleteAction = 3;
      int iAction = 0;

      if ( sAction.equalsIgnoreCase("insert") ) { iAction = iinsertAction; }
      if ( sAction.equalsIgnoreCase("update") ) { iAction = iupdateAction; }
      if ( sAction.equalsIgnoreCase("delete") ) { iAction = ideleteAction; }

      // Create WHERE statement

      if ( iAction == iupdateAction || iAction == ideleteAction ) { 
        pPKcategory_id = getParam( request, "PK_category_id");
        if ( isEmpty(pPKcategory_id)) return scategoriesErr;
        sWhere = "category_id=" + toSQL(pPKcategory_id, adNumber);
      }


      String fldname="";
      String fldpar_category_id="";
      String fldcategory_id="";

      // Load all form fields into variables
    
      fldname = getParam(request, "name");
      fldpar_category_id = getParam(request, "par_category_id");
      // Validate fields
      if ( iAction == iinsertAction || iAction == iupdateAction ) {
        if ( isEmpty(fldname) ) {
          scategoriesErr = scategoriesErr + "The value in field Name is required.<br>";
        }
        if ( ! isNumber(fldpar_category_id)) {
          scategoriesErr = scategoriesErr + "The value in field Parent category is incorrect.<br>";
        }
        if (scategoriesErr.length() > 0 ) {
          return (scategoriesErr);
        }
      }


      sSQL = "";
      // Create SQL statement

      switch (iAction) {
  
        case iinsertAction :
          
            sSQL = "insert into pages (" + 
                "name," +
                "par_category_id)" +

                " values (" + 
                toSQL(fldname, adText) + "," +
                toSQL(fldpar_category_id, adNumber) + ")";
				System.out.println(sSQL);
          break;
  
      case iupdateAction:
        
          sSQL = "update pages set " +
                "name=" + toSQL(fldname, adText) +
                ",par_category_id=" + toSQL(fldpar_category_id, adNumber);
          sSQL = sSQL + " where " + sWhere;
        break;
      
      case ideleteAction:
           sSQL = "delete from pages where " + sWhere;
          
        break;
  
      }

      if ( scategoriesErr.length() > 0 ) return scategoriesErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
        
      }
      catch(java.sql.SQLException e) {
        scategoriesErr = e.toString(); return (scategoriesErr);
      }
  
      try {
        if ( stat != null ) stat.close();
        if ( conn != null ) conn.close();
      }
      catch ( java.sql.SQLException ignore ) {}
      response.sendRedirect (sActionFileName + sParams);

      return "sendRedirect";
    }
    catch (Exception e) {out.println(e.toString()); }
    return (scategoriesErr);
  }

  


  void categories_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String scategoriesErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
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
      
      String pcategory_id = "";

      String fldcat_id="";
      String fldcategory_id="";
      String fldname="";
      String fldpar_category_id="";


      boolean bPK = true;

      if ( "".equals(scategoriesErr)) {
        // Load primary key and form parameters
        fldcat_id = getParam( request, "cat_id");
        fldcategory_id = getParam( request, "category_id");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_cat_id\" value=\""+getParam( request, "cat_id")+"\">";
        transitParams += "Trn_cat_id="+getParam( request, "cat_id")+"&";
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_category_id\" value=\""+getParam( request, "category_id")+"\">";
        transitParams += "Trn_category_id="+getParam( request, "category_id")+"&";
        pcategory_id = getParam( request, "cat_id");
      }
      else {
        // Load primary key, form parameters and form fields
        fldcategory_id = getParam( request, "category_id");
        fldname = getParam( request, "name");
        fldpar_category_id = getParam( request, "par_category_id");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_cat_id\" value=\""+getParam( request, "Trn_cat_id")+"\">";
        transitParams += "Trn_cat_id="+getParam( request, "Trn_cat_id")+"&";
        
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_category_id\" value=\""+getParam( request, "Trn_category_id")+"\">";
        transitParams += "Trn_category_id="+getParam( request, "Trn_category_id")+"&";
        
        pcategory_id = getParam( request, "PK_cat_id");
      }

      
      if ( isEmpty(pcategory_id)) { bPK = false; }
      
      sWhere += "category_id=" + toSQL(pcategory_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_category_id\" value=\""+pcategory_id+"\"/>";

      sSQL = "select * from pages where " + sWhere;


      out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">");
      out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#99CCFF\" colspan=\"2\"><font style=\"font-size: 12pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Category</font></td>\n     </tr>");
      if ( ! scategoriesErr.equals("")) {
        out.println("     <tr>\n      <td bgcolor=\"#F5F5F5\" colspan=\"2\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+scategoriesErr+"</font></td>\n     </tr>");
      }
      scategoriesErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"pages\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "pages".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        fldcategory_id = (String) rsHash.get("category_id");
        if ( "".equals(scategoriesErr)) {
          // Load data from recordset when form displayed first time
          fldname = (String) rsHash.get("name");
          fldpar_category_id = (String) rsHash.get("par_category_id");
        }

        if (sAction.equals("") || ! "pages".equals(sForm)) {
      
          fldcategory_id = (String) rsHash.get("category_id");
          fldname = (String) rsHash.get("name");
          fldpar_category_id = (String) rsHash.get("par_category_id");
        }
        
      }
      else {
        if ( "".equals(scategoriesErr)) {
          fldcategory_id = toHTML(getParam(request,"cat_id"));
          fldpar_category_id = toHTML(getParam(request,"category_id"));
        }
      }
      


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Name</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"50\" value=\""+toHTML(fldname)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Parent category</font></td><td bgcolor=\"#F5F5F5\">"); 
      out.print("<select name=\"par_category_id\">"+getOptions( conn, "select category_id, name from pages order by 2",false,false,fldpar_category_id)+"</select>");
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "pages".equals(sForm))) {
        out.print("<input type=\"submit\" value=\"Update\" onclick=\"document.pages.FormAction.value = 'update';\">");out.print("<input type=\"submit\" value=\"Delete\" onclick=\"document.pages.FormAction.value = 'delete';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.pages.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"pages\"><input type=\"hidden\" value=\"update\" name=\"FormAction\">");
      }
      
      else {
        out.print("<input type=\"submit\" value=\"Insert\" onclick=\"document.pages.FormAction.value = 'insert';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.pages.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"pages\"><input type=\"hidden\" value=\"insert\" name=\"FormAction\">");
      }out.print("<input type=\"hidden\" name=\"category_id\" value=\""+toHTML(fldcategory_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %><%
stat.close();
conn.close();
%>
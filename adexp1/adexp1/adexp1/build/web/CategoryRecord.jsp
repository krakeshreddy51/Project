<%@ include file="Common.jsp" %><%!
//
//   Filename: CategoryRecord.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//

static final String sFileName = "CategoryRecord.jsp";
              
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
if ( sForm.equals("Form") ) {
  sFormErr = FormAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sFormErr)) return;
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
<% Form_Show(request, response, session, out, sFormErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
             dfsdfdfdfdfdfdfdfdf
          </div></th>
    </tr>
  </table>
</div>
<div id="Layer1"><img src="imges/add4.jpg" alt="olig" width="694" height="344" /></div>

<jsp:include page="Addlogde.jsp"/>
<jsp:include page="Footer.jsp"/>

<jsp:include page="Footer.jsp" flush="true"/>

</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!


  String FormAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String sFormErr ="";
    try {

      if (sAction.equals("")) return "";

      String sSQL="";
      String transitParams = "";
      String primaryKeyParams = "";
      String sQueryString = "";
      String sPage = "";
      String sParams = "";
      String sActionFileName = "Categories.jsp";
      String sWhere = " ";
      boolean bErr = false;
      long iCount = 0;

  
      sParams = "?";
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
        if ( isEmpty(pPKcategory_id)) return sFormErr;
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
          sFormErr = sFormErr + "The value in field Name is required.<br>";
        }
        if ( ! isNumber(fldpar_category_id)) {
          sFormErr = sFormErr + "The value in field Parent Category is incorrect.<br>";
        }
        if (sFormErr.length() > 0 ) {
          return (sFormErr);
        }
      }


      sSQL = "";
      // Create SQL statement

      switch (iAction) {
  
        case iinsertAction :
          
            sSQL = "insert into categories (" + 
                "name," +
                "par_category_id)" +

                " values (" + 
                toSQL(fldname, adText) + "," +
                toSQL(fldpar_category_id, adNumber) + ")";
          break;
  
      case iupdateAction:
        
          sSQL = "update categories set " +
                "name=" + toSQL(fldname, adText) +
                ",par_category_id=" + toSQL(fldpar_category_id, adNumber);
          sSQL = sSQL + " where " + sWhere;
        break;
      
      case ideleteAction:
           sSQL = "delete from categories where " + sWhere;
          
        break;
  
      }

      if ( sFormErr.length() > 0 ) return sFormErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        sFormErr = e.toString(); return (sFormErr);
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
    return (sFormErr);
  }

  


  void Form_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sFormErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
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

      if ( "".equals(sFormErr)) {
        // Load primary key and form parameters
        fldcat_id = getParam( request, "cat_id");
        fldcategory_id = getParam( request, "category_id");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_category_id\" value=\""+getParam( request, "category_id")+"\">";
        transitParams += "Trn_category_id="+getParam( request, "category_id")+"&";
        pcategory_id = getParam( request, "cat_id");
      }
      else {
        // Load primary key, form parameters and form fields
        fldcategory_id = getParam( request, "category_id");
        fldname = getParam( request, "name");
        fldpar_category_id = getParam( request, "par_category_id");
        transitParamsHidden += "<input type=\"hidden\" name=\"Trn_category_id\" value=\""+getParam( request, "Trn_category_id")+"\">";
        transitParams += "Trn_category_id="+getParam( request, "Trn_category_id")+"&";
        
        pcategory_id = getParam( request, "PK_cat_id");
      }

      
      if ( isEmpty(pcategory_id)) { bPK = false; }
      
      sWhere += "category_id=" + toSQL(pcategory_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_category_id\" value=\""+pcategory_id+"\"/>";

      sSQL = "select * from categories where " + sWhere;


      out.println("    <table >");
      
      if ( ! sFormErr.equals("")) {
        out.println("     <tr>\n      <td bgcolor=\"#EEEEEE\" colspan=\"2\"><font face=\"arial\" size=\"2\">"+sFormErr+"</font></td>\n     </tr>");
      }
      sFormErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"Form\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "Form".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        fldcategory_id = (String) rsHash.get("category_id");
        if ( "".equals(sFormErr)) {
          // Load data from recordset when form displayed first time
          fldname = (String) rsHash.get("name");
          fldpar_category_id = (String) rsHash.get("par_category_id");
        }

        if (sAction.equals("") || ! "Form".equals(sForm)) {
      
          fldcategory_id = (String) rsHash.get("category_id");
          fldname = (String) rsHash.get("name");
          fldpar_category_id = (String) rsHash.get("par_category_id");
        }
        
      }
      else {
        if ( "".equals(sFormErr)) {
          fldcategory_id = toHTML(getParam(request,"cat_id"));
          fldpar_category_id = toHTML(getParam(request,"category_id"));
        }
      }
      


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></td><td bgcolor=\"#EEEEEE\">"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"50\" value=\""+toHTML(fldname)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#CCCCCC\"><font face=\"arial\" size=\"2\" style=\"font:bold\">Parent Category</font></td><td bgcolor=\"#EEEEEE\">"); 
      out.print("<select name=\"par_category_id\">"+getOptions( conn, "select category_id, name from categories order by 2",false,false,fldpar_category_id)+"</select>");
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "Form".equals(sForm))) {
        out.print("<input type=\"submit\" value=\"Update\" onclick=\"document.Form.FormAction.value = 'update';\">");out.print("<input type=\"submit\" value=\"Delete\" onclick=\"document.Form.FormAction.value = 'delete';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Form.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Form\"><input type=\"hidden\" value=\"update\" name=\"FormAction\">");
      }
      
      else {
        out.print("<input type=\"submit\" value=\"Insert\" onclick=\"document.Form.FormAction.value = 'insert';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Form.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Form\"><input type=\"hidden\" value=\"insert\" name=\"FormAction\">");
      }out.print("<input type=\"hidden\" name=\"category_id\" value=\""+toHTML(fldcategory_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %>
<%@ include file="LTemplateObj.jsp" %>
<%@ include file="LCommon.jsp" %>

<link rel="stylesheet" href="css.css" />

<div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">
<%!
//   Filename: AdminCategoriesRecord.jsp
//   Generated with CodeCharge 1.2.0
//   JSPTemplates build 05/21/2001

String sFileName = "LAdminCategoriesRecord.jsp";

%><%

java.sql.Connection conn = null;
java.sql.Statement  stat = null;
String sErr = loadDriver();
if ( ! sErr.equals("") ) {
 try {
   out.println(sErr);
 }
 catch (Exception e) {}
}
conn = cn();                  
stat = conn.createStatement();


String sAction =null;
String sForm =null;



session.putValue("scategoriesErr","");

String sTemplateFileName = "LAdminCategoriesRecord.html";



String cSec = CheckSecurity(3, session, response, request, sFileName);
if ("sendRedirect".equals(cSec) ) {
  if ( stat != null )  { stat.close(); stat = null; }
  if ( conn != null ) { conn.close(); conn = null; }
  return;
}



TextTemplate oTpl = new TextTemplate();
String appPath = pageContext.getServletContext().getRealPath(request.getRequestURI()).replace('\\','/');
String cPath = request.getContextPath();
if ( cPath.length() > 1 ) {
  int f1 = appPath.lastIndexOf(cPath);
  appPath = appPath.substring(0,f1)+appPath.substring(f1+cPath.length());
}
appPath = appPath.substring(0,appPath.lastIndexOf('/')+1);
oTpl.loadTemplate(appPath+ sTemplateFileName , "main"); 

final String sHeaderFileName = appPath + "LHeader.html";
oTpl.loadTemplate(sHeaderFileName, "Header"); 

oTpl.setVar ("FileName", sFileName);


oTpl.setVar ("PageBODY", stylePageBODY);

oTpl.setVar ("FormTABLE", styleFormTABLE);

oTpl.setVar ("FormHeaderTD", styleFormHeaderTD);

oTpl.setVar ("FormHeaderFONT", styleFormHeaderFONT);

oTpl.setVar ("FieldCaptionTD", styleFieldCaptionTD);

oTpl.setVar ("FieldCaptionFONT", styleFieldCaptionFONT);

oTpl.setVar ("DataTD", styleDataTD);

oTpl.setVar ("DataFONT", styleDataFONT);

oTpl.setVar ("ColumnFONT", styleColumnFONT);

oTpl.setVar ("ColumnTD", styleColumnTD);


sAction = getParam(request, "FormAction", Text_TYPE);
sForm = getParam(request, "FormName", Text_TYPE);

if (sForm.equalsIgnoreCase("categories")) {
  categoriesAction( request, response, session, out, sForm, sAction, conn, stat, oTpl);
  if ("sendRedirect".equals(((String) session.getAttribute("scategoriesErr"))) ) {
    if ( stat != null )  { stat.close(); stat = null; }
    if ( conn != null ) { conn.close(); conn = null; }
    return;
  }
}
Menu_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
categories_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
oTpl.parse("Header", false);
oTpl.parse("main", false);
out.print(oTpl.printVar("main"));


if ( stat != null )  { stat.close(); stat = null; }
if ( conn != null ) { conn.close(); conn = null; }

%><%!





void categoriesAction( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {
    
    String sActionFileName = "LAdminCategoriesGrid.jsp";
    String sParams = "";
    String sWhere =" ";
    long iCount = 0;
    String scategoriesErr = "";
    
    
    String sSQL ="";
  
    sParams = "?";
    sParams += "cat_id=" + toURL(getParam(request, "Trn_cat_id", Text_TYPE)) + "&";
    sParams += "category_id=" + toURL(getParam(request, "Trn_category_id", Text_TYPE));
    String pPKcategory_id = "";                    
    if ("cancel".equals(sAction)) {
        try{
          try {
            if ( stat != null )  { stat.close(); stat = null; }
            if ( conn != null ) { conn.close(); conn = null; }
          }
          catch ( java.sql.SQLException ignore ) {}
          response.sendRedirect(sActionFileName + sParams);
          addSessionError("sAdminCategoriesRecordErr", "sendRedirect", session);
          return;
        }catch(java.io.IOException e)   {};
    }

    final int iinsertAction = 1;
    final int iupdateAction = 2;
    final int ideleteAction = 3;
    int iAction = 0;
  
    if ( sAction.equalsIgnoreCase("insert") ) { iAction = iinsertAction; }
    if ( sAction.equalsIgnoreCase("update") ) { iAction = iupdateAction; }
    if ( sAction.equalsIgnoreCase("delete") ) { iAction = ideleteAction; }
  
  
    // Create WHERE statement
    if ((iAction == ideleteAction)||( iAction == iupdateAction)) { 
      pPKcategory_id = getParam( request, "PK_category_id");
      if ( isEmpty(pPKcategory_id)) return;
      sWhere = "category_id=" + toSQL(pPKcategory_id, Number_TYPE);
    }
  

      String fldcategory_desc="";
      String fldparent_category_id="";
      String fldcategory_id="";

    // Load all form fields into variables
    
    fldcategory_desc = getParam( request, "category_desc");
    fldparent_category_id = getParam( request, "parent_category_id");
  // Validate fields
  if ( iAction == iinsertAction || iAction == iupdateAction ) {
    if (isEmpty(fldcategory_desc)) {
      scategoriesErr = scategoriesErr + "The value in field Name is required.<br>";
    }
    if ( ! isNumber(fldcategory_id)) {
      scategoriesErr = scategoriesErr + "The value in field category_id is incorrect.<br>";
    }
    if ( ! isNumber(fldparent_category_id)) {
      scategoriesErr = scategoriesErr + "The value in field Parent Category is incorrect.<br>";
    }
      if ( scategoriesErr.length() > 0) {
        session.setAttribute("scategoriesErr", scategoriesErr );
        return;
      }
    }

  sSQL = "";
  // Create SQL statement

      switch (iAction) {
  
        case iinsertAction : 
          
            sSQL = "insert into links_categories (" + 
                "category_desc," +
                "parent_category_id)" +
            
                " values (" + 
                toSQL(fldcategory_desc, Text_TYPE) + "," +
                toSQL(fldparent_category_id, Number_TYPE) + ")";
          break;
  
      case iupdateAction:
        
          sSQL = "update links_categories set " +
                "category_desc=" + toSQL(fldcategory_desc, Text_TYPE) +
                ",parent_category_id=" + toSQL(fldparent_category_id, Number_TYPE);
          sSQL = sSQL + " where " + sWhere;
        break;
      
      case ideleteAction:
           sSQL = "delete from links_categories where " + sWhere;
          
        break;
  
  }

      if ( ( (String) session.getAttribute("scategoriesErr") ).length() > 0 ) return;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        session.putValue("scategoriesErr",proceedError(response, e));
        return;
      }    

      try{
        try {
          if ( stat != null )  { stat.close(); stat = null; }
          if ( conn != null ) { conn.close(); conn = null; }
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect(sActionFileName + sParams);
        addSessionError("sAdminCategoriesRecordErr", "sendRedirect", session);
        
        return;
      }catch(java.io.IOException e)   {};
}


void categories_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {

  
  
  sAction = getParam(request, "FormAction", Text_TYPE);
  sForm = getParam(request, "FormName", Text_TYPE);
  java.util.Hashtable rsHash = new java.util.Hashtable();

  
  String sWhere = "";
  String transitParams = "";
  String requiredParams = "";
  String primaryKeyParams ="";
  
  String pcategory_id = "";

      String fldcat_id="";
      String fldcategory_id="";
      String fldcategory_desc="";
      String fldparent_category_id="";

boolean bPK = true;
  if ( "".equals((String) session.getAttribute("scategoriesErr"))) {
    // Load primary key and form parameters
    fldcat_id = getParam( request, "cat_id");
    fldcategory_id = getParam( request, "category_id");
    oTpl.setVar ("Trn_cat_id", getParam( request, "cat_id"));
    oTpl.setVar ("Trn_category_id", getParam( request, "category_id"));
    pcategory_id = getParam( request, "cat_id");
    oTpl.setVar ("categoriesError", "");
  }
  else {
    // Load primary key, form parameters and form fields
    fldcategory_id = getParam(request,"category_id");
    fldcategory_desc = getParam(request,"category_desc");
    fldparent_category_id = getParam(request,"parent_category_id");
    oTpl.setVar("Trn_cat_id", getParam(request,"Trn_cat_id"));
    oTpl.setVar("Trn_category_id", getParam(request,"Trn_category_id"));
    pcategory_id = getParam(request,"PK_cat_id");
    oTpl.setVar ("scategoriesErr", (String) session.getAttribute("scategoriesErr"));
    oTpl.parse ("categoriesError", false);
  }
  
  if ( isEmpty(pcategory_id) ) { bPK = false; }

  
    sWhere = sWhere + "category_id=" + toSQL(pcategory_id, Number_TYPE);
    oTpl.setVar ("PK_category_id", pcategory_id);
  java.sql.ResultSet rs = null;

  String sSQL = "select * from links_categories where " + sWhere;

  if (bPK && ! (sAction.equals("insert") && "categories".equals(sForm) )) {
    try {
      // Open recordset
      rs = openrs ( stat, sSQL);
      rs.next();
      String[] aFields = getFieldsName( rs );
      getRecordToHash( rs, rsHash, aFields );
      rs.close();
      fldcategory_id = (String) rsHash.get("category_id");
      if ( "".equals((String) session.getAttribute("scategoriesErr"))) {
        // Load data from recordset when form displayed first time
        fldcategory_desc = (String) rsHash.get("category_desc");
        fldparent_category_id = (String) rsHash.get("parent_category_id");
      }
    }
    catch(java.sql.SQLException e){out.print("SQL :"+ sSQL+"<br>"+e);};

    
    oTpl.setVar ("categoriesInsert", "");
    oTpl.parse ("categoriesEdit", false);
  }
  else {
    if ( "".equals((String) session.getAttribute("scategoriesErr"))) {
      fldcategory_id = toHTML(getParam( request, "cat_id"));
      fldparent_category_id = toHTML(getParam( request, "category_id"));
    }
    oTpl.setVar ("categoriesEdit", "");
    oTpl.parse ("categoriesInsert", false);
  }
  oTpl.parse ("categoriesCancel", false);
  // Show form field
  oTpl.setVar ("category_id", toHTML(fldcategory_id));oTpl.setVar ("category_desc", toHTML(fldcategory_desc));getOptions( conn, "select category_id, category_desc from links_categories order by 2",false,false,fldparent_category_id,"LBparent_category_id",oTpl);
  oTpl.parse ("Formcategories", false);
  

}
%><%@ include file="LHeader.jsp" %>
</div></th>
    </tr>
  </table>
</div>
<jsp:include page="Addlogde.jsp"/>
<jsp:include page="Footer.jsp"/>
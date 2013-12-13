<%@ include file="LTemplateObj.jsp" %>
<%@ include file="LCommon.jsp" %>
<link rel="stylesheet" href="css.css" />

<div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">
<%!
//   Filename: LinkNew.jsp
//   Generated with CodeCharge 1.2.0
//   JSPTemplates build 05/21/2001

String sFileName = "LLinkNew.jsp";

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



session.putValue("sLinkErr","");
session.putValue("sTreeErr","");

String sTemplateFileName = "LLinkNew.html";





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

if (sForm.equalsIgnoreCase("Link")) {
  LinkAction( request, response, session, out, sForm, sAction, conn, stat, oTpl);
  if ("sendRedirect".equals(((String) session.getAttribute("sLinkErr"))) ) {
    if ( stat != null )  { stat.close(); stat = null; }
    if ( conn != null ) { conn.close(); conn = null; }
    return;
  }
}
if (sForm.equalsIgnoreCase("Tree")) {
  TreeAction( request, response, session, out, sForm, sAction, conn, stat, oTpl);
  if ("sendRedirect".equals(((String) session.getAttribute("sTreeErr"))) ) {
    if ( stat != null )  { stat.close(); stat = null; }
    if ( conn != null ) { conn.close(); conn = null; }
    return;
  }
}
Menu_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
Link_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
Tree_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
oTpl.parse("Header", false);
oTpl.parse("main", false);
out.print(oTpl.printVar("main"));


if ( stat != null )  { stat.close(); stat = null; }
if ( conn != null ) { conn.close(); conn = null; }

%><%!





void LinkAction( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {
    
    String sActionFileName = "LDefault.jsp";
    String sParams = "";
    String sWhere =" ";
    long iCount = 0;
    String sLinkErr = "";
    
    
    String sSQL ="";
  
    String pPKlink_id = "";                    
    if ("cancel".equals(sAction)) {
        try{
          try {
            if ( stat != null )  { stat.close(); stat = null; }
            if ( conn != null ) { conn.close(); conn = null; }
          }
          catch ( java.sql.SQLException ignore ) {}
          response.sendRedirect(sActionFileName);
          addSessionError("sLinkNewErr", "sendRedirect", session);
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
  
  

      String fldcategory_id="";
      String fldname="";
      String fldlink_url="";
      String flddescription="";
      String fldadd_date="";
      String fldlink_id="";

    // Load all form fields into variables
    
    fldcategory_id = getParam( request, "Rqd_category_id");
    fldname = getParam( request, "name");
    fldlink_url = getParam( request, "link_url");
    flddescription = getParam( request, "description");
    fldadd_date = getParam( request, "add_date");
  // Validate fields
  if ( iAction == iinsertAction || iAction == iupdateAction ) {
    if (isEmpty(fldname)) {
      sLinkErr = sLinkErr + "The value in field Name* is required.<br>";
    }
    if (isEmpty(fldlink_url)) {
      sLinkErr = sLinkErr + "The value in field URL* is required.<br>";
    }
    if ( ! isNumber(fldlink_id)) {
      sLinkErr = sLinkErr + "The value in field link_id is incorrect.<br>";
    }
    if ( ! isNumber(fldcategory_id)) {
      sLinkErr = sLinkErr + "The value in field Category is incorrect.<br>";
    }
      if ( sLinkErr.length() > 0) {
        session.setAttribute("sLinkErr", sLinkErr );
        return;
      }
    }

  sSQL = "";
  // Create SQL statement

      switch (iAction) {
  
        case iinsertAction : 
          
            sSQL = "insert into links (" + 
                "category_id," +
                "name," +
                "url," +
                "description," +
                "add_date)" +
            
                " values (" + 
                toSQL(fldcategory_id, Number_TYPE) + "," +
                toSQL(fldname, Text_TYPE) + "," +
                toSQL(fldlink_url, Text_TYPE) + "," +
                toSQL(flddescription, Text_TYPE) + "," +
                toSQL(fldadd_date, Date_TYPE) + ")";
          break;
  
  }

      if ( ( (String) session.getAttribute("sLinkErr") ).length() > 0 ) return;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        session.putValue("sLinkErr",proceedError(response, e));
        return;
      }    

      try{
        try {
          if ( stat != null )  { stat.close(); stat = null; }
          if ( conn != null ) { conn.close(); conn = null; }
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect(sActionFileName);
        addSessionError("sLinkNewErr", "sendRedirect", session);
        
        return;
      }catch(java.io.IOException e)   {};
}


void Link_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {

  
  
  sAction = getParam(request, "FormAction", Text_TYPE);
  sForm = getParam(request, "FormName", Text_TYPE);
  java.util.Hashtable rsHash = new java.util.Hashtable();

  
  String sWhere = "";
  String transitParams = "";
  String requiredParams = "";
  String primaryKeyParams ="";
  
  String plink_id = "";

      String fldcategory_id="";
      String fldlink_id="";
      String fldname="";
      String fldlink_url="";
      String flddescription="";
      String fldadd_date="";

boolean bPK = true;
  if ( "".equals((String) session.getAttribute("sLinkErr"))) {
    // Load primary key and form parameters
    fldcategory_id = getParam( request, "category_id");
    oTpl.setVar ("Rqd_category_id", getParam( request, "category_id"));
    plink_id = getParam( request, "link_id");
    oTpl.setVar ("LinkError", "");
  }
  else {
    // Load primary key, form parameters and form fields
    fldlink_id = getParam(request,"link_id");
    fldname = getParam(request,"name");
    fldlink_url = getParam(request,"link_url");
    flddescription = getParam(request,"description");
    fldadd_date = getParam(request,"add_date");
    oTpl.setVar("Rqd_category_id", getParam(request,"Rqd_category_id"));
    plink_id = getParam(request,"PK_link_id");;
    oTpl.setVar ("sLinkErr", (String) session.getAttribute("sLinkErr"));
    oTpl.parse ("LinkError", false);
  }
  
  if ( isEmpty(plink_id) ) { bPK = false; }

  
    sWhere = sWhere + "link_id=" + toSQL(plink_id, Number_TYPE);
    oTpl.setVar ("PK_link_id", plink_id);
  java.sql.ResultSet rs = null;

  String sSQL = "select * from links where " + sWhere;

  if (bPK && ! (sAction.equals("insert") && "Link".equals(sForm) )) {
    try {
      // Open recordset
      rs = openrs ( stat, sSQL);
      rs.next();
      String[] aFields = getFieldsName( rs );
      getRecordToHash( rs, rsHash, aFields );
      rs.close();
      fldlink_id = (String) rsHash.get("link_id");
      fldcategory_id = (String) rsHash.get("category_id");
      fldadd_date = (String) rsHash.get("add_date");
      if ( "".equals((String) session.getAttribute("sLinkErr"))) {
        // Load data from recordset when form displayed first time
        fldname = (String) rsHash.get("name");
        fldlink_url = (String) rsHash.get("url");
        flddescription = (String) rsHash.get("description");
      }
    }
    catch(java.sql.SQLException e){out.print("SQL :"+ sSQL+"<br>"+e);};

    oTpl.setVar ("LinkDelete", "");oTpl.setVar ("LinkUpdate", "");
    oTpl.setVar ("LinkInsert", "");
    
  }
  else {
    if ( "".equals((String) session.getAttribute("sLinkErr"))) {
      fldcategory_id = toHTML(getParam( request, "category_id"));
    }
    oTpl.setVar ("LinkEdit", "");
    oTpl.parse ("LinkInsert", false);
fldadd_date = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
  }
  oTpl.parse ("LinkCancel", false);
  // Set lookup fields
  fldcategory_id = dLookUp(stat,  "links_categories", "category_desc", "category_id=" + toSQL(fldcategory_id, Number_TYPE));
  // Show form field
  oTpl.setVar ("link_id", toHTML(fldlink_id));
  oTpl.setVar ("category_id", toHTML(fldcategory_id));oTpl.setVar ("name", toHTML(fldname));oTpl.setVar ("link_url", toHTML(fldlink_url));oTpl.setVar ("description", toHTML(flddescription));oTpl.setVar ("add_date", toHTML(fldadd_date));
  oTpl.parse ("FormLink", false);
  

}
%><%!
void TreeAction( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {
  
  String sCatID = getParam(request, "category_id", Number_TYPE);
  if (!isEmpty(sCatID)) {
    if ("0".equals(dLookUp(stat, "links_categories", "count(*)", "parent_category_id=" + sCatID))) {
      try {
        try {
          if ( stat != null )  { stat.close(); stat = null; }
          if ( conn != null ) { conn.close(); conn = null; }
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect("LLinkNew.jsp?category_id=" +sCatID);
        addSessionError("sLinkNewErr", "sendRedirect", session);
        return;
      }
      catch(java.io.IOException ioe) {}
    }   
    
  }
}

void Tree_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.sql.SQLException
{
  
  String sWhere="";
  java.sql.ResultSet rs=null;
  String sSQL ="";
  String sCatID = "";
  String sParCatID ="";
  oTpl.setVar ("category_id", "");
  oTpl.setVar ("category_desc", "");
  oTpl.setVar ("parent_category_id", "");
  oTpl.setVar ("ActionPage", "LLinkNew.jsp");
  sSQL = "select category_id, category_desc, parent_category_id from links_categories";
  sCatID = getParam(request, "category_id", Number_TYPE);
  
  if (isEmpty(sCatID)){
    // Root category
    sWhere = " where parent_category_id is Null";
    oTpl.setVar ("CurrentCategory", "");
    oTpl.setVar ("CatPath", "");
  }
  else {
    // Subcategory
    sWhere = " where category_id=" +sCatID;
    try {
      rs = openrs (stat, sSQL + sWhere);
      if (! rs.next()) {
        rs.close();
        rs = null;
      }
    }
    catch (java.sql.SQLException sqle) {
      rs = null;
    }
    java.util.Hashtable rsHash = new java.util.Hashtable();
    // Build Path
    if ( rs != null ) {
      String[] aFields = getFieldsName( rs );
      getRecordToHash( rs, rsHash, aFields );
      rs.close();
    }
    oTpl.setVar ("CurrentCategory", " > "+ toHTML((String) rsHash.get("category_desc")));
    sParCatID = toHTML((String) rsHash.get("parent_category_id"));
    rs = null;
    if ("".equals(sParCatID)) oTpl.setVar ("CatPath", "");
    String sPath = "";
    while (!"".equals(sParCatID)){
      try {
        rs = openrs (stat, sSQL + " where category_id=" + sParCatID);
        if (! rs.next()) {
          rs.close();
          rs = null;
        }
      }
      catch (java.sql.SQLException sqle) {
        rs = null;
      }
      if ( rs != null ) {
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
      }
      sParCatID = toHTML((String) rsHash.get("parent_category_id"));
      sPath = replace(replace(oTpl.getVar("CatPath"), "{CategoryID}", toHTML((String) rsHash.get("category_id"))), "{Category}", toHTML((String) rsHash.get("category_desc"))) +sPath;
      rs = null;
    }
    oTpl.dBlocks.put("CatPath", sPath);
    oTpl.parse ("CatPath", false);
    sWhere = " where parent_category_id=" + sCatID;
  }
  try {
    // links_categories list
    rs = openrs (stat,  sSQL + sWhere);
    if (! rs.next()) {
      rs.close();
      rs = null;
    }
  } catch (java.sql.SQLException sqle) {
    rs = null;  
  }
  if (rs!=null) {
    boolean EOF=false;
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );
    // Print subcategories
    while (!EOF){
      getRecordToHash( rs, rsHash, aFields );
      oTpl.setVar ("CategoryID", toHTML((String) rsHash.get("category_id")));
      oTpl.setVar ("Category", toHTML((String) rsHash.get("category_desc")));
    
      oTpl.parse ("CategoryList", true);
      try {
        EOF = !rs.next();
      }
      catch (java.sql.SQLException sqle) {
        EOF = true;
      }
    }
    rs.close();
    oTpl.parse ("FormTree", false);
  
  }
  else{
    // No subcategories
    oTpl.setVar ("CategoryList", "");
    oTpl.parse ("FormTree", false);
  
  }
}
%><%@ include file="LHeader.jsp" %>
              </div></th>
    </tr>
  </table>
</div>
<jsp:include page="Addlogde.jsp"/>
<jsp:include page="Footer.jsp"/>

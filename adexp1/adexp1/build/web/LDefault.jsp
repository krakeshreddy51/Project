<%@ include file="LTemplateObj.jsp" %>
<%@ include file="LCommon.jsp" %>
<div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">
<%!
//   Filename: Default.jsp
//   Generated with CodeCharge 1.2.0
//   JSPTemplates build 05/21/2001

String sFileName = "LDefault.jsp";

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



session.putValue("sTreeErr","");

String sTemplateFileName = "LDefault.html";





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

if (sForm.equalsIgnoreCase("Tree")) {
  TreeAction( request, response, session, out, sForm, sAction, conn, stat, oTpl);
  if ("sendRedirect".equals(((String) session.getAttribute("sTreeErr"))) ) {
    if ( stat != null )  { stat.close(); stat = null; }
    if ( conn != null ) { conn.close(); conn = null; }
    return;
  }
}
Menu_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
Search_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
Lates_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
Tree_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
oTpl.parse("Header", false);
oTpl.parse("main", false);
out.print(oTpl.printVar("main"));


if ( stat != null )  { stat.close(); stat = null; }
if ( conn != null ) { conn.close(); conn = null; }

%><%!
void Search_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {



      String flddescription="";

  String sSQL = "";
      
  oTpl.setVar ("ActionPage", "LItemsList.jsp");

  // Set variables with search parameters
  
  flddescription = getParam(request, "description");
  // Show fields
      
oTpl.setVar ("description", toHTML(flddescription));
  oTpl.parse ("FormSearch", false);
}
%><%!



void Lates_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {
  

boolean bReq =false;

String sWhere = "";

boolean HasParam = false;





  String sOrder="";
  String sDirection = "";
  String sSortParams = "";
  String sSQL="";


  oTpl.setVar ("TransitParams", "");
  oTpl.setVar ("FormParams", "");
  // Build WHERE statement

  sWhere = " WHERE approved=1";
  
  // Build ORDER statement
  sOrder = " order by l.add_date Desc";

  // Build full SQL statement

  sSQL = "select l.add_date as l_add_date, " +
    "l.link_id as l_link_id, " +
    "l.name as l_name, " +
    "l.url as l_url " +
    " from links l ";
  
  sSQL = sSQL + sWhere + sOrder;
    // Select current page
    int iPage;
    try{
      iPage = Integer.parseInt(getParam(request, "FormLates_Page", Number_TYPE));
    }
    catch(Exception e){iPage =1;}
    if (iPage < 1) iPage = 1;

    int RecordsPerPage = 5;
    int startRec = (iPage-1)*RecordsPerPage+1;
  
  java.sql.ResultSet rs = null;
  try{
    // Open recordset
    rs = openrs (stat, sSQL);
    if ((rs==null) || (!rs.next())) {
      // Recordset is empty
      if ( rs != null ) rs.close();
      oTpl.setVar ("DListLates", "");
      oTpl.parse ("LatesNoRecords", false);
      oTpl.setVar ("LatesScroller", "");
      oTpl.parse ("FormLates", false);
      return;
    }

    absolute(rs,startRec);
    int iCounter = 0;
    boolean EOF=false;

    String[] aFields = getFieldsName( rs );
    java.util.Hashtable rsHash = new java.util.Hashtable();

    // Show main table based on recordset
    while ((!EOF)  && (iCounter < RecordsPerPage) ){

      getRecordToHash( rs, rsHash, aFields );
      String fldadd_date = (String) rsHash.get("l_add_date");
      String fldlink_id = (String) rsHash.get("l_link_id");
      String fldname = (String) rsHash.get("l_name");
oTpl.setVar ("link_id", toHTML(fldlink_id));
  oTpl.setVar ("name", toHTML(fldname));
  oTpl.setVar ("name_URLLink", (String) rsHash.get("l_url"));
  oTpl.setVar ("add_date", toHTML(fldadd_date));
      oTpl.parse ("DListLates", true);
      
      iCounter++;
      EOF = !rs.next();       
    }
    rs.close();
  
    // Parse scroller
    if ((EOF) && (iPage == 1)) 
      oTpl.setVar ("LatesScroller", "");
    else {
      if (EOF) 
        oTpl.setVar ("LatesScrollerNextSwitch", "_");
      else {
        oTpl.setVar ( "NextPage", Integer.toString((iPage + 1)));
        oTpl.setVar ( "LatesScrollerNextSwitch", "");
      }
      if (iPage == 1) 
        oTpl.setVar ( "LatesScrollerPrevSwitch", "_");
      else {
        oTpl.setVar ( "PrevPage", Integer.toString((iPage - 1)));
        oTpl.setVar ( "LatesScrollerPrevSwitch", "");
      }
      oTpl.setVar ( "LatesCurrentPage", Integer.toString(iPage));
      oTpl.parse ( "LatesScroller", false);
    }
  
  oTpl.setVar ( "LatesNoRecords", "");
  oTpl.parse ( "FormLates", false);
  

  } catch(java.sql.SQLException e){
      out.print("SQL ERROR !"+e);
      oTpl.setVar ("DListLates", "");
      oTpl.parse ("LatesNoRecords", false);
      oTpl.setVar ("LatesScroller", "");
      oTpl.parse ("FormLates", false);
  };
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
        response.sendRedirect("LBrowseCategories.jsp?category_id=" +sCatID);
        addSessionError("sDefaultErr", "sendRedirect", session);
        return;
      }
      catch(java.io.IOException ioe) {}
    }   
    
    else {
      try {
       try {
          if ( stat != null )  { stat.close(); stat = null; }
          if ( conn != null ) { conn.close(); conn = null; }
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect("LBrowseCategories.jsp?category_id=" + sCatID);
        addSessionError("sDefaultErr", "sendRedirect", session);
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
  oTpl.setVar ("ActionPage", "LBrowseCategories.jsp");
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
    // Categories list
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
<div id="Layer1"><img src="imges/Reklama-Majas-lapu-izstrade.jpg" width="694" height="344" /></div>

<jsp:include page="Addlogde.jsp"/>

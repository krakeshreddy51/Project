<%@ include file="LTemplateObj.jsp" %>
<%@ include file="LCommon.jsp" %>
<link rel="stylesheet" href="css.css" />

<div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">
<%!
//   Filename: AdminLinksGrid.jsp
//   Generated with CodeCharge 1.2.0
//   JSPTemplates build 05/21/2001

String sFileName = "LAdminLinksGrid.jsp";

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




String sTemplateFileName = "LAdminLinksGrid.html";



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

Menu_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
Links_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
Search_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
oTpl.parse("Header", false);
oTpl.parse("main", false);
out.print(oTpl.printVar("main"));


if ( stat != null )  { stat.close(); stat = null; }
if ( conn != null ) { conn.close(); conn = null; }

%><%!

String sField1 = "Edit";

void Links_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {
  

boolean bReq =false;

String sWhere = "";

boolean HasParam = false;


      String papproved="";
      String pcategory_id="";
      String pname="";


  oTpl.setVar ("TransitParams", "approved=" + toURL(getParam(request, "approved")) + "&name=" + toURL(getParam(request, "name")) + "&category_id=" + toURL(getParam(request, "category_id")) + "&");

  String sOrder="";
  String sDirection = "";
  String sSortParams = "";
  String sSQL="";


  oTpl.setVar ("TransitParams", "approved=" + toURL(getParam( request, "approved", Number_TYPE)) + "&name=" + toURL(getParam( request, "name", Text_TYPE)) + "&category_id=" + toURL(getParam( request, "category_id", Number_TYPE)) + "&");
  oTpl.setVar ("FormParams", "approved=" + toURL(getParam(request,"approved")) + "&name=" + toURL(getParam(request,"name")) + "&category_id=" + toURL(getParam(request,"category_id")) + "&");
  // Build WHERE statement

  papproved = getParam(request, "approved", Number_TYPE);if (!isNumber (papproved)) papproved = "";
  if (!isEmpty(papproved)) {
    HasParam = true;
    sWhere = sWhere +"l.approved=" + papproved;
  }
  pcategory_id = getParam(request, "category_id", Number_TYPE);if (!isNumber (pcategory_id)) pcategory_id = "";
  if (!isEmpty(pcategory_id)) {
    if (!("".equals(sWhere)))  sWhere = sWhere + " and ";
    HasParam = true;
    sWhere = sWhere +"l.category_id=" + pcategory_id;
  }
  pname = getParam(request, "name", Text_TYPE);
  if (!isEmpty(pname)) {
    if (!("".equals(sWhere)))  sWhere = sWhere + " and ";
    HasParam = true;
    sWhere = sWhere +"l.name like '%" + replace(pname, "'", "''") + "%'";
  }
  if (HasParam) { sWhere = " AND (" + sWhere + ")"; }
  // Build ORDER statement;
  String iSort = getParam(request, "FormLinks_Sorting", Number_TYPE);
  String iSorted = getParam(request, "FormLinks_Sorted", Number_TYPE);

  if (isEmpty(iSort)) oTpl.setVar ("Form_Sorting", "");
  else {
    if (iSort.equals(iSorted)) {
      oTpl.setVar ("Form_Sorting", "");
      sDirection = " DESC";
      sSortParams = "FormLinks_Sorting=" + iSort +"&FormLinks_Sorted=" + iSort + "&";
    }
    else{
      oTpl.setVar ("Form_Sorting", iSort);
      sDirection = " ASC";
      sSortParams = "FormLinks_Sorting=" + iSort + "&FormLinks_Sorted=" + "&";
    }
    try{
    int isort = Integer.parseInt(iSort);
  
  
    if (isort == 1) sOrder = " order by l.name" + sDirection ;
    
    if (isort == 2) sOrder = " order by c.category_desc" + sDirection ;
    
    if (isort == 3) sOrder = " order by l.approved" + sDirection ;
    
    }catch(Exception e ){};
  }
  

  // Build full SQL statement

  sSQL = "select l.approved as l_approved, " +
    "l.category_id as l_category_id, " +
    "l.link_id as l_link_id, " +
    "l.name as l_name, " +
    "c.category_id as c_category_id, " +
    "c.category_desc as c_category_desc " +
    " from links l, links_categories c" +
    " where c.category_id=l.category_id  ";
  
  sSQL = sSQL + sWhere + sOrder;
  oTpl.setVar ("FormAction", "LAdminLinksRecord.jsp");
  oTpl.setVar ("SortParams", sSortParams);
    // Select current page
    int iPage;
    try{
      iPage = Integer.parseInt(getParam(request, "FormLinks_Page", Number_TYPE));
    }
    catch(Exception e){iPage =1;}
    if (iPage < 1) iPage = 1;

    int RecordsPerPage = 20;
    int startRec = (iPage-1)*RecordsPerPage+1;
  
  java.sql.ResultSet rs = null;
  try{
    // Open recordset
    rs = openrs (stat, sSQL);
    if ((rs==null) || (!rs.next())) {
      // Recordset is empty
      if ( rs != null ) rs.close();
      oTpl.setVar ("DListLinks", "");
      oTpl.parse ("LinksNoRecords", false);
      oTpl.setVar ("LinksScroller", "");
      oTpl.parse ("FormLinks", false);
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
      String fldapproved = (String) rsHash.get("l_approved");
      String fldcategory_id = (String) rsHash.get("c_category_desc");
      String fldname = (String) rsHash.get("l_name");
      String fldField1= "Edit";

  oTpl.setVar ("Field1", toHTML(fldField1));
  oTpl.setVar ("Field1_URLLink", "LAdminLinksRecord.jsp");
  oTpl.setVar ("Prm_link_id", toURL((String) rsHash.get("l_link_id"))); 
  oTpl.setVar ("name", toHTML(fldname));
  oTpl.setVar ("category_id", toHTML(fldcategory_id));
  fldapproved = getValFromLOV(fldapproved, "0;No;1;Yes");
  oTpl.setVar ("approved", toHTML(fldapproved));
      oTpl.parse ("DListLinks", true);
      
      iCounter++;
      EOF = !rs.next();       
    }
    rs.close();
  
    // Parse scroller
    if ((EOF) && (iPage == 1)) 
      oTpl.setVar ("LinksScroller", "");
    else {
      if (EOF) 
        oTpl.setVar ("LinksScrollerNextSwitch", "_");
      else {
        oTpl.setVar ( "NextPage", Integer.toString((iPage + 1)));
        oTpl.setVar ( "LinksScrollerNextSwitch", "");
      }
      if (iPage == 1) 
        oTpl.setVar ( "LinksScrollerPrevSwitch", "_");
      else {
        oTpl.setVar ( "PrevPage", Integer.toString((iPage - 1)));
        oTpl.setVar ( "LinksScrollerPrevSwitch", "");
      }
      oTpl.setVar ( "LinksCurrentPage", Integer.toString(iPage));
      oTpl.parse ( "LinksScroller", false);
    }
  
  oTpl.setVar ( "LinksNoRecords", "");
  oTpl.parse ( "FormLinks", false);
  

  } catch(java.sql.SQLException e){
      out.print("SQL ERROR !"+e);
      oTpl.setVar ("DListLinks", "");
      oTpl.parse ("LinksNoRecords", false);
      oTpl.setVar ("LinksScroller", "");
      oTpl.parse ("FormLinks", false);
  };
}   
%><%!
void Search_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {




      String fldname="";
      String fldapproved="";

  String sSQL = "";
      
  oTpl.setVar ("ActionPage", "LAdminLinksGrid.jsp");

  // Set variables with search parameters
  
  fldname = getParam(request, "name");
  fldapproved = getParam(request, "approved");
  // Show fields
      
oTpl.setVar ("name", toHTML(fldname));getOptionsLOV(";All;0;No;1;Yes",true,false,fldapproved,"LBapproved",oTpl);
  oTpl.parse ("FormSearch", false);
}
%><%@ include file="LHeader.jsp" %>
             dfsdfdfdfdfdfdfdfdf
          </div></th>
    </tr>
  </table>
</div>
<jsp:include page="Addlogde.jsp"/>
<jsp:include page="Footer.jsp"/>

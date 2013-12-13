<%@ include file="LTemplateObj.jsp" %><%@ include file="LCommon.jsp" %><%!
//   Filename: AdminUsersGrid.jsp
//   Generated with CodeCharge 1.2.0
//   JSPTemplates build 05/21/2001

String sFileName = "LAdminUsersGrid.jsp";

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




String sTemplateFileName = "LAdminUsersGrid.html";



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
Users_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
oTpl.parse("Header", false);
oTpl.parse("main", false);
out.print(oTpl.printVar("main"));


if ( stat != null )  { stat.close(); stat = null; }
if ( conn != null ) { conn.close(); conn = null; }

%><%!



void Users_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {
  

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

  // Build ORDER statement
  sOrder = " order by u.member_login Asc";
  String iSort = getParam(request, "FormUsers_Sorting", Number_TYPE);
  String iSorted = getParam(request, "FormUsers_Sorted", Number_TYPE);

  if (isEmpty(iSort)) oTpl.setVar ("Form_Sorting", "");
  else {
    if (iSort.equals(iSorted)) {
      oTpl.setVar ("Form_Sorting", "");
      sDirection = " DESC";
      sSortParams = "FormUsers_Sorting=" + iSort +"&FormUsers_Sorted=" + iSort + "&";
    }
    else{
      oTpl.setVar ("Form_Sorting", iSort);
      sDirection = " ASC";
      sSortParams = "FormUsers_Sorting=" + iSort + "&FormUsers_Sorted=" + "&";
    }
    try{
    int isort = Integer.parseInt(iSort);
  
  
    if (isort == 1) sOrder = " order by u.member_login" + sDirection ;
    
    if (isort == 2) sOrder = " order by u.name" + sDirection ;
    
    if (isort == 3) sOrder = " order by u.member_level" + sDirection ;
    
    }catch(Exception e ){};
  }
  

  // Build full SQL statement

  sSQL = "select u.name as u_name, " +
    "u.member_id as u_member_id, " +
    "u.member_level as u_member_level, " +
    "u.member_login as u_member_login " +
    " from members u ";
  
  sSQL = sSQL + sWhere + sOrder;
  oTpl.setVar ("FormAction", "LAdminUsersRecord.jsp");
  oTpl.setVar ("SortParams", sSortParams);
    // Select current page
    int iPage;
    try{
      iPage = Integer.parseInt(getParam(request, "FormUsers_Page", Number_TYPE));
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
      oTpl.setVar ("DListUsers", "");
      oTpl.parse ("UsersNoRecords", false);
      oTpl.setVar ("UsersScroller", "");
      oTpl.parse ("FormUsers", false);
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
      String fldname = (String) rsHash.get("u_name");
      String fldmember_level = (String) rsHash.get("u_member_level");
      String fldmember_login = (String) rsHash.get("u_member_login");

  oTpl.setVar ("member_login", toHTML(fldmember_login));
  oTpl.setVar ("member_login_URLLink", "LAdminUsersRecord.jsp");
  oTpl.setVar ("Prm_member_id", toURL((String) rsHash.get("u_member_id"))); 
  oTpl.setVar ("name", toHTML(fldname));
  fldmember_level = getValFromLOV(fldmember_level, "1;Guest;2;Member;3;Admin");
  oTpl.setVar ("member_level", toHTML(fldmember_level));
      oTpl.parse ("DListUsers", true);
      
      iCounter++;
      EOF = !rs.next();       
    }
    rs.close();
  
    // Parse scroller
    if ((EOF) && (iPage == 1)) 
      oTpl.setVar ("UsersScroller", "");
    else {
      if (EOF) 
        oTpl.setVar ("UsersScrollerNextSwitch", "_");
      else {
        oTpl.setVar ( "NextPage", Integer.toString((iPage + 1)));
        oTpl.setVar ( "UsersScrollerNextSwitch", "");
      }
      if (iPage == 1) 
        oTpl.setVar ( "UsersScrollerPrevSwitch", "_");
      else {
        oTpl.setVar ( "PrevPage", Integer.toString((iPage - 1)));
        oTpl.setVar ( "UsersScrollerPrevSwitch", "");
      }
      oTpl.setVar ( "UsersCurrentPage", Integer.toString(iPage));
      oTpl.parse ( "UsersScroller", false);
    }
  
  oTpl.setVar ( "UsersNoRecords", "");
  oTpl.parse ( "FormUsers", false);
  

  } catch(java.sql.SQLException e){
      out.print("SQL ERROR !"+e);
      oTpl.setVar ("DListUsers", "");
      oTpl.parse ("UsersNoRecords", false);
      oTpl.setVar ("UsersScroller", "");
      oTpl.parse ("FormUsers", false);
  };
}   
%><%@ include file="LHeader.jsp" %>
<%@ include file="LTemplateObj.jsp" %><%@ include file="LCommon.jsp" %><%!
//   Filename: AdminUsersRecord.jsp
//   Generated with CodeCharge 1.2.0
//   JSPTemplates build 05/21/2001

String sFileName = "LAdminUsersRecord.jsp";

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



session.putValue("sUsersErr","");

String sTemplateFileName = "LAdminUsersRecord.html";



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

if (sForm.equalsIgnoreCase("Users")) {
  UsersAction( request, response, session, out, sForm, sAction, conn, stat, oTpl);
  if ("sendRedirect".equals(((String) session.getAttribute("sUsersErr"))) ) {
    if ( stat != null )  { stat.close(); stat = null; }
    if ( conn != null ) { conn.close(); conn = null; }
    return;
  }
}
Menu_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
Users_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
oTpl.parse("Header", false);
oTpl.parse("main", false);
out.print(oTpl.printVar("main"));


if ( stat != null )  { stat.close(); stat = null; }
if ( conn != null ) { conn.close(); conn = null; }

%><%!





void UsersAction( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {
    
    String sActionFileName = "LAdminUsersGrid.jsp";
    String sParams = "";
    String sWhere =" ";
    long iCount = 0;
    String sUsersErr = "";
    
    
    String sSQL ="";
  
    String pPKmember_id = "";                    
    if ("cancel".equals(sAction)) {
        try{
          try {
            if ( stat != null )  { stat.close(); stat = null; }
            if ( conn != null ) { conn.close(); conn = null; }
          }
          catch ( java.sql.SQLException ignore ) {}
          response.sendRedirect(sActionFileName);
          addSessionError("sAdminUsersRecordErr", "sendRedirect", session);
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
      pPKmember_id = getParam( request, "PK_member_id");
      if ( isEmpty(pPKmember_id)) return;
      sWhere = "member_id=" + toSQL(pPKmember_id, Number_TYPE);
    }
  

      String fldmember_login="";
      String fldmember_password="";
      String fldmember_level="";
      String fldname="";
      String fldemail="";
      String fldmember_id="";

    // Load all form fields into variables
    
    fldmember_login = getParam( request, "member_login");
    fldmember_password = getParam( request, "member_password");
    fldmember_level = getParam( request, "member_level");
    fldname = getParam( request, "name");
    fldemail = getParam( request, "email");
  // Validate fields
  if ( iAction == iinsertAction || iAction == iupdateAction ) {
    if (isEmpty(fldmember_login)) {
      sUsersErr = sUsersErr + "The value in field Login is required.<br>";
    }
    if (isEmpty(fldmember_password)) {
      sUsersErr = sUsersErr + "The value in field Password is required.<br>";
    }
    if (isEmpty(fldmember_level)) {
      sUsersErr = sUsersErr + "The value in field Level is required.<br>";
    }
    if (isEmpty(fldname)) {
      sUsersErr = sUsersErr + "The value in field Name is required.<br>";
    }
    if ( ! isNumber(fldmember_id)) {
      sUsersErr = sUsersErr + "The value in field member_id is incorrect.<br>";
    }
    if ( ! isNumber(fldmember_level)) {
      sUsersErr = sUsersErr + "The value in field Level is incorrect.<br>";
    }
    if ( ! isEmpty(fldmember_login)) {
      iCount = 0;
      if ( iAction == iinsertAction ) {
        iCount = dCountRec(stat, "members", "member_login=" + toSQL(fldmember_login, Text_TYPE));
      }
      else {
        if ( iAction == iupdateAction ) {
          iCount = dCountRec( stat, "members", "member_login=" + toSQL(fldmember_login, Text_TYPE) + " and not(" + sWhere + ")");
        }
      }
      if ( iCount > 0 ) {
        sUsersErr = sUsersErr + "The value in field Login is already in database.<br>";
      }
    }
      if ( sUsersErr.length() > 0) {
        session.setAttribute("sUsersErr", sUsersErr );
        return;
      }
    }

  sSQL = "";
  // Create SQL statement

      switch (iAction) {
  
        case iinsertAction : 
          
            sSQL = "insert into members (" + 
                "member_login," +
                "member_password," +
                "member_level," +
                "name," +
                "email)" +
            
                " values (" + 
                toSQL(fldmember_login, Text_TYPE) + "," +
                toSQL(fldmember_password, Text_TYPE) + "," +
                toSQL(fldmember_level, Number_TYPE) + "," +
                toSQL(fldname, Text_TYPE) + "," +
                toSQL(fldemail, Text_TYPE) + ")";
          break;
  
      case iupdateAction:
        
          sSQL = "update members set " +
                "member_login=" + toSQL(fldmember_login, Text_TYPE) +
                ",member_password=" + toSQL(fldmember_password, Text_TYPE) +
                ",member_level=" + toSQL(fldmember_level, Number_TYPE) +
                ",name=" + toSQL(fldname, Text_TYPE) +
                ",email=" + toSQL(fldemail, Text_TYPE);
          sSQL = sSQL + " where " + sWhere;
        break;
      
      case ideleteAction:
           sSQL = "delete from members where " + sWhere;
          
        break;
  
  }

      if ( ( (String) session.getAttribute("sUsersErr") ).length() > 0 ) return;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        session.putValue("sUsersErr",proceedError(response, e));
        return;
      }    

      try{
        try {
          if ( stat != null )  { stat.close(); stat = null; }
          if ( conn != null ) { conn.close(); conn = null; }
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect(sActionFileName);
        addSessionError("sAdminUsersRecordErr", "sendRedirect", session);
        
        return;
      }catch(java.io.IOException e)   {};
}


void Users_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {

  
  
  sAction = getParam(request, "FormAction", Text_TYPE);
  sForm = getParam(request, "FormName", Text_TYPE);
  java.util.Hashtable rsHash = new java.util.Hashtable();

  
  String sWhere = "";
  String transitParams = "";
  String requiredParams = "";
  String primaryKeyParams ="";
  
  String pmember_id = "";

      String fldmember_id="";
      String fldmember_login="";
      String fldmember_password="";
      String fldmember_level="";
      String fldname="";
      String fldemail="";

boolean bPK = true;
  if ( "".equals((String) session.getAttribute("sUsersErr"))) {
    // Load primary key and form parameters
    fldmember_id = getParam( request, "member_id");
    pmember_id = getParam( request, "member_id");
    oTpl.setVar ("UsersError", "");
  }
  else {
    // Load primary key, form parameters and form fields
    fldmember_id = getParam(request,"member_id");
    fldmember_login = getParam(request,"member_login");
    fldmember_password = getParam(request,"member_password");
    fldmember_level = getParam(request,"member_level");
    fldname = getParam(request,"name");
    fldemail = getParam(request,"email");
    pmember_id = getParam(request,"PK_member_id");
    oTpl.setVar ("sUsersErr", (String) session.getAttribute("sUsersErr"));
    oTpl.parse ("UsersError", false);
  }
  
  if ( isEmpty(pmember_id) ) { bPK = false; }

  
    sWhere = sWhere + "member_id=" + toSQL(pmember_id, Number_TYPE);
    oTpl.setVar ("PK_member_id", pmember_id);
  java.sql.ResultSet rs = null;

  String sSQL = "select * from members where " + sWhere;

  if (bPK && ! (sAction.equals("insert") && "Users".equals(sForm) )) {
    try {
      // Open recordset
      rs = openrs ( stat, sSQL);
      rs.next();
      String[] aFields = getFieldsName( rs );
      getRecordToHash( rs, rsHash, aFields );
      rs.close();
      fldmember_id = (String) rsHash.get("member_id");
      if ( "".equals((String) session.getAttribute("sUsersErr"))) {
        // Load data from recordset when form displayed first time
        fldmember_login = (String) rsHash.get("member_login");
        fldmember_password = (String) rsHash.get("member_password");
        fldmember_level = (String) rsHash.get("member_level");
        fldname = (String) rsHash.get("name");
        fldemail = (String) rsHash.get("email");
      }
    }
    catch(java.sql.SQLException e){out.print("SQL :"+ sSQL+"<br>"+e);};

    
    oTpl.setVar ("UsersInsert", "");
    oTpl.parse ("UsersEdit", false);
  }
  else {
    if ( "".equals((String) session.getAttribute("sUsersErr"))) {
      fldmember_id = toHTML(getParam( request, "member_id"));
      fldmember_level= "1";
    }
    oTpl.setVar ("UsersEdit", "");
    oTpl.parse ("UsersInsert", false);
  }
  oTpl.parse ("UsersCancel", false);
  // Show form field
  oTpl.setVar ("member_id", toHTML(fldmember_id));oTpl.setVar ("member_login", toHTML(fldmember_login));oTpl.setVar ("member_password", toHTML(fldmember_password));getOptionsLOV("1;Member;3;Admin",false,true,fldmember_level,"LBmember_level",oTpl);oTpl.setVar ("name", toHTML(fldname));oTpl.setVar ("email", toHTML(fldemail));
  oTpl.parse ("FormUsers", false);
  

}
%><%@ include file="LHeader.jsp" %>
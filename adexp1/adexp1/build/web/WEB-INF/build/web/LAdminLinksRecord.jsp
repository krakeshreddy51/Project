<%@ include file="LTemplateObj.jsp" %>
<%@ include file="LCommon.jsp" %>
<link rel="stylesheet" href="css.css" />

<div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">

<%!
//   Filename: AdminLinksRecord.jsp
//   Generated with CodeCharge 1.2.0
//   JSPTemplates build 05/21/2001

String sFileName = "LAdminLinksRecord.jsp";

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



session.putValue("slinkErr","");

String sTemplateFileName = "LAdminLinksRecord.html";



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

if (sForm.equalsIgnoreCase("link")) {
  linkAction( request, response, session, out, sForm, sAction, conn, stat, oTpl);
  if ("sendRedirect".equals(((String) session.getAttribute("slinkErr"))) ) {
    if ( stat != null )  { stat.close(); stat = null; }
    if ( conn != null ) { conn.close(); conn = null; }
    return;
  }
}
Menu_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
link_Show( request, response, session, out, sForm, sAction, conn, stat, oTpl);
oTpl.parse("Header", false);
oTpl.parse("main", false);
out.print(oTpl.printVar("main"));


if ( stat != null )  { stat.close(); stat = null; }
if ( conn != null ) { conn.close(); conn = null; }

%><%!





void linkAction( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {
    
    String sActionFileName = "LAdminLinksGrid.jsp";
    String sParams = "";
    String sWhere =" ";
    long iCount = 0;
    String slinkErr = "";
    
    
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
          addSessionError("sAdminLinksRecordErr", "sendRedirect", session);
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
      pPKlink_id = getParam( request, "PK_link_id");
      if ( isEmpty(pPKlink_id)) return;
      sWhere = "link_id=" + toSQL(pPKlink_id, Number_TYPE);
    }
  

      String fldname="";
      String fldcategory_id="";
      String fldevent_url="";
      String flddescription="";
      String fldapproved="";
      String fldadd_date="";
      String fldlink_id="";

    // Load all form fields into variables
    
    fldname = getParam( request, "name");
    fldcategory_id = getParam( request, "category_id");
    fldevent_url = getParam( request, "event_url");
    flddescription = getParam( request, "description");
    fldapproved = getCheckBoxValue(getParam( request, "approved"), "1", "0", Number_TYPE);
    fldadd_date = getParam( request, "add_date");
  // Validate fields
  if ( iAction == iinsertAction || iAction == iupdateAction ) {
    if (isEmpty(fldname)) {
      slinkErr = slinkErr + "The value in field Name* is required.<br>";
    }
    if (isEmpty(fldcategory_id)) {
      slinkErr = slinkErr + "The value in field Category* is required.<br>";
    }
    if (isEmpty(fldevent_url)) {
      slinkErr = slinkErr + "The value in field URL* is required.<br>";
    }
    if (isEmpty(fldadd_date)) {
      slinkErr = slinkErr + "The value in field Add Date is required.<br>";
    }
    if ( ! isNumber(fldlink_id)) {
      slinkErr = slinkErr + "The value in field # is incorrect.<br>";
    }
    if ( ! isNumber(fldcategory_id)) {
      slinkErr = slinkErr + "The value in field Category* is incorrect.<br>";
    }
      if ( slinkErr.length() > 0) {
        session.setAttribute("slinkErr", slinkErr );
        return;
      }
    }

  sSQL = "";
  // Create SQL statement

      switch (iAction) {
  
        case iinsertAction : 
          
            sSQL = "insert into links (" + 
                "name," +
                "category_id," +
                "url," +
                "description," +
                "approved," +
                "add_date)" +
            
                " values (" + 
                toSQL(fldname, Text_TYPE) + "," +
                toSQL(fldcategory_id, Number_TYPE) + "," +
                toSQL(fldevent_url, Text_TYPE) + "," +
                toSQL(flddescription, Text_TYPE) + "," +
                fldapproved + "," +
                toSQL(fldadd_date, Date_TYPE) + ")";
          break;
  
      case iupdateAction:
        
          sSQL = "update links set " +
                "name=" + toSQL(fldname, Text_TYPE) +
                ",category_id=" + toSQL(fldcategory_id, Number_TYPE) +
                ",url=" + toSQL(fldevent_url, Text_TYPE) +
                ",description=" + toSQL(flddescription, Text_TYPE) +
                ",approved=" + fldapproved +
                ",add_date=" + toSQL(fldadd_date, Date_TYPE);
          sSQL = sSQL + " where " + sWhere;
        break;
      
      case ideleteAction:
           sSQL = "delete from links where " + sWhere;
          
        break;
  
  }

      if ( ( (String) session.getAttribute("slinkErr") ).length() > 0 ) return;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        session.putValue("slinkErr",proceedError(response, e));
        return;
      }    

      try{
        try {
          if ( stat != null )  { stat.close(); stat = null; }
          if ( conn != null ) { conn.close(); conn = null; }
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect(sActionFileName);
        addSessionError("sAdminLinksRecordErr", "sendRedirect", session);
        
        return;
      }catch(java.io.IOException e)   {};
}


void link_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {

  
  
  sAction = getParam(request, "FormAction", Text_TYPE);
  sForm = getParam(request, "FormName", Text_TYPE);
  java.util.Hashtable rsHash = new java.util.Hashtable();

  
  String sWhere = "";
  String transitParams = "";
  String requiredParams = "";
  String primaryKeyParams ="";
  
  String plink_id = "";

      String fldlink_id="";
      String fldname="";
      String fldcategory_id="";
      String fldevent_url="";
      String flddescription="";
      String fldapproved="";
      String fldadd_date="";

boolean bPK = true;
  if ( "".equals((String) session.getAttribute("slinkErr"))) {
    // Load primary key and form parameters
    plink_id = getParam( request, "link_id");
    oTpl.setVar ("linkError", "");
  }
  else {
    // Load primary key, form parameters and form fields
    fldlink_id = getParam(request,"link_id");
    fldname = getParam(request,"name");
    fldcategory_id = getParam(request,"category_id");
    fldevent_url = getParam(request,"event_url");
    flddescription = getParam(request,"description");
    fldapproved = getParam(request,"approved");
    fldadd_date = getParam(request,"add_date");
    plink_id = getParam(request,"PK_link_id");
    oTpl.setVar ("slinkErr", (String) session.getAttribute("slinkErr"));
    oTpl.parse ("linkError", false);
  }
  
  if ( isEmpty(plink_id) ) { bPK = false; }

  
    sWhere = sWhere + "link_id=" + toSQL(plink_id, Number_TYPE);
    oTpl.setVar ("PK_link_id", plink_id);
  java.sql.ResultSet rs = null;

  String sSQL = "select * from links where " + sWhere;

  if (bPK && ! (sAction.equals("insert") && "link".equals(sForm) )) {
    try {
      // Open recordset
      rs = openrs ( stat, sSQL);
      rs.next();
      String[] aFields = getFieldsName( rs );
      getRecordToHash( rs, rsHash, aFields );
      rs.close();
      fldlink_id = (String) rsHash.get("link_id");
      if ( "".equals((String) session.getAttribute("slinkErr"))) {
        // Load data from recordset when form displayed first time
        fldname = (String) rsHash.get("name");
        fldcategory_id = (String) rsHash.get("category_id");
        fldevent_url = (String) rsHash.get("url");
        flddescription = (String) rsHash.get("description");
        fldapproved = (String) rsHash.get("approved");
        fldadd_date = (String) rsHash.get("add_date");
      }
    }
    catch(java.sql.SQLException e){out.print("SQL :"+ sSQL+"<br>"+e);};

    
    oTpl.setVar ("linkInsert", "");
    oTpl.parse ("linkEdit", false);
  }
  else {
    oTpl.setVar ("linkEdit", "");
    oTpl.parse ("linkInsert", false);
  }
  oTpl.parse ("linkCancel", false);
  // Show form field
  oTpl.setVar ("link_id", toHTML(fldlink_id));oTpl.setVar ("name", toHTML(fldname));getOptions( conn, "select category_id, category_desc from links_categories order by 2",false,true,fldcategory_id,"LBcategory_id",oTpl);oTpl.setVar ("event_url", toHTML(fldevent_url));oTpl.setVar ("description", toHTML(flddescription));
  if ( fldapproved.equalsIgnoreCase("1") ) 
    oTpl.setVar ("approved_CHECKED", "CHECKED");
  else oTpl.setVar ("approved_CHECKED", "");
oTpl.setVar ("add_date", toHTML(fldadd_date));
  oTpl.parse ("Formlink", false);
  

}
%><%@ include file="LHeader.jsp" %>
             dfsdfdfdfdfdfdfdfdf
          </div></th>
    </tr>
  </table>
</div>
<jsp:include page="Addlogde.jsp"/>
<jsp:include page="Footer.jsp"/>

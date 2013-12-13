<%@ include file="YCommon.jsp" %><%!
//
//   Filename: AdminEntryRecord.jsp
//   Generated with CodeCharge  v.1.1.19
//   JSP.ccp build 04/20/2001
//

static final String sFileName = "YAdminEntryRecord.jsp";
              
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
String sEntryErr = "";

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
if ( sForm.equals("Entry") ) {
  sEntryErr = EntryAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sEntryErr)) return;
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
<% Entry_Show(request, response, session, out, sEntryErr, sForm, sAction, conn, stat); %>
    <SCRIPT Language="JavaScript">
if (document.forms["Entry"])
document.Entry.onsubmit=delconf;
function delconf() {
if (document.Entry.FormAction.value == 'delete')
  return confirm('Delete record?');
}
</SCRIPT>
   </td>
  </tr>
 </table>
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


  String EntryAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String sEntryErr ="";
    try {

      if (sAction.equals("")) return "";

      String sSQL="";
      String transitParams = "";
      String primaryKeyParams = "";
      String sQueryString = "";
      String sPage = "";
      String sParams = "";
      String sActionFileName = "YAdminEntriesGrid.jsp";
      String sWhere = " ";
      boolean bErr = false;
      long iCount = 0;

  
      String pPKitem_id = "";
      if (sAction.equalsIgnoreCase("cancel") ) {
        try {
          if ( stat != null ) stat.close();
          if ( conn != null ) conn.close();
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect (sActionFileName);
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
        pPKitem_id = getParam( request, "PK_item_id");
        if ( isEmpty(pPKitem_id)) return sEntryErr;
        sWhere = "item_id=" + toSQL(pPKitem_id, adNumber);
      }


      String fldname="";
      String fldcategory_id="";
      String fldcity="";
      String fldstate="";
      String fldzip="";
      String fldphone="";
      String fldaddress="";
      String fldemail="";
      String flditem_url="";
      String fldnotes="";
      String flditem_id="";

      // Load all form fields into variables
    
      fldname = getParam(request, "name");
      fldcategory_id = getParam(request, "category_id");
      fldcity = getParam(request, "city");
      fldstate = getParam(request, "state");
      fldzip = getParam(request, "zip");
      fldphone = getParam(request, "phone");
      fldaddress = getParam(request, "address");
      fldemail = getParam(request, "email");
      flditem_url = getParam(request, "item_url");
      fldnotes = getParam(request, "notes");
      // Validate fields
      if ( iAction == iinsertAction || iAction == iupdateAction ) {
        if ( isEmpty(fldname) ) {
          sEntryErr = sEntryErr + "The value in field Name is required.<br>";
        }
        if ( isEmpty(fldcategory_id) ) {
          sEntryErr = sEntryErr + "The value in field Category is required.<br>";
        }
        if ( ! isNumber(fldcategory_id)) {
          sEntryErr = sEntryErr + "The value in field Category is incorrect.<br>";
        }
        if (sEntryErr.length() > 0 ) {
          return (sEntryErr);
        }
      }


      sSQL = "";
      // Create SQL statement

      switch (iAction) {
  
        case iinsertAction :
          
            sSQL = "insert into items (" + 
                "name," +
                "category_id," +
                "city," +
                "state," +
                "zip," +
                "phone," +
                "address," +
                "email," +
                "url," +
                "notes)" +

                " values (" + 
                toSQL(fldname, adText) + "," +
                toSQL(fldcategory_id, adNumber) + "," +
                toSQL(fldcity, adText) + "," +
                toSQL(fldstate, adText) + "," +
                toSQL(fldzip, adText) + "," +
                toSQL(fldphone, adText) + "," +
                toSQL(fldaddress, adText) + "," +
                toSQL(fldemail, adText) + "," +
                toSQL(flditem_url, adText) + "," +
                toSQL(fldnotes, adText) + ")";
          break;
  
      case iupdateAction:
        
          sSQL = "update items set " +
                "name=" + toSQL(fldname, adText) +
                ",category_id=" + toSQL(fldcategory_id, adNumber) +
                ",city=" + toSQL(fldcity, adText) +
                ",state=" + toSQL(fldstate, adText) +
                ",zip=" + toSQL(fldzip, adText) +
                ",phone=" + toSQL(fldphone, adText) +
                ",address=" + toSQL(fldaddress, adText) +
                ",email=" + toSQL(fldemail, adText) +
                ",url=" + toSQL(flditem_url, adText) +
                ",notes=" + toSQL(fldnotes, adText);
          sSQL = sSQL + " where " + sWhere;
        break;
      
      case ideleteAction:
           sSQL = "delete from items where " + sWhere;
          
        break;
  
      }

      if ( sEntryErr.length() > 0 ) return sEntryErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
        
      }
      catch(java.sql.SQLException e) {
        sEntryErr = e.toString(); return (sEntryErr);
      }
  
      try {
        if ( stat != null ) stat.close();
        if ( conn != null ) conn.close();
      }
      catch ( java.sql.SQLException ignore ) {}
      response.sendRedirect (sActionFileName);

      return "sendRedirect";
    }
    catch (Exception e) {out.println(e.toString()); }
    return (sEntryErr);
  }

  


  void Entry_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sEntryErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
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
      
      String pitem_id = "";

      String flditem_id="";
      String fldname="";
      String fldcategory_id="";
      String fldcity="";
      String fldstate="";
      String fldzip="";
      String fldphone="";
      String fldaddress="";
      String fldemail="";
      String flditem_url="";
      String fldnotes="";


      boolean bPK = true;

      if ( "".equals(sEntryErr)) {
        // Load primary key and form parameters
        pitem_id = getParam( request, "item_id");
      }
      else {
        // Load primary key, form parameters and form fields
        flditem_id = getParam( request, "item_id");
        fldname = getParam( request, "name");
        fldcategory_id = getParam( request, "category_id");
        fldcity = getParam( request, "city");
        fldstate = getParam( request, "state");
        fldzip = getParam( request, "zip");
        fldphone = getParam( request, "phone");
        fldaddress = getParam( request, "address");
        fldemail = getParam( request, "email");
        flditem_url = getParam( request, "item_url");
        fldnotes = getParam( request, "notes");
        pitem_id = getParam( request, "PK_item_id");
      }

      
      if ( isEmpty(pitem_id)) { bPK = false; }
      
      sWhere += "item_id=" + toSQL(pitem_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_item_id\" value=\""+pitem_id+"\"/>";

      sSQL = "select * from items where " + sWhere;


      out.println("    <table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">");
      out.println("     <tr>\n      <td align=\"center\" bgcolor=\"#99CCFF\" colspan=\"2\"><font style=\"font-size: 12pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica; font-weight: bold\">Entry</font></td>\n     </tr>");
      if ( ! sEntryErr.equals("")) {
        out.println("     <tr>\n      <td bgcolor=\"#F5F5F5\" colspan=\"2\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">"+sEntryErr+"</font></td>\n     </tr>");
      }
      sEntryErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"Entry\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "Entry".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        flditem_id = (String) rsHash.get("item_id");
        if ( "".equals(sEntryErr)) {
          // Load data from recordset when form displayed first time
          fldname = (String) rsHash.get("name");
          fldcategory_id = (String) rsHash.get("category_id");
          fldcity = (String) rsHash.get("city");
          fldstate = (String) rsHash.get("state");
          fldzip = (String) rsHash.get("zip");
          fldphone = (String) rsHash.get("phone");
          fldaddress = (String) rsHash.get("address");
          fldemail = (String) rsHash.get("email");
          flditem_url = (String) rsHash.get("url");
          fldnotes = (String) rsHash.get("notes");
        }

        if (sAction.equals("") || ! "Entry".equals(sForm)) {
      
          flditem_id = (String) rsHash.get("item_id");
          fldname = (String) rsHash.get("name");
          fldcategory_id = (String) rsHash.get("category_id");
          fldcity = (String) rsHash.get("city");
          fldstate = (String) rsHash.get("state");
          fldzip = (String) rsHash.get("zip");
          fldphone = (String) rsHash.get("phone");
          fldaddress = (String) rsHash.get("address");
          fldemail = (String) rsHash.get("email");
          flditem_url = (String) rsHash.get("url");
          fldnotes = (String) rsHash.get("notes");
        }
        
      }
      else {
      }
      


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Name</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"100\" value=\""+toHTML(fldname)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Category</font></td><td bgcolor=\"#F5F5F5\">"); 
      out.print("<select name=\"category_id\">"+getOptions( conn, "select category_id, name from pages order by 2",false,true,fldcategory_id)+"</select>");
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">City</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"city\" maxlength=\"50\" value=\""+toHTML(fldcity)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">State</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"state\" maxlength=\"2\" value=\""+toHTML(fldstate)+"\" size=\"10\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">ZIP</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"zip\" maxlength=\"10\" value=\""+toHTML(fldzip)+"\" size=\"10\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Phone</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"phone\" maxlength=\"50\" value=\""+toHTML(fldphone)+"\" size=\"20\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Address</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"address\" maxlength=\"255\" value=\""+toHTML(fldaddress)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">E-mail</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"email\" maxlength=\"50\" value=\""+toHTML(fldemail)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">URL</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<input type=\"text\"  name=\"item_url\" maxlength=\"50\" value=\""+toHTML(flditem_url)+"\" size=\"50\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#FFFF99\"><font style=\"font-size: 10pt; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica\">Notes</font></td><td bgcolor=\"#F5F5F5\">"); out.print("<textarea name=\"notes\" cols=\"50\" rows=\"5\">"+toHTML(fldnotes)+"</textarea>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "Entry".equals(sForm))) {
        out.print("<input type=\"submit\" value=\"Update\" onclick=\"document.Entry.FormAction.value = 'update';\">");out.print("<input type=\"submit\" value=\"Delete\" onclick=\"document.Entry.FormAction.value = 'delete';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Entry.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Entry\"><input type=\"hidden\" value=\"update\" name=\"FormAction\">");
      }
      
      else {
        out.print("<input type=\"submit\" value=\"Insert\" onclick=\"document.Entry.FormAction.value = 'insert';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Entry.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Entry\"><input type=\"hidden\" value=\"insert\" name=\"FormAction\">");
      }out.print("<input type=\"hidden\" name=\"item_id\" value=\""+toHTML(flditem_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %><%
stat.close();
conn.close();
%>
<%@ include file="TCommon.jsp" %><%!
//
//   Filename: TaskRecord.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "TaskRecord.jsp";
              
static final String PageBODY = "bgcolor=\"#ffffff\"";
static final String FormTABLE = "bgcolor=\"#FFFFFF\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\"";
static final String FormHeaderTD = "bgcolor=\"#1262C4\" align=\"center\"";
static final String FormHeaderFONT = "face=\"tahoma\" style=\"font: bold\" size=\"2\" color=\"#ffffff\"";
static final String FieldCaptionTD = "bgcolor=\"#92BBEE\"";
static final String FieldCaptionFONT = "face=\"tahoma\" size=\"2\" color=\"#000000\"";
static final String DataTD = "bgcolor=\"#F2F8FF\"";
static final String DataFONT = "face=\"tahoma\" size=\"2\"";
static final String ColumnFONT = "face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\"";
static final String ColumnTD = "bgcolor=\"#92BBEE\"";
%><%

String cSec = checkSecurity(1, session, response, request);
if ("sendRedirect".equals(cSec) ) return;
                
boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sTasksErr = "";

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
if ( sForm.equals("Tasks") ) {
  sTasksErr = TasksAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sTasksErr)) return;
}

%>            
<html>
<head>
<title>Task Management</title>
<link rel="stylesheet" href="css.css" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body bgcolor="#ffffff">
<jsp:include page="Header.jsp" flush="true"/>
<div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">

<jsp:include page="THeader.jsp" flush="true"/>
 <table>
  <tr>
   
   <td valign="top">
<% Tasks_Show(request, response, session, out, sTasksErr, sForm, sAction, conn, stat); %>
    <SCRIPT Language="JavaScript">
if (document.forms["Tasks"])
document.Tasks.onsubmit=delconf;
function delconf() {
if (document.Tasks.FormAction.value == 'delete')
  return confirm('Delete record?');
}
</SCRIPT>
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
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!


  String TasksAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
  
    String sTasksErr ="";
    try {

      if (sAction.equals("")) return "";

      String sSQL="";
      String transitParams = "";
      String primaryKeyParams = "";
      String sQueryString = "";
      String sPage = "";
      String sParams = "";
      String sActionFileName = "TDefault.jsp";
      String sWhere = " ";
      boolean bErr = false;
      long iCount = 0;

  
      String pPKtask_id = "";
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
        pPKtask_id = getParam( request, "PK_task_id");
        if ( isEmpty(pPKtask_id)) return sTasksErr;
        sWhere = "task_id=" + toSQL(pPKtask_id, adNumber);
      }


      String fldUserID="";
      String fldtask_name="";
      String fldtask_desc="";
      String fldproject_id="";
      String fldpriority_id="";
      String fldassigned_to="";
      String flddate_assigned="";
      String fldstatus_id="";
      String flddate_resolved="";
      String fldresolution="";
      String fldtask_id="";
      String fldassigned_by="";

      // Load all form fields into variables
    
      fldUserID = (String) session.getAttribute("UserID");
      fldtask_name = getParam(request, "task_name");
      fldtask_desc = getParam(request, "task_desc");
      fldproject_id = getParam(request, "project_id");
      fldpriority_id = getParam(request, "priority_id");
      fldassigned_to = getParam(request, "assigned_to");
      flddate_assigned = getParam(request, "date_assigned");
      fldstatus_id = getParam(request, "status_id");
      flddate_resolved = getParam(request, "date_resolved");
      fldresolution = getParam(request, "resolution");
      // Validate fields
      if ( iAction == iinsertAction || iAction == iupdateAction ) {
        if ( isEmpty(fldtask_name) ) {
          sTasksErr = sTasksErr + "The value in field Task Name is required.<br>";
        }
        if ( isEmpty(fldproject_id) ) {
          sTasksErr = sTasksErr + "The value in field Client is required.<br>";
        }
        if ( isEmpty(fldpriority_id) ) {
          sTasksErr = sTasksErr + "The value in field Priority is required.<br>";
        }
        if ( isEmpty(fldassigned_to) ) {
          sTasksErr = sTasksErr + "The value in field Assigned To is required.<br>";
        }
        if ( isEmpty(fldstatus_id) ) {
          sTasksErr = sTasksErr + "The value in field Status is required.<br>";
        }
        if ( ! isNumber(fldproject_id)) {
          sTasksErr = sTasksErr + "The value in field Client is incorrect.<br>";
        }
        if ( ! isNumber(fldpriority_id)) {
          sTasksErr = sTasksErr + "The value in field Priority is incorrect.<br>";
        }
        if ( ! isNumber(fldassigned_to)) {
          sTasksErr = sTasksErr + "The value in field Assigned To is incorrect.<br>";
        }
        if ( ! isNumber(fldstatus_id)) {
          sTasksErr = sTasksErr + "The value in field Status is incorrect.<br>";
        }
        if (sTasksErr.length() > 0 ) {
          return (sTasksErr);
        }
      }


      sSQL = "";
      // Create SQL statement

      switch (iAction) {
  
        case iinsertAction :
          
            sSQL = "insert into tasks (" + 
                "assigned_by," + 
                "task_name," +
                "task_desc," +
                "project_id," +
                "priority_id," +
                "assigned_to," +
                "date_assigned," +
                "status_id," +
                "date_resolved," +
                "resolution)" +

                " values (" + 
                toSQL(fldUserID, adNumber) + "," +
                toSQL(fldtask_name, adText) + "," +
                toSQL(fldtask_desc, adText) + "," +
                toSQL(fldproject_id, adNumber) + "," +
                toSQL(fldpriority_id, adNumber) + "," +
                toSQL(fldassigned_to, adNumber) + "," +
                toSQL(flddate_assigned, adText) + "," +
                toSQL(fldstatus_id, adNumber) + "," +
                toSQL(flddate_resolved, adText) + "," +
                toSQL(fldresolution, adText) + ")";
          break;
  
      case iupdateAction:
        
          sSQL = "update tasks set " +
                "task_name=" + toSQL(fldtask_name, adText) +
                ",task_desc=" + toSQL(fldtask_desc, adText) +
                ",project_id=" + toSQL(fldproject_id, adNumber) +
                ",priority_id=" + toSQL(fldpriority_id, adNumber) +
                ",assigned_to=" + toSQL(fldassigned_to, adNumber) +
                ",date_assigned=" + toSQL(flddate_assigned, adText) +
                ",status_id=" + toSQL(fldstatus_id, adNumber) +
                ",date_resolved=" + toSQL(flddate_resolved, adText) +
                ",resolution=" + toSQL(fldresolution, adText);
          sSQL = sSQL + " where " + sWhere;
        break;
      
      case ideleteAction:
           sSQL = "delete from tasks where " + sWhere;
          
        break;
  
      }

      if ( sTasksErr.length() > 0 ) return sTasksErr;
      try {
        // Execute SQL statement
        stat.executeUpdate(sSQL);
      }
      catch(java.sql.SQLException e) {
        sTasksErr = e.toString(); return (sTasksErr);
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
    return (sTasksErr);
  }

  


  void Tasks_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sTasksErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
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
      
      String ptask_id = "";

      String fldassigned_by="";
      String fldtask_id="";
      String fldUserID="";
      String fldtask_name="";
      String fldtask_desc="";
      String fldproject_id="";
      String fldpriority_id="";
      String fldassigned_to="";
      String flddate_assigned="";
      String fldstatus_id="";
      String flddate_resolved="";
      String fldresolution="";


      boolean bPK = true;

      if ( "".equals(sTasksErr)) {
        // Load primary key and form parameters
        fldtask_id = getParam( request, "task_id");
        ptask_id = getParam( request, "task_id");
      }
      else {
        // Load primary key, form parameters and form fields
        fldtask_id = getParam( request, "task_id");
        fldtask_name = getParam( request, "task_name");
        fldtask_desc = getParam( request, "task_desc");
        fldproject_id = getParam( request, "project_id");
        fldpriority_id = getParam( request, "priority_id");
        fldassigned_to = getParam( request, "assigned_to");
        flddate_assigned = getParam( request, "date_assigned");
        fldstatus_id = getParam( request, "status_id");
        flddate_resolved = getParam( request, "date_resolved");
        fldresolution = getParam( request, "resolution");
        ptask_id = getParam( request, "PK_task_id");
        fldassigned_by = (String) session.getAttribute("UserID");
      }

      
      if ( isEmpty(ptask_id)) { bPK = false; }
      
      sWhere += "task_id=" + toSQL(ptask_id, adNumber);
      primaryKeyParams += "<input type=\"hidden\" name=\"PK_task_id\" value=\""+ptask_id+"\"/>";

      sSQL = "select * from tasks where " + sWhere;


      out.println("    <table bgcolor=\"#FFFFFF\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">");
      out.println("     <tr>\n      <td bgcolor=\"#1262C4\" align=\"center\" colspan=\"2\"><font face=\"tahoma\" style=\"font: bold\" size=\"2\" color=\"#ffffff\">Add/Edit Task</font></td>\n     </tr>");
      if ( ! sTasksErr.equals("")) {
        out.println("     <tr>\n      <td bgcolor=\"#F2F8FF\" colspan=\"2\"><font face=\"tahoma\" size=\"2\">"+sTasksErr+"</font></td>\n     </tr>");
      }
      sTasksErr="";
      out.println("     <form method=\"get\" action=\""+sFileName+"\" name=\"Tasks\">");

      java.sql.ResultSet rs = null;

      if ( bPK &&  ! (sAction.equals("insert") && "Tasks".equals(sForm))) {

        // Open recordset
        rs = openrs( stat, sSQL);
        rs.next();
        String[] aFields = getFieldsName( rs );
        getRecordToHash( rs, rsHash, aFields );
        rs.close();
        fldtask_id = (String) rsHash.get("task_id");
        fldassigned_by = (String) rsHash.get("assigned_by");
        if ( "".equals(sTasksErr)) {
          // Load data from recordset when form displayed first time
          fldtask_name = (String) rsHash.get("task_name");
          fldtask_desc = (String) rsHash.get("task_desc");
          fldproject_id = (String) rsHash.get("project_id");
          fldpriority_id = (String) rsHash.get("priority_id");
          fldassigned_to = (String) rsHash.get("assigned_to");
          flddate_assigned = (String) rsHash.get("date_assigned");
          fldstatus_id = (String) rsHash.get("status_id");
          flddate_resolved = (String) rsHash.get("date_resolved");
          fldresolution = (String) rsHash.get("resolution");
        }

        if (sAction.equals("") || ! "Tasks".equals(sForm)) {
      
          fldtask_id = (String) rsHash.get("task_id");
          fldtask_name = (String) rsHash.get("task_name");
          fldtask_desc = (String) rsHash.get("task_desc");
          fldproject_id = (String) rsHash.get("project_id");
          fldpriority_id = (String) rsHash.get("priority_id");
          fldassigned_by = (String) rsHash.get("assigned_by");
          fldassigned_to = (String) rsHash.get("assigned_to");
          flddate_assigned = (String) rsHash.get("date_assigned");
          fldstatus_id = (String) rsHash.get("status_id");
          flddate_resolved = (String) rsHash.get("date_resolved");
          fldresolution = (String) rsHash.get("resolution");
        }
        else {
          fldtask_id = (String) rsHash.get("task_id");
          fldassigned_by = (String) rsHash.get("assigned_by");
        }
        
      }
      else {
        if ( "".equals(sTasksErr)) {
          fldtask_id = toHTML(getParam(request,"task_id"));
          fldassigned_by = toHTML((String) session.getAttribute("UserID"));
          fldpriority_id= "3";
          fldstatus_id= "1";
        }
flddate_assigned= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
      }
      
      // Set lookup fields
          fldassigned_by = dLookUp( stat, "members", "name", "member_id=" + toSQL(fldassigned_by, adNumber));


      // Show form field
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Task Name</font></td><td bgcolor=\"#F2F8FF\">"); out.print("<input type=\"text\"  name=\"task_name\" maxlength=\"100\" value=\""+toHTML(fldtask_name)+"\" size=\"80\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Task Desc</font></td><td bgcolor=\"#F2F8FF\">"); out.print("<textarea name=\"task_desc\" cols=\"60\" rows=\"3\">"+toHTML(fldtask_desc)+"</textarea>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Client</font></td><td bgcolor=\"#F2F8FF\">"); 
      out.print("<select name=\"project_id\">"+getOptions( conn, "select project_id, project_name from projects order by 2",false,true,fldproject_id)+"</select>");
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Priority</font></td><td bgcolor=\"#F2F8FF\">"); 
      out.print("<select name=\"priority_id\">"+getOptions( conn, "select priority_id, priority_desc from priorities order by 2",false,true,fldpriority_id)+"</select>");
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Assigned By</font></td><td bgcolor=\"#F2F8FF\">"); out.print("<font face=\"tahoma\" size=\"2\">"+toHTML(fldassigned_by)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Assigned To</font></td><td bgcolor=\"#F2F8FF\">"); 
      out.print("<select name=\"assigned_to\">"+getOptions( conn, "select member_id, name from members order by 2",false,true,fldassigned_to)+"</select>");
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Date Assigned</font></td><td bgcolor=\"#F2F8FF\">"); out.print("<input type=\"text\"  name=\"date_assigned\" maxlength=\"25\" value=\""+toHTML(flddate_assigned)+"\" size=\"25\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Status</font></td><td bgcolor=\"#F2F8FF\">"); 
      out.print("<select name=\"status_id\">"+getOptions( conn, "select status_id, status from statuses order by 2",false,true,fldstatus_id)+"</select>");
      
      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Date Resolved</font></td><td bgcolor=\"#F2F8FF\">"); out.print("<input type=\"text\"  name=\"date_resolved\" maxlength=\"25\" value=\""+toHTML(flddate_resolved)+"\" size=\"25\">");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Resolution</font></td><td bgcolor=\"#F2F8FF\">"); out.print("<textarea name=\"resolution\" cols=\"60\" rows=\"3\">"+toHTML(fldresolution)+"</textarea>");

      out.println("</td>\n     </tr>");
      
      out.print("     <tr>\n      <td colspan=\"2\" align=\"right\">");
      

      if ( bPK && ! (sAction.equals("insert") && "Tasks".equals(sForm))) {
        out.print("<input type=\"submit\" value=\"Update\" onclick=\"document.Tasks.FormAction.value = 'update';\">");out.print("<input type=\"submit\" value=\"Delete\" onclick=\"document.Tasks.FormAction.value = 'delete';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Tasks.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Tasks\"><input type=\"hidden\" value=\"update\" name=\"FormAction\">");
      }
      
      else {
        out.print("<input type=\"submit\" value=\"Insert\" onclick=\"document.Tasks.FormAction.value = 'insert';\">");out.print("<input type=\"submit\" value=\"Cancel\" onclick=\"document.Tasks.FormAction.value = 'cancel';\">");
        out.print("<input type=\"hidden\" name=\"FormName\" value=\"Tasks\"><input type=\"hidden\" value=\"insert\" name=\"FormAction\">");
      }out.print("<input type=\"hidden\" name=\"task_id\" value=\""+toHTML(fldtask_id)+"\">");
      out.print(transitParamsHidden+requiredParams+primaryKeyParams);
      out.println("</td>\n     </tr>\n     </form>\n    </table>");
      



    }
    catch (Exception e) { out.println(e.toString()); }
  } %>
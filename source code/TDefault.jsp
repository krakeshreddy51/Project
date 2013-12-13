
<%@ include file="TCommon.jsp" %><%!
//
//   Filename: Default.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/01
//

static final String sFileName = "TDefault.jsp";
              
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

boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sSearchErr = "";
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
<div id="Layer1"><img src="imges/Reklama-Prezentaciju_noformesana.jpg" width="694" height="344" /></div>

 <div id="Layer23">
  <table width="693" border="0">
    <tr>
      <th width="683" scope="col"><div align="left">

<jsp:include page="THeader.jsp" flush="true"/>

<table>
  <tr>
   
   <td valign="top">
<% Search_Show(request, response, session, out, sSearchErr, sForm, sAction, conn, stat); %>
    
   </td>
  </tr>
 </table>
 <table>
  <tr>
   <td valign="top">
<% Tasks_Show(request, response, session, out, sTasksErr, sForm, sAction, conn, stat); %>
    
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

  void Search_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sSearchErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {
      

      String fldassigned_to="";
      String fldpriority_id="";
      String fldstatus_id="";


      String sSQL="";
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      

      out.println("    <table bgcolor=\"#FFFFFF\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">");
      out.println("     <tr>\n      <td bgcolor=\"#1262C4\" align=\"center\" colspan=\"7\"><a name=\"Search\"><font face=\"tahoma\" style=\"font: bold\" size=\"2\" color=\"#ffffff\">Search</font></a></td>\n     </tr>");
      out.println("     <form method=\"get\" action=\"TDefault.jsp\" name=\"Search\">\n     <tr>");
      // Set variables with search parameters
      
      fldassigned_to = getParam( request, "assigned_to");
      fldpriority_id = getParam( request, "priority_id");
      fldstatus_id = getParam( request, "status_id");

      // Show fields
      

      out.println("      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Assigned To</font></td>");
      out.print("      <td bgcolor=\"#F2F8FF\">"); 
      out.print("<select name=\"assigned_to\">"+getOptions( conn, "select member_id, name from members order by 2",true,false,fldassigned_to)+"</select>");
       out.println("</td>");
      
      out.println("      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Priority</font></td>");
      out.print("      <td bgcolor=\"#F2F8FF\">"); 
      out.print("<select name=\"priority_id\">"+getOptions( conn, "select priority_id, priority_desc from priorities order by 2",true,false,fldpriority_id)+"</select>");
       out.println("</td>");
      
      out.println("      <td bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\">Status</font></td>");
      out.print("      <td bgcolor=\"#F2F8FF\">"); 
      out.print("<select name=\"status_id\">"+getOptions( conn, "select status_id, status from statuses order by 2",true,false,fldstatus_id)+"</select>");
       out.println("</td>");
      
      out.println("      <td ><input type=\"submit\" value=\"Search\"/></td>");
      out.println("     </tr>\n     </form>\n    </table>");
      out.println("");
    }
    catch (Exception e) { out.println(e.toString()); }
  }


  void Tasks_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sTasksErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
    String sWhere = "";
    int iCounter=0;
    int iPage = 0;
    boolean bIsScroll = true;
    boolean hasParam = false;
    String sOrder = "";
    String sSQL="";
    String transitParams = "";
    String sQueryString = "";
    String sPage = "";
    int RecordsPerPage = 20;
    String sSortParams = "";
    String formParams = "";

      String passigned_to="";
      String ppriority_id="";
      String pproject_id="";
      String pstatus_id="";


    transitParams = "project_id=" + toURL(getParam( request, "project_id")) + "&assigned_to=" + toURL(getParam( request, "assigned_to")) + "&priority_id=" + toURL(getParam( request, "priority_id")) + "&status_id=" + toURL(getParam( request, "status_id")) + "&";
    formParams = "project_id=" + toURL(getParam( request, "project_id")) + "&assigned_to=" + toURL(getParam( request, "assigned_to")) + "&priority_id=" + toURL(getParam( request, "priority_id")) + "&status_id=" + toURL(getParam( request, "status_id")) + "&"; 
    // Build WHERE statement
        
    //-- Check assigned_to parameter and create a valid sql for where clause
  
    passigned_to = getParam( request, "assigned_to");
    if ( ! isNumber (passigned_to)) {
      passigned_to = "";
    }
    
    if (passigned_to != null && ! passigned_to.equals("")) {
            
        hasParam = true;
        sWhere += "t.assigned_to=" + passigned_to;
    }
    
    //-- Check priority_id parameter and create a valid sql for where clause
  
    ppriority_id = getParam( request, "priority_id");
    if ( ! isNumber (ppriority_id)) {
      ppriority_id = "";
    }
    
    if (ppriority_id != null && ! ppriority_id.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "t.priority_id=" + ppriority_id;
    }
    
    //-- Check project_id parameter and create a valid sql for where clause
  
    pproject_id = getParam( request, "project_id");
    if ( ! isNumber (pproject_id)) {
      pproject_id = "";
    }
    
    if (pproject_id != null && ! pproject_id.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "t.project_id=" + pproject_id;
    }
    
    //-- Check status_id parameter and create a valid sql for where clause
  
    pstatus_id = getParam( request, "status_id");
    if ( ! isNumber (pstatus_id)) {
      pstatus_id = "";
    }
    
    if (pstatus_id != null && ! pstatus_id.equals("")) {
            
      if (! sWhere.equals("")) sWhere += " and ";
        hasParam = true;
        sWhere += "t.status_id=" + pstatus_id;
    }
    
    if (hasParam) { sWhere = " AND (" + sWhere + ")"; }
    // Build ORDER statement
    String sSort = getParam( request, "FormTasks_Sorting");
    String sSorted = getParam( request, "FormTasks_Sorted");
    String sDirection = "";
    String sForm_Sorting = "";
    int iSort = 0;
    try {
      iSort = Integer.parseInt(sSort);
    }
    catch (NumberFormatException e ) {
      sSort = "";
    }
    if ( iSort == 0 ) {
      sForm_Sorting = "";
    }
    else {
      if ( sSort.equals(sSorted)) { 
        sSorted="0";
        sForm_Sorting = "";
        sDirection = " DESC";
        sSortParams = "FormTasks_Sorting=" + sSort + "&FormTasks_Sorted=" + sSort + "&";
      }
      else {
        sSorted=sSort;
        sForm_Sorting = sSort;
        sDirection = " ASC";
        sSortParams = "FormTasks_Sorting=" + sSort + "&FormTasks_Sorted=" + "&";
      }
    
      if ( iSort == 1) { sOrder = " order by t.task_name" + sDirection; }
      if ( iSort == 2) { sOrder = " order by p.project_name" + sDirection; }
      if ( iSort == 3) { sOrder = " order by t.priority_id" + sDirection; }
      if ( iSort == 4) { sOrder = " order by e.employee_name" + sDirection; }
      if ( iSort == 5) { sOrder = " order by s.status" + sDirection; }
    }
  

  // Build full SQL statement
  
  sSQL = "select t.assigned_to as t_assigned_to, " +
    "t.priority_id as t_priority_id, " +
    "t.project_id as t_project_id, " +
    "t.status_id as t_status_id, " +
    "t.task_id as t_task_id, " +
    "t.task_name as t_task_name, " +
    "p.project_id as p_project_id, " +
    "p.project_name as p_project_name, " +
    "e.member_id as e_employee_id, " +
    "e.name as e_employee_name, " +
    "s.status_id as s_status_id, " +
    "s.status as s_status " +
    " from tasks t, projects p, members e, statuses s" +
    " where p.project_id=t.project_id and e.member_id=t.assigned_to and s.status_id=t.status_id  ";
  System.out.println(sSQL);
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"5\" bgcolor=\"#F2F8FF\"><font face=\"tahoma\" size=\"2\">No records</font></td>\n     </tr>";


  String tableHeader = "";
      tableHeader = "     <tr>\n      <td bgcolor=\"#92BBEE\"><a href=\""+sFileName+"?"+formParams+"FormTasks_Sorting=1&FormTasks_Sorted="+sSorted+"&\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Task</font></a></td>\n      <td bgcolor=\"#92BBEE\"><a href=\""+sFileName+"?"+formParams+"FormTasks_Sorting=2&FormTasks_Sorted="+sSorted+"&\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Client</font></a></td>\n      <td bgcolor=\"#92BBEE\"><a href=\""+sFileName+"?"+formParams+"FormTasks_Sorting=3&FormTasks_Sorted="+sSorted+"&\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Priority</font></a></td>\n      <td bgcolor=\"#92BBEE\"><a href=\""+sFileName+"?"+formParams+"FormTasks_Sorting=4&FormTasks_Sorted="+sSorted+"&\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Assigned To</font></a></td>\n      <td bgcolor=\"#92BBEE\"><a href=\""+sFileName+"?"+formParams+"FormTasks_Sorting=5&FormTasks_Sorted="+sSorted+"&\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Status</font></a></td>\n     </tr>";
  
  
  try {
    out.println("    <table bgcolor=\"#FFFFFF\" border=\"0\" cellspacing=\"1\" cellpadding=\"1\">");
    out.println("     <tr>\n      <td bgcolor=\"#1262C4\" align=\"center\" colspan=\"5\"><a name=\"Tasks\"><font face=\"tahoma\" style=\"font: bold\" size=\"2\" color=\"#ffffff\">Tasks</font></a></td>\n     </tr>");
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    // Select current page
    iPage = Integer.parseInt(getParam( request, "FormTasks_Page"));
  }
  catch (NumberFormatException e ) {
    iPage = 0;
  }

  if (iPage == 0) { iPage = 1; }
  RecordsPerPage = 20;
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, sSQL);
    iCounter = 0;
    absolute (rs, (iPage-1)*RecordsPerPage+1);
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( (iCounter < RecordsPerPage) && rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String fldassigned_to = (String) rsHash.get("e_employee_name");
      String fldpriority_id = (String) rsHash.get("t_priority_id");
      String fldproject_id = (String) rsHash.get("p_project_name");
      String fldstatus_id = (String) rsHash.get("s_status");
      String fldtask_id = (String) rsHash.get("t_task_id");
      String fldtask_name = (String) rsHash.get("t_task_name");
fldpriority_id="<img border=0 src=images/prior" + fldpriority_id + ".gif>";

      out.println("     <tr>");
      
      out.print("      <td bgcolor=\"#F2F8FF\">"); out.print("<a href=\"TaskRecord.jsp?"+transitParams+"task_id="+toURL((String) rsHash.get("t_task_id"))+"&\"><font face=\"tahoma\" size=\"2\">"+toHTML(fldtask_name)+"</font></a>");

      out.println("</td>");
      out.print("      <td bgcolor=\"#F2F8FF\">"); out.print("<font face=\"tahoma\" size=\"2\">"+toHTML(fldproject_id)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#F2F8FF\">"); out.print("<font face=\"tahoma\" size=\"2\">"+fldpriority_id+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#F2F8FF\">"); out.print("<font face=\"tahoma\" size=\"2\">"+toHTML(fldassigned_to)+"&nbsp;</font>");
      out.println("</td>");
      out.print("      <td bgcolor=\"#F2F8FF\">"); out.print("<font face=\"tahoma\" size=\"2\">"+toHTML(fldstatus_id)+"&nbsp;</font>");
      out.println("</td>");
      out.println("     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      out.print("     <tr>\n      <td colspan=\"5\" bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">");
      out.print("<a href=\"TaskRecord.jsp?"+formParams+"\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Add New Task</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.println("</td>\n     </tr>");
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    else {

  
    // Parse scroller
    boolean bInsert = false;
    boolean bNext = rs.next();
    if ( !bNext && iPage == 1 ) {
    
      out.print("     <tr>\n      <td colspan=\"5\" bgcolor=\"#92BBEE\">\n       <font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">");
      out.print("\n        <a href=\"TaskRecord.jsp?"+formParams+"\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Add New Task</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      out.println("\n      </td>\n     </tr>");
    
    }
    else {
      out.print("     <tr>\n      <td colspan=\"5\" bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">");
    
      out.print("\n       <a href=\"TaskRecord.jsp?"+formParams+"\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Add New Task</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      bInsert = true;
    
      if ( iPage == 1 ) {
        out.print("\n       <a href_=\"#\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Previous</font></a>");
      }
      else {
        out.print("\n       <a href=\""+sFileName+"?"+formParams+sSortParams+"FormTasks_Page="+(iPage - 1)+"#Form\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Previous</font></a>");
      }
  
      out.print("\n       [ "+iPage+" ]");
  
      if (!bNext) { 
        out.print("\n       <a href_=\"#\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Next</font></a><br>");
      }
      else {
        out.print("\n       <a href=\""+sFileName+"?"+formParams+sSortParams+"FormTasks_Page="+(iPage + 1)+"#Form\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Next</font></a><br>");
      }
    
      if ( ! bInsert ) {
        out.print("     <tr>\n      <td colspan=\"5\" bgcolor=\"#92BBEE\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">");
        out.print("\n        <a href=\"TaskRecord.jsp?"+formParams+"\"><font face=\"tahoma\" size=\"2\" color=\"#000000\" style=\"font: bold\">Add New Task</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
      }
    
      out.println("</td>\n     </tr>");
    }
  
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}
%>
<%--
    Document   : Default
    Created on : Jan 3, 2004, 4:41:58 AM
    Author     : daata
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="Common.jsp" %>
<link rel="stylesheet" href="css.css" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%!
//
//
//

static final String sFileName = "Default.jsp";

static final String PageBODY = "bgcolor=\"#FFFFFF\"";
static final String FormTABLE = "";
static final String FormHeaderTD = "bgcolor=\"#808080\" align=\"center\"";
static final String FormHeaderFONT = "face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\"";
static final String FieldCaptionTD = "bgcolor=\"#CCCCCC\"";
static final String FieldCaptionFONT = "face=\"arial\" size=\"2\" style=\"font:bold\"";
static final String DataTD = "bgcolor=\"#EEEEEE\"";
static final String DataFONT = "face=\"arial\" size=\"2\"";
static final String ColumnFONT = "face=\"arial\" size=\"2\" style=\"font:bold\"";
static final String ColumnTD = "bgcolor=\"#CCCCCC\"";
%><%

boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sTreeErr = "";
String sSearchErr = "";
String sLoginErr = "";
String sMenuErr = "";

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
if ( sForm.equals("Tree") ) {
  sTreeErr = TreeAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sTreeErr)) return;
}
if ( sForm.equals("Login") ) {
  sLoginErr = LoginAction(request, response, session, out, sAction, sForm, conn, stat);
  if ( "sendRedirect".equals(sLoginErr)) return;
}

%>


       
       <div id="Layer21">
       <% Search_Show(request, response, session, out, sSearchErr, sForm, sAction, conn, stat); %>

           <% Menu_Show(request, response, session, out, sMenuErr, sForm, sAction, conn, stat); %>
       </div>
           <div id="Layer3"><% Tree_Show(request, response, session, out, sTreeErr, sForm, sAction, conn, stat); %>
       </div>

       <div id="Layer15">
        <% Login_Show(request, response, session, out, sLoginErr, sForm, sAction, conn, stat); %>
       </div>
    




<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>
<%!

  String sActionFileName = "Default.jsp";


  String TreeAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {

      String sCatId = getParam( request, "category_id");
      String sOp = "=";
      if ( isEmpty(sCatId) || ! isNumber(sCatId) ) {
        sCatId = "null";
        sOp = " is ";
      }
      long lNRec = dCountRec( stat, "categories", "par_category_id"+ sOp + sCatId);
      if ( lNRec == 0 ) {
        try {
          if ( stat != null ) stat.close();
          if ( conn != null ) conn.close();
        }
        catch ( java.sql.SQLException ignore ) {}
        response.sendRedirect("AdsGrid.jsp?category_id=" + sCatId);
        return "sendRedirect";

      }
    }
    catch (Exception e) { out.println(e.toString()); };
    return ("");
  }

  void Tree_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sTreeErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {

      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      String sSQL = "select category_id, name, par_category_id from categories";
      String sCatID = getParam( request, "category_id");
      String sWhere = "";
      java.sql.ResultSet rs = null;
      String sCatPath = "";
      String sCatList = "";
      String sParCatID = "";
      String sCatName  = "";
      String sPath = "";
      String stCatID    = "";
      String stParCatID = "";
      String stCatName  = "";

      out.println("    <table >");

      out.println("     <tr>\n      <td ><nobr><font face=\"arial\" size=\"2\" style=\"font:bold\"><a href=\""+sActionFileName+"?FormName=Tree\"><font color=\"#FFFFFF\"face=\"arial\" size=\"3\" style=\"font:bold\">Top</font></a>");


      if (sCatID == null || sCatID.compareTo("") == 0 || ! isNumber(sCatID)) {
        // Root category
        sWhere = " where par_category_id is Null";
      }
      else {

        // Subcategory
        sWhere = " where category_id=" + sCatID;
        rs = openrs ( stat, sSQL + sWhere);
        if ( rs.next()) {
          java.util.Hashtable rsHash = new java.util.Hashtable();
          String[] aFields = getFieldsName( rs );
          getRecordToHash( rs, rsHash, aFields );

          sCatPath = "";
          sCatList = "";
          sParCatID = toHTML((String) rsHash.get("par_category_id"));
          sCatName  = toHTML((String) rsHash.get("name"));
        }
        rs.close();
        sPath = " > "+sCatName+"</font></nobr></td>\n     </tr>";


        // Build Path
        stParCatID = sParCatID;
        while ( stParCatID.compareTo("") != 0 ) {
          rs = openrs ( stat, sSQL + " where category_id=" + stParCatID);
          java.util.Hashtable rsHash = new java.util.Hashtable();
          String[] aFields = getFieldsName( rs );
          if ( rs.next() ) {
            getRecordToHash( rs, rsHash, aFields );
            stCatID    = toHTML((String) rsHash.get("category_id"));
            stParCatID = toHTML((String) rsHash.get("par_category_id"));
            stCatName  = toHTML((String) rsHash.get("name"));
            sPath = "> <a href=\""+sActionFileName+"?FormName=Tree&category_id="+stCatID+"\"><font face=\"arial\" size=\"2\" style=\"font:bold\">"+stCatName+"</font></a>" + sPath;
          }
          rs.close();
        }
        out.println(sPath);
        sWhere = " where par_category_id=" + sCatID;
      }


      // Categories list
      rs = openrs ( stat, sSQL + sWhere);
      if (rs != null) {
        java.util.Hashtable rsHash = new java.util.Hashtable();
        String[] aFields = getFieldsName( rs );
        while ( rs.next() ) {
          // Print subcategories
          getRecordToHash( rs, rsHash, aFields );
          stCatID    = toHTML((String) rsHash.get("category_id"));
          stParCatID = toHTML((String) rsHash.get("par_category_id"));
          stCatName  = toHTML((String) rsHash.get("name"));

          out.println("    <tr>\n     <td ><a href=\""+sActionFileName+"?FormName=Tree&category_id="+stCatID+"\"><font color=\"#FFFFFF\"face=\"arial\" size=\"3\"><B>"+stCatName+"<B></font></a></td>\n     </tr>");
        }
      }
      rs.close();

      out.println("    </table>");
    }
    catch (Exception e) { out.println(e.toString()); };
  }



  void Search_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sSearchErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {


      String fldname="";


      String sSQL="";
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";


      out.println("    <table >");
      out.println("     <tr>\n      <td align=\"center\" colspan=\"3\"><a name=\"Search\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Search</font></a></td>\n     </tr>");
      out.println("     <form method=\"get\" action=\"AdsGrid.jsp\" name=\"Search\">\n     <tr>");
      // Set variables with search parameters

      fldname = getParam( request, "name");

      // Show fields


      out.println("      <td ><font  face=\"arial\" size=\"2\" style=\"font:bold\">Name</font></td>");
      out.print("      <td >"); out.print("<input type=\"text\"  name=\"name\" maxlength=\"20\" value=\""+toHTML(fldname)+"\" size=\"20\">");
 out.println("</td>");

      out.println("      <td ><input type=\"submit\" value=\"Search\"/></td>");
      out.println("     </tr>\n     </form>\n    </table>");
      out.println("");
    }
    catch (Exception e) { out.println(e.toString()); }
  }


  String LoginAction(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sAction, String sForm, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    String sLoginErr = "";
    try {
      final int iloginAction = 1;
      final int ilogoutAction = 2;
      String transitParams = "";
      String sQueryString = "";
      String sPage = "";
      String sSQL="";
      int iAction = 0;

      if ( sAction.equals("login") )  iAction = iloginAction;
      if ( sAction.equals("logout") ) iAction = ilogoutAction;

      switch (iAction) {
        case iloginAction: {
          // Login action

          String sLogin = getParam( request, "Login");
          String sPassword = getParam( request, "Password");
          java.sql.ResultSet rs = null;
          rs = openrs( stat, "select member_id, member_level from members where member_login =" + toSQL(sLogin, adText) + " and member_password=" + toSQL(sPassword, adText));

          if ( rs.next() ) {
            // Login and password passed
            session.setAttribute("UserID", rs.getString(1));

            session.setAttribute("UserRights", rs.getString(2));
            sQueryString = getParam( request, "querystring");
            sPage = getParam( request, "ret_page");
            if ( ! sPage.equals(request.getRequestURI() ) && ! "".equals(sPage)) {
              try {
                if ( stat != null ) stat.close();
                if ( conn != null ) conn.close();
              }
              catch ( java.sql.SQLException ignore ) {}
              response.sendRedirect(sPage + "?" + sQueryString);
              return "sendRedirect";
            }

          }
          else sLoginErr = "Login or Password is incorrect.";
          rs.close();

          break;
        }
        case ilogoutAction: {
          // Logout action

          session.setAttribute("UserID", "");
          session.setAttribute("UserRights", "");

          break;
        }
      }
    }
    catch (Exception e) { out.println(e.toString()); }
    return (sLoginErr);
  }

  void Login_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sLoginErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {


      String sSQL="";
      String transitParams = "";
      String sQueryString = getParam( request, "querystring");
      String sPage = getParam( request, "ret_page");

      out.println("    <table  border=0>");
      out.println("     <tr>\n      <td  align=\"center\" colspan=\"2\"><font face=\"arial\" color=\"#FFFFFF\" style=\"font:bold\">Login</font></td>\n     </tr>");

      if ( sLoginErr.compareTo("") != 0 ) {
        out.println("     <tr>\n      <td colspan=\"2\" ><font face=\"arial\" size=\"2\">"+sLoginErr+"</font></td>\n     </tr>");
      }
      sLoginErr="";
      out.println("     <form action=\""+sFileName+"\" method=\"POST\">");
      out.println("     <input type=\"hidden\" name=\"FormName\" value=\"Login\">");
      if ( session.getAttribute("UserID") == null || ((String) session.getAttribute("UserID")).compareTo("") == 0 ) {
        // User did not login
        out.println("     <tr>\n      <td ><font face=\"arial\" size=\"2\" style=\"font:bold\">Login</font></td><td ><input type=\"text\" name=\"Login\" maxlength=\"50\" value=\""+toHTML(getParam( request, "Login"))+"\"></td>\n     </tr>");
        out.println("     <tr>\n      <td ><font face=\"arial\" size=\"2\" style=\"font:bold\">Password</font></td><td ><input type=\"password\" name=\"Password\" maxlength=\"50\"></td>\n     </tr>");
        out.print("     <tr>\n      <td colspan=\"2\"><input type=\"hidden\" name=\"FormAction\" value=\"login\"><input type=\"submit\" value=\"Login\">");
        out.println("<input type=\"hidden\" name=\"ret_page\" value=\""+sPage+"\"><input type=\"hidden\" name=\"querystring\" value=\""+sQueryString+"\"></td>\n     </form>\n     </tr>");
      }
      else {
        // User logged in
        String sUserID = dLookUp( stat, "members", "member_login", "member_id =" + session.getAttribute("UserID"));
        out.print("     <tr><td ><font face=\"arial\" size=\"2\">"+sUserID+"&nbsp;&nbsp;"+"</font><input type=\"hidden\" name=\"FormAction\" value=\"logout\"/><input type=\"submit\" value=\"Logout\"/>");
        out.print("<input type=\"hidden\" name=\"ret_page\" value=\""+sPage+"\"><input type=\"hidden\" name=\"querystring\" value=\""+sQueryString+"\">");
        out.println("</td>\n     </form>\n     </tr>");
      }
      out.println("    </table>");


    }
    catch (Exception e) { out.println(e.toString()); }
  }


  void Menu_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sMenuErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
    try {

      out.println("    <table >");

      out.print("     <tr>");
      // Set URLs

      String fldField1 = "AdvSearch.jsp";
      // Show fields

      out.print("\n      <td ><a href=\""+fldField1+"\"><font face=\"arial\" size=\"2\"><b>Advanced Search</b></font></a></td>");

      out.println("\n     </tr>\n    </table>");

    }
    catch (Exception e) { out.println(e.toString()); }
  }
%>
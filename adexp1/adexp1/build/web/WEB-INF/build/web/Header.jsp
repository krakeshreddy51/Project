<%-- 
    Document   : index
    Created on : Jan 3, 2004, 4:19:30 AM
    Author     : daata
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="Common.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="css.css" />
<%!//
//   Filename: Header.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSP.ccp build 05/21/2001
//
    static final String sFileName = "Header.jsp";
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

            String sAction = getParam(request, "FormAction");
            String sForm = getParam(request, "FormName");
            String sHeaderErr = "";

            java.sql.Connection conn = null;
            java.sql.Statement stat = null;
            conn = cn();
            stat = conn.createStatement();
%>

<% Header_Show(request, response, session, out, sHeaderErr, sForm, sAction, conn, stat);%>
<div id="Layer18"><a href="#" target="#"><img src="imges/ind.JPG" alt="adexpress logo" width="260" height="84" border="0" longdesc="#" /></a></div>
        <%!    void Header_Show(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sHeaderErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException {
        try {%>

<div id="table">
    <table width="762" height="32" border="0">
        <tr>
            <th width="76" height="26" scope="col"><a href="./Default.jsp"  class="style1">Home</a></th>
            <th width="108" scope="col"><a href="./Registration.jsp" class="style1">Registration</a></th>
            <th width="113" scope="col"><a href="MyClassifieds.jsp"  class="style1">My Classifieds</a> </th>
            <th width="75" scope="col"><a href="./MyAdSelCat.jsp" class="style1">New Ad</a> </th>
            <th width="109" scope="col"><a href="./AdminMenu.jsp" class="style1">Administration</a></th>
            <th width="101" scope="col"><a href="./YDefault.jsp" class="style1">Yellow Pages</a> </th>
            <th width="58" scope="col"><a href="./LDefault.jsp" class="style1">Links</a></th>
            <th width="70" scope="col"><a href="TDefault.jsp"class="style1">Tasks</a></th>
        </tr>
    </table>
</div>

<%! } catch (Exception e) {
            out.println(e.toString());
        }
    }
%>
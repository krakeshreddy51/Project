<link rel="stylesheet" href="css.css"/>


     
<%!
void Menu_Show( javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat, TextTemplate oTpl) throws java.io.IOException {
  
  // Set URLs
  
  String fldField1 = "LDefault.jsp";
  String fldField2 = "LLinkNew.jsp";
  String fldField3 = "LAdminMenu.jsp";
  // Show fields

  oTpl.setVar ("Field1", fldField1);
  
  oTpl.setVar ("Field2", fldField2);
  
  oTpl.setVar ("Field3", fldField3);
  
  oTpl.parse ("FormMenu", false);
  
}
%>


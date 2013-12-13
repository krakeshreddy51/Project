<%@ include file="LStyles.inc" %>


<%!


//
//   Filename: Common.jsp
//   Generated with CodeCharge  v.1.2.0
//   JSPTemplates build 05/21/2001
//

  static final String CRLF = "\r\n";

  static final int RECORDS_PER_PAGE = 20;

  static final int UNDEFINT=Integer.MIN_VALUE;
  static final int Text_TYPE = 1;
  static final int Date_TYPE = 2;
  static final int Number_TYPE = 3; 
  static final int _Search__TYPE = 4;
  static final int Search_TYPE = 5;
  static final int adText = Text_TYPE ;
  static final int adNumber = Number_TYPE ;


//Database connection string

  static final String DBDriver  ="com.mysql.jdbc.Driver";
  static final String strConn   ="jdbc:mysql://localhost:3306/adxpress";
  static final String DBmembername="root";
  static final String DBpassword="root";

  public void addSessionError(String errName, String errText, javax.servlet.http.HttpSession session){
    String oldErr = (String) session.getAttribute(errName);
    oldErr += errText;
    session.putValue(errName, oldErr);
  }

  public static String loadDriver () {
    String sErr = "";
    try {
      java.sql.DriverManager.registerDriver((java.sql.Driver)(Class.forName(DBDriver).newInstance()));
    }
    catch (Exception e) {
      sErr = e.toString();
    }
    return (sErr);
  }

  public static void absolute(java.sql.ResultSet rs, int row) throws java.sql.SQLException{
    for(int x=1;x<row;x++) rs.next();
  }

  java.sql.ResultSet openrs(java.sql.Statement stat, String sql) throws java.sql.SQLException {
    java.sql.ResultSet rs = stat.executeQuery(sql);
    return (rs);
  }

  String toURL(String strValue){
    if ( strValue == null ) return "";
    if ( strValue.compareTo("") == 0 ) return "";
    return java.net.URLEncoder.encode(strValue);
  }

  String[] getFieldsName ( java.sql.ResultSet rs ) throws java.sql.SQLException {
    java.sql.ResultSetMetaData metaData = rs.getMetaData();
    int count = metaData.getColumnCount();
    String[] aFields = new String[count];
    for(int j = 0; j < count; j++) {
      aFields[j] = metaData.getColumnLabel(j+1);
    }
    return aFields;
  }

  java.util.Hashtable getRecordToHash ( java.sql.ResultSet rs, java.util.Hashtable rsHash, String[] aFields ) throws java.sql.SQLException {
    for ( int iF = 0; iF < aFields.length; iF++ ) {
      rsHash.put( aFields[iF], getValue(rs, aFields[iF]));
    }
    return rsHash;
  }

  long dCountRec(java.sql.Statement stat, String table, String sWhere) {
    long lNumRecs = 0;
    try {
      java.sql.ResultSet rs = stat.executeQuery("select count(*) from " + table + " where " + sWhere);
      if ( rs != null && rs.next() ) {
        lNumRecs = rs.getLong(1);
      }
      rs.close();
    }
    catch (Exception e ) {};
    return lNumRecs;
  }

  String getCheckBoxValue(String sVal, String CheckedValue, String UnCheckedValue, int sType) {
    if (isEmpty(sVal)) {
      return toSQL(UnCheckedValue, sType);
    }
    else {
      return toSQL(CheckedValue, sType);
    }
  }

  String dLookUp(java.sql.Statement stat, String table, String fName, String where) {
    try{
System.out.println("dLookup="+stat+ "SELECT " + fName + " FROM " + table + " WHERE " + where);
      java.sql.ResultSet rs = openrs(stat, "SELECT " + fName + " FROM " + table + " WHERE " + where);
      if (! rs.next()) {
        rs.close();
        return "";
      }
      String res = rs.getString(1);
      rs.close();
      return (res == null ? "" : res);
    }
    catch (Exception e) {
      return "";
    }
  }

  String proceedError(javax.servlet.http.HttpServletResponse response, Exception e) {
    return e.toString();
  }


  String CheckSecurity(javax.servlet.http.HttpSession session, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpServletRequest request, String scriptName) {
    try{
      if (session.getAttribute("UserID")==null) {
        response.sendRedirect("Login.jsp?querystring=" + toURL(request.getQueryString()) + "&ret_page=" + scriptName);
        return "sendRedirect";
      }
    }
    catch(Exception e){};
    return "";
  }

  String CheckSecurity(int iLevel, javax.servlet.http.HttpSession session, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpServletRequest request, String scriptName){
    try {
      Object o1 = session.getAttribute("UserID");
      Object o2 = session.getAttribute("UserRights");
      boolean bRedirect = false;
      if ( o1 == null || o2 == null ) { bRedirect = true; }
      if ( ! bRedirect ) {
        if ( (o1.toString()).equals("")) { bRedirect = true; }
        else if ( (new Integer(o2.toString())).intValue() < iLevel) { bRedirect = true; }
      }

      if ( bRedirect ) {
        response.sendRedirect("Login.jsp?querystring=" + toURL(request.getQueryString()) + "&ret_page=" + toURL(request.getRequestURI()));
        return "sendRedirect";
      }
    }
    catch(Exception e){};
    return "";
  }



  java.sql.Connection cn() throws java.sql.SQLException {
    return java.sql.DriverManager.getConnection(strConn , DBmembername, DBpassword);
  }

  String toHTML(String value) {
    if ( value == null ) return "";
    value = replace(value, "&", "&amp;");
    value = replace(value, "<", "&lt;");
    value = replace(value, ">", "&gt;");
    value = replace(value, "\"", "&" + "quot;");
    return value;
  }

  String getValueHTML(java.sql.ResultSet rs, String fieldName){
    return  toHTML(getValue(rs, fieldName));
  }

  String getValue(java.sql.ResultSet rs, String fieldName) {
   if ((rs==null) ||(isEmpty(fieldName)) || ("".equals(fieldName))) return "";
     try {
       String value = rs.getString(fieldName);
       if (value != null) {
         return (value);
       }
     }
     catch (java.sql.SQLException sqle) {}
     return "";
  }

  String getParam(javax.servlet.http.HttpServletRequest req, String paramName, int paramType) {
    String param = req.getParameter(paramName);
    switch (paramType){
      case Number_TYPE: return (isNumber(param)?param:String.valueOf(UNDEFINT)); 
      case Text_TYPE:
      case _Search__TYPE:
      case Search_TYPE:  return (param == null ? "" : param);
    }
    return "";
  }

  String getParam(javax.servlet.http.HttpServletRequest req, String paramName) {
    String param = req.getParameter(paramName);
    if (param==null) return "";
    else return param;
  }

  boolean isNumber (String param) {
    boolean result;
    if ( param == null || param.equals("")) return true;
    param=param.replace('d','_').replace('f','_');
    try {
      Double dbl = new Double(param);
      result = true;
    }
    catch (NumberFormatException nfe) {
      result = false;
    }
    return result;
  }

  boolean isEmpty (int val){
    return val==UNDEFINT;
  }

  boolean isEmpty (String val){
    return (val==null || val.equals("")||val.equals(Integer.toString(UNDEFINT))); 
  }

  String toWhereSQL(String fieldName, String fieldVal, int type) {
    String res = "";
    switch(type) {
      case Text_TYPE: 
        if (! "".equals(fieldVal)) {
              res = " " + fieldName + " like '%" + fieldVal + "%'";
            }
      case Number_TYPE:
        res = " " + fieldName + " = " + fieldVal + " ";
      case Date_TYPE:
        res = " " + fieldName + " = '" + fieldVal + "' ";
      default:
        res = " " + fieldName + " = '" + fieldVal + "' ";
    }
    return res;
  }

  String toSQL(String value, int type) {
    if ( value == null ) return "Null";
    String param = value;
    if ("".equals(param) && (type == Text_TYPE || type == Date_TYPE) ) {
      return "Null";
    } 
    switch (type) {
      case Text_TYPE: {
        param = replace(param, "'", "''");
        param = replace(param, "&amp;", "&");
        param = "'" + param + "'";
        break;
      }
      case _Search__TYPE:
      case Search_TYPE: {
        param = replace(param, "'", "''");
        break;
      }
      case Number_TYPE: {
        try {
          if (! isNumber(value) || "".equals(param)) param="null";
          else param = value;
        }
        catch (NumberFormatException nfe) {
          param = "null";
        }
        break;
      }
      case Date_TYPE: {
        param = "'" + param + "'";
        break;      
      }
    }
    return param;
  }

  private String replace(String str, String pattern, String replace) {
    if (replace == null) {
      replace = "";
    }
    int s = 0, e = 0;
    StringBuffer result = new StringBuffer();
    while ((e = str.indexOf(pattern, s)) >= 0) {
      result.append(str.substring(s, e));
      result.append(replace);
      s = e + pattern.length();
    }
    result.append(str.substring(s));
    return result.toString();
  }

  private String getFileContent(String fName) throws java.io.FileNotFoundException, java.io.IOException {
    java.io.BufferedReader bf = new java.io.BufferedReader(new java.io.FileReader(fName));
    String line="";
    while (bf.ready()) {    
        line += bf.readLine() +"\n";
    }
    bf.close();
    return line;
  }

  void getOptions( java.sql.Connection conn, String sql, boolean isSearch, boolean isRequired, String selectedValue, String nameBlock, TextTemplate oTpl ) {
    oTpl.setVar ( nameBlock, "");
    if ( isSearch ) {
      oTpl.setVar ("ID", "");
      oTpl.setVar ("Value", "All");
      oTpl.parse ( nameBlock, true);
    }
    else {
      if ( ! isRequired ) {
        oTpl.setVar ("ID", "");
        oTpl.setVar ("Value", "");
        oTpl.parse ( nameBlock, true);
      }
    }
    java.sql.ResultSet rs = null;
    java.sql.Statement stat = null;
    try{
      stat = conn.createStatement();
      rs = openrs (stat, sql);
      while (rs.next()){
        String lbId  = rs.getString(1);
        String lbVal = rs.getString(2);
        if (lbId!=null){
          oTpl.setVar ("ID", lbId);
          if (lbVal!=null){
            oTpl.setVar ("Value", lbVal);
          }
          else oTpl.setVar ("Value", "");
          if (lbId.equals(""+selectedValue)) {
            oTpl.setVar ("Selected", "SELECTED");
          }
          else oTpl.setVar ("Selected", "");
          oTpl.parse ( nameBlock, true);
        }
      }
      rs.close();
      stat.close();
    }
    catch(Exception ignore)  {}
  }

  void getOptionsLOV( String sLOV, boolean isSearch, boolean isRequired, String selectedValue, String nameBlock, TextTemplate oTpl ) {
    String id = "";
    String val = "";
    java.util.StringTokenizer LOV = new java.util.StringTokenizer(sLOV, ";", true);
    int i = 0;
    String old = ";";
    while ( LOV.hasMoreTokens() ) {
      id = LOV.nextToken();
      if (!old.equals(";") && (id.equals(";"))) id = LOV.nextToken();
      else if (old.equals(";") && (id.equals(";"))) id = "";
      if (!id.equals("")) old = id;
      i++;
      if (LOV.hasMoreTokens()) {
        val = LOV.nextToken();
        if (!old.equals(";") && (val.equals(";"))) val = LOV.nextToken();
        else if (old.equals(";")&& (val.equals(";"))) val = "";
        if ( val.equals(";") ) { val = ""; }
        if (!val.equals("")) old = val;
        i++;
      }
      if ( id.compareTo(selectedValue) == 0 ) {
        oTpl.setVar ("Selected", "SELECTED");
      } else {
        oTpl.setVar ("Selected", "");
      }
      oTpl.setVar ("ID", id);
      oTpl.setVar ("Value", val);
      oTpl.parse ( nameBlock, true);
    }
  }

  String getValFromLOV( String selectedValue , String sLOV) {
    String sRes = "";
    String id = "";
    String val = "";
    java.util.StringTokenizer LOV = new java.util.StringTokenizer( sLOV, ";", true);
    int i = 0;
    String old = ";";
    while ( LOV.hasMoreTokens() ) {
      id = LOV.nextToken();
      if ( ! old.equals(";") && ( id.equals(";") ) ) {
        id = LOV.nextToken();
      }
      else {
        if ( old.equals(";") && ( id.equals(";") ) ) {
          id = "";
        }
      }
      if ( ! id.equals("") )  { old = id; }

      i++;

      if (LOV.hasMoreTokens()) {
        val = LOV.nextToken();
        if ( ! old.equals(";") && (val.equals(";") ) ) {
          val = LOV.nextToken();
        }
        else {
          if (old.equals(";") && (val.equals(";"))) {
            val = "";
          }
        }
        if ( val.equals(";") ) { val = ""; }
        if ( ! val.equals("")) { old = val; }
        i++;
      }

      if ( id.compareTo( selectedValue ) == 0 ) {
        sRes = val;
      }
    } // End while
    return sRes;
  }


%>
<%
    String errString = "";
%>
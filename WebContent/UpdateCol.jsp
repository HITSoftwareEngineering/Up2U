<%@ page language="java" contentType="text/html; charset=utf-8" import="entity.assistantEntity.*,java.sql.*"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<link rel="shortcut icon" href="images/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>修改某列</title>
<link href="public/css/bootstrap.css" rel="stylesheet">
<script type="text/javascript" src="public/js/bootstrap.js"></script>
<script type="text/javascript" src="public/js/jquery-3.1.1.min.js"></script>
</head>
<body>
<!-- 顶部加载进度条！ -->
<script src="public/js/preload.min.js"></script>
<script type="text/javascript">
//调用
$.QianLoad.PageLoading({
    sleep: 50
});
</script>
<%
String tablename = request.getParameter("tablename");
String rownum = request.getParameter("rownum");
System.out.println(rownum);
SqlConst c = new SqlConst();
final String DB_URL = c.getDB_URL();
final String USER = c.getUSER();
final String PASS = c.getPASS();
final String tableName = "SearchRecord";
Connection conn = null;
Statement stmt = null;
Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection(DB_URL, USER, PASS);
stmt = conn.createStatement();
String sql = "SELECT * FROM `" + tablename+"`";
ResultSet rs = stmt.executeQuery(sql);
int num = 0;
while(rs.next()){
	if(rs.getInt("id")>0){
		num++;
	}
}
rs.first();
String[] temp = new String[100];
int ii=0;
while(rs.next()){
	temp[ii]=rs.getString(rownum);
	System.out.println(temp[ii]);
	ii++;
}
%>
<script type="text/javascript">

function n(num2){
	var num="";
	for(var i=0;i<num2;i++){
    num += document.getElementById("num"+i).value+",";
	}
document.getElementById("result").value = num;
}

</script>
<div style="width:60%;margin:1% auto;">
<form  action="updatecolAction">
<h1 style="text-align:center;">正在修改第<%=rownum %>列！</h1>
<input type="hidden" name="tablename" value=<%=tablename %>>
<input type="hidden" name="colNum" value=<%=rownum %>>
<%
  for(int i=0;i<num-1;i++){
%>
<input type="text" id="num<%=i%>" placeholder="<%=temp[i] %>" class="form-control" onblur="n(<%=num-1%>)" style ="margin-top:20px;">
<%
  }
%>
<input type="hidden" name="str" id="result">
<button type="submit" class="btn btn-primary  btn-block" style ="margin:20px auto;">确认修改</button>
</form>
</div>
</body>
</html>
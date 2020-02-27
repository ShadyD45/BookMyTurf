<!DOCTYPE html>
<%@ page import="java.sql.*,java.io.*,java.text.*,java.lang.*,java.util.Date,UsersTurf.*,DBConnection.*" %>
<%
		int uid = (Integer)session.getAttribute("uid");
		Connection conn = DBConnection.makeConnection();
		PreparedStatement ps=null;
		ResultSet rs=null;

		String query= "select * from turf where uid =?";
		ps=conn.prepareStatement(query);
		ps.setInt(1,uid);
		rs=ps.executeQuery();
%>
<html>
<head>    <link rel="stylesheet" href="css/style.css" media="all" />
</head>
<body><br><br>
	<h1>This Feature will be available soon..Thank you for being patient</h1>
<table>
 <thead>
          <tr class="service">
			<th>Turf Name</th><th>Rate Per Hour</th><th><CENTER></CENTER>Contribution to Admin(10%)</th><th>Your Staff Expenses</th><tr>
			<%
					while(rs.next())
					{%>
										<th><%=  rs.getString("tname") %></th><th><%=  rs.getInt("rph") %></th>
										<th><% out.print((rs.getInt("rph")*2)/100); %></th><th><% out.print((rs.getInt("rph")*7)/100);  %></th><tr>
					<%}
			%>
</table>
<div id="notices">
        <div>NOTICE:</div>
        <div class="notice">All the Updated Terms and Conditions Will Be E-Mailed To You:</div>
      </div>
<small></small>
</body>
<%
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
%>
</html>

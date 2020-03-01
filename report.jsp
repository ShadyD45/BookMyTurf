<!DOCTYPE html>
<%@ page import="java.sql.*,java.io.*,java.text.*,java.lang.*,java.util.Date,UsersTurf.*,DBConnection.*" %>
<%
		int uid = (Integer)session.getAttribute("uid");
		Connection conn = DBConnection.makeConnection();
		PreparedStatement ps=null,ps1=null;
		ResultSet rs=null,rs1=null;

		String query= "select * from turf where uid =?";
		String query1="select * from bookings where tid=?";
		ps=conn.prepareStatement(query);
		ps.setInt(1,uid);
		rs=ps.executeQuery();

		ps1=conn.prepareStatement(query1);

		int grandtotal=0,admintotal=0,stafftotal=0,gsttotal=0;
		
%>
<html>
<head>    <link rel="stylesheet" href="css/style.css" media="all" />
</head>
<body><br><br>
	<h1>This Feature will be available soon..Thank you for being patient</h1>
<table>
 <thead>
          <tr class="service">
			<th>Turf Name</th><th>Rate Per Hour</th><th><CENTER></CENTER>Contribution to Admin(10%)</th><th>Your Staff Expenses</th><th>GST</th><tr>
			<tr><td></td><td></td><td></td><td></td><td></td></tr>
			<%
					while(rs.next())
					{%>
										<th><%=  rs.getString("tname") %></th><th>RATE : <%=  rs.getInt("rph") %></th>
										<th>ADMIN : <% out.print("8%"); %></th><th>STAFF : <% out.print("10%");  %></th>
										<th>GST : 18%</th><tr>

<%
										ps1.setInt(1,rs.getInt("tid"));
										rs1=ps1.executeQuery();

										while(rs1.next())
										{
											if(rs1.getInt("pending_amount")==0)
											{%>
												<th>---</th><th><%=  rs1.getInt("total_amount") %></th>
												<th><% out.print((rs1.getInt("total_amount")*8)/100); %></th>
												<th><% out.print((rs1.getInt("total_amount")*10)/100);  %></th>
												<th><% out.print((rs1.getInt("total_amount")*18)/100);  %></th><tr>
											<%
												grandtotal += rs1.getInt("total_amount");
												admintotal += (rs1.getInt("total_amount")*8)/100;
												stafftotal += (rs1.getInt("total_amount")*10)/100;
												gsttotal += (rs1.getInt("total_amount")*18)/100;
										}}%>
												<th>TOTAL</th><th><%=  grandtotal %></th>
												<th><%= admintotal %></th>
												<th><%= stafftotal %></th>
												<th><%= gsttotal %></th><tr>

											<tr><td></td><td></td><td></td><td></td><td></td></tr><%

											grandtotal=0;
											admintotal=0;
											stafftotal=0;
					}
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

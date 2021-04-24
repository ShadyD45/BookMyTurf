<!DOCTYPE html>
<%@ page import="java.sql.*,java.io.*,java.text.*,java.lang.*,java.util.Date,UsersTurf.*,DBConnection.*" %>
<%
		String mail = (String)session.getAttribute("email");
		int uid;
		String tid1;
		int tid;
		String query;
		Connection conn = DBConnection.makeConnection();
		Statement ps=null;
		PreparedStatement ps1=null,ps2=null,ps3=null;
		ResultSet rs1=null,rs2=null,rs=null,rs3=null;
	
		if(mail==null)
        {
			response.sendRedirect("index.jsp");
		}
		else
		{
			uid = (Integer)session.getAttribute("uid");
			tid1 = (String)session.getAttribute("tid");
			tid=Integer.parseInt(tid1);

			
			query= "select MAX(bid) from bookings";
			ps=conn.createStatement();
			rs=ps.executeQuery(query);

			if(rs.next())
			{
				int bid = rs.getInt(1);

				query= "select * from bookings where bid=?";
				ps3=conn.prepareStatement(query);
				ps3.setInt(1,bid);
				rs3=ps3.executeQuery();
				rs3.next();

				query="select * from users where uid = ?";
				ps1=conn.prepareStatement(query);
				ps1.setInt(1,uid);
				rs1=ps1.executeQuery();

				query="select * from turf";
				ps2=conn.prepareStatement(query);
				rs2=ps2.executeQuery();
			}
%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>RECEIPT</title>
    <link rel="stylesheet" href="css/style.css" media="all" />
  </head>
  <body>
    <header class="clearfix">
      <div id="logo">
        <img src="images/receipt/logo2.png">
      </div>
      <h1>Receipt</h1>
<%
				while(rs2.next())
				{
					if(tid==rs2.getInt("tid"))
					{
%>
					  	<div id="company" class="clearfix">
						<div>Turf Name : <%= rs2.getString("tname") %></div>
						<div></div>
						<div>Turf Address : <%= rs2.getString("addr") %></div>
						<div></div>
						<div>Rate : <%= rs2.getString("rph")%>/hr</div>
						<div><br></div>
						<div>Contact : <a><%= rs2.getString("phone") %></a></div>
					 	</div>
					 	<%
					 }
					 
					 }%>
					<% while(rs1.next())
					{
							if(uid==rs1.getInt("uid")) 
						%>
					  	<div id="project">
						<div><span>Name</span> <%= rs1.getString("name") %> </div>
						<div><span>ADDR</span> <%= rs1.getString("addr") %> </div>
						<div><span>EMAIL</span> <a> <%= rs1.getString("email") %> </a></div>
						<div><span>DATE</span> <%		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");    
					   									Date currDate = new Date(); out.print(sdf.format(currDate)); %> </div>
						<div><br><center><span>BOOKING_ID : </span>  <%= rs3.getInt("bid") %></center></div></div>
<% 					} 
%>
    </header>
    <main>
      <table>
        <thead>
          <tr>
            <th>DAT-E</th>
            <th class="service">FROM-TO</th>
            <th class="desc">DURATION</th>
            <th>PAID</th>
            <th>REMAIN</th>
			<th>TOTAL</th>
          </tr>
        </thead>
        <tbody>
<%
			// 	rs.last();
%>
          <tr>
			<td class="service"><%= rs3.getString("booking_date") %> </td>
            <td class="service"> <%= rs3.getString("from_time") %> - <%= rs3.getString("to_time") %> </td>
			<td class="service"><%= rs3.getString("duration") %> hr </td>
			<td class="unit"> <%= rs3.getString("paid_amount") %>  </td>
            <td class="qty"> <%= rs3.getString("pending_amount") %> </td>
            <td class="total"> <%= rs3.getString("total_amount") %> </td>
          </tr>
         
        </tbody>
      </table>
      <div id="notices">
        <div>NOTICE:</div>
        <div class="notice">Take a screenshot of this receipt and show it to the our staff at turf location.</div>
      </div>
    </main>
    <footer>
				<p>&copy; 2020 BookMyTurf.com</p>
    </footer>
  </body>
<%
	rs.close();
	rs1.close();
	rs2.close();
	rs3.close();
	ps1.close();
	ps2.close();

	ps.close();
	conn.close();
	}
	
%>

<%
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
%>
</html>

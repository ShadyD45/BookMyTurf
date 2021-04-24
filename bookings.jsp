<!DOCTYPE html>
<%@ page import="java.sql.*,java.io.*,java.text.*,java.lang.*,java.util.Date,UsersTurf.*,DBConnection.*" %>
<%
		
			if(session.getAttribute("email")!=null)
			{
				int uid = (Integer)session.getAttribute("uid");
				String mail = (String)session.getAttribute("email");


				Connection conn = DBConnection.makeConnection();
				PreparedStatement ps=null,ps1=null,ps2=null;
				ResultSet rs=null,rs1=null,rs2=null;

				String query= "select * from turf where uid =?";
				ps=conn.prepareStatement(query);
				ps.setInt(1,uid);
				rs=ps.executeQuery();	
%>
<html>
<head>    <link rel="stylesheet" href="css/style.css" media="all" />
</head>
<body><br><br>
<fieldset><legend>
<center>PENDING_USERS</center></legend><br>
<center>
<table>
 <thead>
          <tr>
         
            <th class="service">Booking Id</th>
			<th>Turf</th>
			<th>Player Name</th>
            <th>Phone No.</th>
            <th>Booking Date</th>
			<th>From : To</th>
			<th>Duration</th>
			<th>Game</th>
			<th>Total</th>
			<th>Paid Amount</th>
			<th>Pending Amount</th>
			<th>Update Payment Status</th>
          </tr>
        </thead>
        <tbody>
		<%
			 	while(rs.next()){ 

						String query1= "select * from bookings where tid =?";
						ps1=conn.prepareStatement(query1);
						ps1.setInt(1,rs.getInt("tid"));
						rs1=ps1.executeQuery();
						while(rs1.next())
						{
								String query2= "select * from users where uid =?";
								ps2=conn.prepareStatement(query2);
								ps2.setInt(1,rs1.getInt("uid"));
								rs2=ps2.executeQuery();
								rs2.next();

						if(Integer.parseInt(rs1.getString("pending_amount"))>0){

		%>
          <tr>
            <td class="qty"> <%= rs1.getInt("bid") %> </td>
            <td class="qty"><%= rs.getString("tname") %> </td>
            <td class="qty"><%= rs2.getString("name") %> </td>
			<td class="qty"><%= rs2.getString("phone") %> </td>
			<td class="qty"> <%= rs1.getString("booking_date") %> </td>
			<td class="qty"> <%= rs1.getString("from_time") %> - <%= rs1.getString("to_time") %>  </td>
			<td class="qty"> <%= rs1.getString("duration") %> hr </td>
			<td class="qty"> <%= rs1.getString("game_name") %>  </td>
            <td class="qty"> <%= rs1.getString("total_amount") %> </td>
            <td class="qty"> <%= rs1.getString("paid_amount") %> </td>
            <td class="qty"> <%= rs1.getString("pending_amount") %> </td>
			<form action = "paid.jsp" method="get">

				<input type="hidden" name="bid" value=<%=rs1.getInt("bid")%>>
				<input type="hidden" name="total" value=<%=rs1.getInt("total_amount")%>>
							<td class="qty"> <input type="submit" name="paid" value="Amount Paid"> </td>
			</form>
          </tr>
		<% } } }%>
         
        
      </table>
    </fieldset>


<br><br>
<fieldset><legend>
<center>PAID_USERS</center></legend><br>
<table>
 <thead>
          <tr>
         
            <th class="service">Bid</th>
			<th>Turf</th>
			<th>player</th>
            <th>phone</th>
            <th>date</th>
			<th>from : to</th>
			<th>duration</th>
			<th>game</th>
			<th>total</th>
			<th>paid</th>
			<th>pending</th>
          </tr>
        </thead>
        <tbody>
		<%

			ps=conn.prepareStatement(query);
			ps.setInt(1,uid);
			rs=ps.executeQuery();

			 	while(rs.next()){ 

						String query1= "select * from bookings where tid =?";
						ps1=conn.prepareStatement(query1);
						ps1.setInt(1,rs.getInt("tid"));
						rs1=ps1.executeQuery();
						while(rs1.next())
						{
								String query2= "select * from users where uid =?";
								ps2=conn.prepareStatement(query2);
								ps2.setInt(1,rs1.getInt("uid"));
								rs2=ps2.executeQuery();
								rs2.next();

						if(Integer.parseInt(rs1.getString("pending_amount"))==0){

		%>
          <tr>
            <td class="qty"> <%= rs1.getInt("bid") %> </td>
            <td class="qty"><%= rs.getString("tname") %> </td>
            <td class="qty"><%= rs2.getString("name") %> </td>
			<td class="qty"><%= rs2.getString("phone") %> </td>
            <td class="qty"> <%= rs1.getString("booking_date") %> </td>
			<td class="qty"> <%= rs1.getString("from_time") %> - <%= rs1.getString("to_time") %>  </td>
			<td class="qty"> <%= rs1.getString("duration") %> hr </td>
			<td class="qty"> <%= rs1.getString("game_name") %>  </td>
            <td class="qty"> <%= rs1.getString("total_amount") %> </td>
            <td class="qty"> <%= rs1.getString("paid_amount") %> </td>
            <td class="qty"> <%= rs1.getString("pending_amount") %> </td>
			
          </tr>
		<% } 
	} 
}
}
else
	response.sendRedirect("index.jsp");
		response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");

		%>
         
        </tbody>
      </table>
      </center>
    </main></fieldset>








    <footer>
				<p>&copy; 2020 BookMyTurf.com</p>
    </footer>
  </body>
 
</html>

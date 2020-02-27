<!DOCTYPE html>
<%@ page import="java.sql.*,java.io.*,java.text.*,java.lang.*,java.util.Date,UsersTurf.*,DBConnection.*" %>
<%
		
      if(session.getAttribute("email")!=null)
      {
        int uid = (Integer)session.getAttribute("uid");
   
        Connection conn = DBConnection.makeConnection();
        PreparedStatement ps=null,ps1=null;
        ResultSet rs=null,rs1=null;

        String query= "select * from bookings where uid = ?";
        ps=conn.prepareStatement(query);
        ps.setInt(1,uid);
        rs=ps.executeQuery();
%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>RECEIPT</title>
    <link rel="stylesheet" href="css/style.css" media="all" />
  </head>
  <body>
    <br><br>
    <main>
      <table>
        <thead>
          <tr>
			<th>TURF_NAME</th>         
			<th>PHONE</th>         
			<th>DATE</th>
            <th class="service">FROM-TO</th>
            <th class="desc">DURATION</th>
            <th>PAID</th>
            <th>REMAIN</th>
			<th>TOTAL</th>
          </tr>
        </thead>
        <tbody>
		<% 	
    while(rs.next())
    {


				String query1= "select * from turf where tid = ?";
				ps1=conn.prepareStatement(query1);
				ps1.setInt(1,rs.getInt("tid"));
				rs1=ps1.executeQuery();
				rs1.next();
  	%>
          <tr>

            <td class="total"> <%= rs1.getString("tname") %> </td>
            <td class="total"> <%= rs1.getString("phone") %> </td>
            <td class="total"> <%= rs.getString("booking_date") %> </td>
            <td class="service"> <%= rs.getString("from_time") %> - <%= rs.getString("to_time") %> </td>
			<td class="service"><%= rs.getString("duration") %> hr </td>
			 <td class="unit"> <%= rs.getString("paid_amount") %>  </td>
            <td class="qty"> <%= rs.getString("pending_amount") %> </td>
            <td class="total"> <%= rs.getString("total_amount") %> </td>
          </tr>
		<%
     } 
   }
   else
   {
      response.sendRedirect("index.jsp");
   }
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    %>
         
        </tbody>
      </table>
      <div id="notices">
        <div>NOTICE:</div>
        <div class="notice">These are all your bookings.</div>
      </div>
    </main>
    <footer>
				<p>&copy; 2020 BookMyTurf.com</p>
    </footer>
  </body>
</html>

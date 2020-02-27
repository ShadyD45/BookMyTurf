
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,DBConnection.DBConnection" %>
<!DOCTYPE html>

<html>
	<head>

	 <link rel="stylesheet" href="css/admin.css">
	
	</head>

	<body>
            
            <%
                if(session.getAttribute("email")!=null)
                {
                    if(session.getAttribute("email").equals("admin@admin.com"))
                    {
            %>
        <%@ include file="header.jsp" %> <br>
        <center>
	<fieldset>
	<legend><center><b><u></u>PENDING OWNER DETAILS</b></center></legend>

		<table border=1 style="height:100%; width:100%;" id="admin">
		<tr align="center"><th>Sr_no.</th><th>Name</th><th>Email</th><th>Address</th><th>Phone</th><th>UserType</th>
		<th>Pwd</th><th>Status</th><th>Upload Image</th><th>Accept</th><th>Reject</th></tr>

        <%
            Connection conn=DBConnection.makeConnection();
	    PreparedStatement ps=null;
            ResultSet rs=null;


            
            ps = conn.prepareStatement("select * from users where verificationStatus='R' ");
            rs = ps.executeQuery();

            int i=0;

            while(rs.next())
            {
%>

			<tr align="center"><td><%out.print(" "+(i+1));%></td>
			<td><% out.print(rs.getString("name")); %></td>
			<td><% out.print(rs.getString("email")); %></td>
			<td><% out.print(rs.getString("addr")); %></td>
			<td><% out.print(rs.getLong("phone")); %></td>
			<td><% out.print(rs.getString("utype")); %></td>
			<td><% out.print(rs.getString("password")); %></td>
			<td><% out.print(rs.getString("verificationstatus")); %></td>
			

			<form action = "operation.jsp" method="get">
						<td><input type = "text" name = "logo" placeholder="Image name on server"></td>
                            <input type="hidden" name="uid" value=<%=rs.getInt("uid")%>>
                            <in>
                            <td><input type="submit"  name="opr" value="accept" ></td>
                            <td><input type="submit"  name="opr" value="remove" ></td>
			</tr>
                        </form>
	<%
		i++;
            }
%>	</table></fieldset></center><br><br>

	<fieldset>
	<legend><center><b><u></u>VERIFIED OWNER DETAILS</b></center></legend>

	<table border=1 style="height:100%; width:100%;" id="admin">
		<tr align="center"><th>Sr_no.</th><th>Name</th><th>Email</th><th>Address</th><th>Phone</th><th>UserType</th>
		<th>Pwd</th><th>Status</th><th>Remove</th></tr>
<%
	ps = conn.prepareStatement("select * from users where utype='O' and verificationStatus = 'V' ");
	rs = ps.executeQuery();

	i=0;

	while(rs.next())
	{%>

			<tr align="center"><td><%out.print(" "+(i+1));%></td>
			<td><% out.print(rs.getString("name")); %></td>
			<td><% out.print(rs.getString("email")); %></td>
			<td><% out.print(rs.getString("addr")); %></td>
			<td><% out.print(rs.getLong("phone")); %></td>
			<td><% out.print(rs.getString("utype")); %></td>
			<td><% out.print(rs.getString("password")); %></td>
			<td><% out.print(rs.getString("verificationstatus")); %></td>

			<form action = "operation.jsp" method="get">

                            <input type="hidden" name="uid" value=<%=rs.getInt("uid")%>>
			<td><input type="submit"  name="opr" value="remove" ></td>
			</tr>
			</form>
	<%
			
			i++;
	}

	%>

		</table></fieldset></center><br><br>

		

          

		<fieldset>
	<legend><center><b><u></u>TURFS</b></center></legend>

	<table border=1 style="height:100%; width:100%;" id="admin">
		<tr align="center"><th>Sr_no.</th><th>Owner Name</th><th>Turf Name</th><th>Address</th><th>Phone</th><th>rate</th>
		<th>image name</th></tr>
<%
	ps = conn.prepareStatement("select * from turf");
	
        rs = ps.executeQuery();

	i=0;

	while(rs.next())
	{

			String query1 = "select verificationstatus,name from users where uid = ?";

		            PreparedStatement ps1 = conn.prepareStatement(query1);
					 ps1.setInt(1,rs.getInt("uid"));
					ResultSet rs1 = ps1.executeQuery();
				String V="V";
				while(rs1.next()){
				if(V.equals(rs1.getString("verificationstatus"))){


%>

			<tr align="center"><td><%out.print(" "+(i+1));%></td>
			<td><% out.print(rs1.getString("name")); %></td>
			<td><% out.print(rs.getString("tname")); %></td>
			<td><% out.print(rs.getString("addr")); %></td>
			<td><% out.print(rs.getLong("phone")); %></td>
			<td><% out.print(rs.getInt("rph")); %></td>
			<td><% out.print(rs.getString("logo")); %></td>
			<form action = "operation.jsp" method="get">
<!--				<input type="hidden" name="tid" value=<%=rs.getInt("tid")%>>
			<td><input type="text" name="path"><br><input type="submit"  name="opr" value="update" ></td>
			<td><input type="text" name="rate"><br><input type="submit"  name="opr" value="update_rate"></td>
			--></tr></form>
	<%
		i++;
	}
}}
%>
		</table></fieldset></center>
          
<%
}
	%>

		</table></fieldset></center><br><br>

		<fieldset>
	<legend><center><b><u></u>USERS</b></center></legend>

	<table border=1 style="height:100%; width:100%;" id="admin">
		<tr align="center"><th>Sr_no.</th><th>Name</th><th>Email</th><th>Adrs</th><th>Phone</th><th>UserType</th>
		<th>Pwd</th><th>Status</th></tr>
<%
	Connection conn=DBConnection.makeConnection();
	PreparedStatement ps = conn.prepareStatement("select * from users where utype='P' ");
	ResultSet rs = ps.executeQuery();

	int i=0;

	while(rs.next())
	{
    %>

			<tr align="center"><td><%out.print(" "+(i+1));%></td>
			<td><% out.print(rs.getString("name")); %></td>
			<td><% out.print(rs.getString("email")); %></td>
			<td><% out.print(rs.getString("addr")); %></td>
			<td><% out.print(rs.getLong("phone")); %></td>
			<td><% out.print(rs.getString("utype")); %></td>
			<td><% out.print(rs.getString("password")); %></td>
			<td><% out.print(rs.getString("verificationstatus")); %></td>
			</tr>
    <%
                    i++;
            }

    %>
		</table></fieldset>
    <%
                            }
                            else
                            {
                                response.sendRedirect("index.jsp");
                            }
                        
                        
                               response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
                               
                               //response.setHeader("Pragma","no-cache");
                               //response.setDateHeader ("Expires", 0);

    %>

    <%@ include file="footer.jsp" %>                 
</body>
        
</html>

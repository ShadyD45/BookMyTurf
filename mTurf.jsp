<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,DBConnection.DBConnection" %>
<!DOCTYPE html>
<html>
	<head>
        <%@ include file="header.jsp" %> <br>
	 <link rel="stylesheet" href="css/admin.css">
	
	</head>

	<body>
            
		<fieldset>
	<legend><center><b><u></u>TURFS</b></center></legend>

	<table border=1 style="height:100%; width:100%;" id="admin">
		<tr align="center"><th>Sr_no.</th><th>tName</th><th>Adrs</th><th>Phone</th><th>rate</th>
		<th>image name</th><th>update_img_name</th><th>update_rate</th></tr>
<%
			try{
				String e=(String)session.getAttribute("email");
	            Connection conn=DBConnection.makeConnection();
				PreparedStatement ps = conn.prepareStatement("select * from turf where uid=(select uid from users where email=?)");
				ps.setString(1,e);
	
			       ResultSet rs = ps.executeQuery();

				int i=0;

	while(rs.next())
	{
%>

			<tr align="center"><td><%out.print(" "+(i+1));%></td>
			<td><% out.print(rs.getString("tname")); %></td>
			<td><% out.print(rs.getString("addr")); %></td>
			<td><% out.print(rs.getLong("phone")); %></td>
			<td><% out.print(rs.getInt("rph")); %></td>
			<td><% out.print(rs.getString("logo")); %></td>
			<form action = "mTurf.inc.jsp" method="get">
			<input type="hidden" name="tid" value=<%=rs.getInt("tid")%>>
			<td><input type="text" name="path"><br><input type="submit"  name="opr" value="update" ></td>
			<td><input type="text" name="rate"><br><input type="submit"  name="opr" value="update_rate"></td>
			</tr></form>
	<%
		i++;
	}

%>
		</table></fieldset></center>
          
<%
}
	catch(Exception e){out.print(e);}
	%>
    <%@ include file="footer.jsp" %>                 
		</table></fieldset></center><br><br>
</body>
<%
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
%>
</html>

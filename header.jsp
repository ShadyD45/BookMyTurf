<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.io.*,java.text.*,java.lang.*,java.util.Date,UsersTurf.*,DBConnection.*" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/nav-bar.css">
    </head>
    <body>
        <%
            String email=(String)session.getAttribute("email");
            String utype=(String)session.getAttribute("utype");
            //Redirect user to home page if already logged in
            if(email!=null)
            {
                if(utype.equals("P")){
                    out.print("<div class='topnav'>"
                            +"<a class='link' href='logout.jsp'>LogOut</a>"
                             +"<a class='link' href='playbook.jsp'>Bookings</a>"
                             + "<a class='my-account' href='' >" +email+ "</a></div>");
                }
				else if( utype.equals("A"))
				{
                   			 out.print("<div class='topnav'>"
                            +"<a class='link' href='logout.jsp'>LogOut</a>"
                             + "<a class='my-account' href='' >" +email+ "</a></div>");
                }
                else if(utype.equals("O")){
                    Connection conn = DBConnection.makeConnection();
                    String query = "select name from users where email=?";
                    PreparedStatement ps1 = conn.prepareStatement(query);
                    ps1.setString(1,email);
                    ResultSet rs = ps1.executeQuery();
                    if(rs.next())
                    {
                     out.print("<div class='topnav'>"
                             +"<a class='link' href='logout.jsp'>LogOut</a>"
                             +"<a class='link' href='bookings.jsp'>Bookings</a>"
                             +"<a class='link' href='addturf.jsp'>Add Turf</a>"
                             +"<a class='link' href='report.jsp'>Generate Report</a>");

							SimpleDateFormat sdf = new SimpleDateFormat("dd");    
							Date currDate = new Date();
							String Thirty="30";
							if(Thirty.equals(sdf.format(currDate)))
							{
                             out.print("<a class='link' href='mTurf.jsp'>Manage Turf</a>");
							}
                             out.print( "<a class='my-account' href=''>"+email+"</a></div>");
                    }
                    
                }
            }
            else
            {
                out.print("<div class='topnav'>"
                        + "<a class='link' href='SignUp.jsp'>Sign Up</a>"
                        + "<div class='login-container'>"
                        + "<form action='login.inc.jsp' method='post'>"
                        + "<input type='email' placeholder='Email-Id' name='user' required> <input type='password' placeholder='Password' name='pwd' required>"
                        + "<input type='submit' value='Login'>"
                        + "</form>"
                        + "</div>"
                        + "</div>");
            }

            String status=request.getParameter("status");

            if(status!=null){
                    if(status.equals("false")){
                               out.print("<script>alert('Incorrect login details!')</script>");	           		
                    }
                    else{
                             out.print("<script>alert('Some Error Occured!')</script>");
                    }
            }
            //response.sendRedirect("index.jsp");
        %>   
    </body>
</html>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,java.io.*,UsersTurf.*,DBConnection.DBConnection" %>
<!DOCTYPE html>

<html>
	<head>
	</head>

	<body>

<%
                String s1=request.getParameter("opr");
                Turf t = null;
                Users u = null;
		if(s1.equals("accept"))
		{   
                        int uid=Integer.parseInt(request.getParameter("uid"));
                        String logoName = request.getParameter("logo");
                        u = new Users();
			
                        if(logoName!=null)
                        {
                            if(u.verificationStatus(uid))
                            {   
                                try{
                                    String query  = "update turf set logo=? where uid=?";
                                    Connection conn = DBConnection.makeConnection();
                                    PreparedStatement ps = conn.prepareStatement(query); 
                                    ps.setString(1,logoName);
                                    ps.setInt(2,uid);
                                    ps.executeUpdate();
                                }
                                catch(Exception e)
                                {
                                    out.println(e);
                                }
                                response.sendRedirect("admin.jsp");
                            }
                            else
                                out.println("Some error occured to accept");
                        }
                        else{
                            out.println("<script>alert('Image is Compulsory')</script>");
                             out.println("setInterval(window.location.href ='admin.jsp', 3000)</script>");
                            //response.sendRedirect("admin.jsp");
                        }
        }
        else if(s1.equals("remove"))
		{
                        int uid=Integer.parseInt(request.getParameter("uid"));
                        t = new Turf();
                        u = new Users();
			String query="delete from bookings where tid=(select tid from turf where uid=?)";
			try
        		{
				            Connection conn = DBConnection.makeConnection();
				            PreparedStatement ps = conn.prepareStatement(query);
				            ps.setInt(1,uid);
				            ps.executeUpdate();
		         } 
		         catch(SQLException e)
			 {
			        	e.printStackTrace();
      		         }
                        if(t.deleteTurf(uid))
                            if(u.deleteUser(uid))
                                response.sendRedirect("admin.jsp");
			             else{
					    out.println("<script>alert('some error occured to remove')");
					     out.println("setInterval(window.location.href ='admin.jsp', 3000)</script>");
                        		}
        	}
		else if(s1.equals("update"))
		{
                    String path=request.getParameter("path");
                    int id = Integer.parseInt(request.getParameter("tid"));
                    t = new Turf();
		    
                    if(t.updateTurfLogo(path, id))
                        response.sendRedirect("admin.jsp");
                    else{
                            out.println("<script>alert('some error occured to update image')");
                             out.println("setInterval(window.location.href ='admin.jsp', 3000)</script>");
                    }
        }
		else if(s1.equals("update_rate"))
		{
			int rate=Integer.parseInt(request.getParameter("rate"));
                        int id = Integer.parseInt(request.getParameter("tid"));
			t = new Turf();
			 
                        if(t.updateTurfRPH(rate,id)){
                            response.sendRedirect("admin.jsp?");
                        }
                        else{
                            out.println("<script>alert('some error occured to update image')");
                             out.println("setInterval(window.location.href ='admin.jsp', 3000)</script>");
                        }
			
		}
		else
        {
                    out.println("<center><h1>ERROR 404</h1></center>");
        }
       response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
%>
	</body>
</html>

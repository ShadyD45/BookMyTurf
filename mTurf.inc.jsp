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
                        u = new Users();
			
                        if(u.verificationStatus(uid))
                            response.sendRedirect("mTurf.jsp");
                        else
                            out.println("Some error occured to accept");
                }
                else if(s1.equals("remove"))
		{
                        int uid=Integer.parseInt(request.getParameter("uid"));
                        t = new Turf();
                        u = new Users();
			
                        if(t.deleteTurf(uid))
                            if(u.deleteUser(uid))
                                response.sendRedirect("mTurf.jsp");
			else
                            out.println("some error occured to remove");
                }
		else if(s1.equals("update"))
		{
                    String path=request.getParameter("path");
                    int id = Integer.parseInt(request.getParameter("tid"));
                    t = new Turf();
		    
                    if(t.updateTurfLogo(path, id))
                        response.sendRedirect("mTurf.jsp");
                    else
                        out.println("some error occured to update path");
                }
		else if(s1.equals("update_rate"))
		{
			int rate=Integer.parseInt(request.getParameter("rate"));
                        int id = Integer.parseInt(request.getParameter("tid"));
			t = new Turf();
			 
                        if(t.updateTurfRPH(rate,id)){
                            response.sendRedirect("mTurf.jsp?");
                        }
                         else
                        out.println("some error occured to update rate");
			
		}
		else
                {
                    out.println("ERROR 404");
                }
   response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");    
%>
	</body>
</html>

<!DOCTYPE html>
<%@ page import="java.sql.*,java.io.*,java.text.*,java.lang.*,java.util.Date,UsersTurf.*,DBConnection.*" %>
<%
               
				if(session.getAttribute("email")!=null)
				{
					String s1=request.getParameter("paid");
					int bid=Integer.parseInt(request.getParameter("bid"));
					int total=Integer.parseInt(request.getParameter("total"));
					if(s1.equals("Amount Paid"))
					{
							Connection conn = DBConnection.makeConnection();
							PreparedStatement ps=null;
							ResultSet rs=null;

							String query= "update bookings set pending_amount=0,paid_amount=total_amount where bid=?";
							ps=conn.prepareStatement(query);
							ps.setInt(1,bid);
							ps.executeUpdate();
                                                        rs.close();
							ps.close();
							conn.close();

	                        response.sendRedirect("bookings.jsp");
					}
					
				}
				else
				{
					response.sendRedirect("index.jsp");
				}	
				
				response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
%>

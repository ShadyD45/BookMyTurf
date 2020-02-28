<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.*,UsersTurf.*,DBConnection.*" %>
<!DOCTYPE html>
<html>

<head>
    <title>Book My Turf</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<%@ include file="header.jsp" %> 
<body>
    
   
    <!-- Code for showing all the turfs in the database -->  
    <%
        session.setAttribute("alertFlag",1);
        session.setAttribute("checkFlag",0);
        session.setAttribute("date",null);
        String query;
        
        int uid[] = new int[50];
        int i=0;

        ResultSet rs = null,rs1=null;
        PreparedStatement ps = null,ps1=null;

    
        
        	query = "select * from turf";

            Connection conn = DBConnection.makeConnection();
            ps = conn.prepareStatement(query);
            
           
            rs = ps.executeQuery();
            String V="V";
      try
      {
            while(rs.next())
            {        
            		 String query1 = "select verificationstatus from users where uid = ?";

		             ps1 = conn.prepareStatement(query1);
      					 ps1.setInt(1,rs.getInt("uid"));
      					 rs1 = ps1.executeQuery();

          				while(rs1.next())
                  {
            				  if(V.equals(rs1.getString("verificationstatus")))
                      {
                %>
            				    <div class='middle'>
                            <div class="flex-container">
                                  <div class="gallery">
                                      <a target="_blank" href="images/TurfLogo/<%= rs.getString("logo") %>">
                                          <img src=images/TurfLogo/<%= rs.getString("logo") %> width="800" height="600">
                                      </a>
                                          &nbsp;&nbsp;<center><span style="background-color: #A5C1E1;"><b> <%= rs.getString("tname")%> / <%= rs.getString("addr")%> 
            							 </b><br>&nbsp;&nbsp;<b>Price/Hr: <%= rs.getInt("rph") %></b></span></center>
                                     <div class="desc">
                                         <form action="bookturf.jsp" method="post">
                                             <input type="hidden" name="tid" value=<%= rs.getString("tid")%> >
                                             <input type="submit" value="Book Now">
                                         </form>
                                     </div>   
                                  </div> </div>
                            </div>
                <%			}
          					}      
            }
		  }
		  catch(Exception e){
			  System.out.println(e);
		  }
		
       rs1.close();
       rs.close();
       ps.close();
       ps1.close();
       conn.close();
    %>
    <!-- End of all Turf Display container -->

    
<!--   
  *out.println("<div class='flex-container'>"
                + "<div class='gallery'>"
                + " <a target='_blank' href='1.jpeg'>"
                + " <img src='"+rs.getString("logo")+"' width='800' height='600'>"
                        + "</a>"
                        + "&nbsp;&nbsp;<b>Name:"+rs.getString("tname")+"</b><br>&nbsp;&nbsp;<b>Price/Hr:"+rs.getInt("rph")+"</b>"
                        + "<div class='desc'>"
                        + "<form action='booking.inc.jsp' method='post'>"
                        + "<input type='submit' value='Book Now'>"
                        + "</form>"
                        + "</div>"
                        + "</div>"
                        + "</div>");
                
                ps.setInt(1,uid[i]);
                rs = ps.executeQuery();
                i++;   
  -->
 
       
    
    
</body>


</html>
<%@ include file="footer.jsp" %> 

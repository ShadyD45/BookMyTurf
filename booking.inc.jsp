<%@ page import="java.sql.*,java.io.*,java.text.*,java.util.Date,UsersTurf.Booking,DBConnection.*" %>
<html>
    <head>
        <link type="text/css" rel="stylesheet" href="css/availableSlots.css" />
        <title></title>
    </head>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
        String btnCheckFlag = request.getParameter("check");
        String btnBookFlag = request.getParameter("book");
        String gameName = request.getParameter("game");
        
        String thr = request.getParameter("to_hr");
        String fhr = request.getParameter("from_hr");
        String tmin = request.getParameter("to_min");
        String fmin = request.getParameter("from_min");
        
        int to_hr = Integer.parseInt(thr);
        int from_hr = Integer.parseInt(fhr);
        
        int to_min = Integer.parseInt(tmin);
        int from_min = Integer.parseInt(fmin);
      
        Date currDate=null;
        Date selectedDate = null;
    
        /* Get Date for checking if the booking time is after current time incase of same booking date and current date  */    
        String date = request.getParameter("date"); 
        
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //Format the date in given format     
        currDate = sdf.parse(sdf.format(new Date()));
        selectedDate = sdf.parse(date);
            
        if (btnCheckFlag != null) 
        {
             //Show the availibility window
             if(currDate.compareTo(selectedDate) < 0  || currDate.compareTo(selectedDate) == 0)
             {
                    session.setAttribute("date",date);  //Set the date session variable to display the available slots window
                    response.sendRedirect("bookturf.jsp");  //Redirect back to booking page
                    //out.println("date is after current date");
             }
             else
             {
                 out.println("<script>alert('Pleae select a valid date')"); 
                             out.println("setInterval(window.location.href ='bookturf.jsp', 3000)</script>");//Commented out for until delay solution is found
                 response.sendRedirect("bookturf.jsp");
             }
        }
        else if((String)session.getAttribute("email")!=null)
        {
            
            if(btnBookFlag.equals("book"))
            {
                if(request.getParameter("cvv")!=null || request.getParameter("ccdc")!=null || request.getParameter("phno")!=null)
                {
                    // Test if selectedDate is after currentDate or equal to timestamp 2
                    if(currDate.compareTo(selectedDate) < 0 || currDate.compareTo(selectedDate) == 0)
                    {
                        System.out.println("selectedDate is after or equal to timestamp 2");
                        
                        if(((from_hr==to_hr) || (from_hr>to_hr) || (from_hr-to_hr==30)))
                        {
                             System.out.println("Time You Entered is Invalid")  ;
                             out.println("<script>alert('Time span must be atleast 1 Hour')"); 
                             out.println("setInterval(window.location.href ='bookturf.jsp', 3000)</script>"); //Commented out for until delay solution is found
                        }
                        else
                        {
                                Booking b = new Booking();
                                String tid = (String)session.getAttribute("tid");
                                int uid = (Integer)session.getAttribute("uid");
                                //out.println("before checking slots");
                                if(b.checkAvailability(tid,fhr,fmin,thr,tmin,date))
                                {
                                    if(b.bookTurf(uid,tid,fhr,fmin,thr,tmin,date,gameName))
                                    {
                                         System.out.println("Turf booked "+tid);
                                        // out.println("<center><h1>Turf booked for turf "+tid+"</h1></center>");
										 %><input type="hidden" name="uid" value=<%= (Integer)session.getAttribute("uid") %>>
											<input type="hidden" name="tid" value=<%= session.getAttribute("tid") %>><%
                                        response.sendRedirect("receipt.jsp");
                                    }
                                    else
                                    {
                                        //System.out.println("Transaction failed!! Try again later!!");
                                        out.println("<center><h1>Oops!! Transaction failed!! Try again later!!</h1></center>");
                                        response.sendRedirect("bookturf.jsp");
                                    }
                                }
                                else
                                {
                                    System.out.println("Booking not available for this time slot of turf "+tid);
                                    //out.println("Booking not available for this time slot of turf "+tid);
                                    out.println("<script>alert('Booking not available for this time slot of turf ')");
                                    out.println("setInterval(window.location.href ='bookturf.jsp', 3000)</script>"); 
                                        //response.sendRedirect("receipt.jsp");
                                }
                        }
                    }
                    else
                    {
                        out.println("<script>alert('Please select valid date for booking')"); //Commented out for until delay solution is found
                        out.println("setInterval(window.location.href ='bookturf.jsp', 3000)</script>");  
                        System.out.println("Date Invalid");
                        //response.sendRedirect("bookturf.jsp");
                    }
                }
                else
                {
                    out.println("<script>alert('Please Fill All The Required Fields')"); //Commented out for until delay solution is found
                    System.out.println("Fill all required fields"); 
                    out.println("setInterval(window.location.href ='bookturf.jsp', 3000)</script>");   
                    //response.sendRedirect("bookturf.jsp");
                }
            }
        }
        else
        {
            out.println("<script>alert('Please First Login')");
            out.println("setInterval(window.location.href ='bookturf.jsp', 3000)</script>");    
            //response.sendRedirect("index.jsp");1
        }
         response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
%>
  

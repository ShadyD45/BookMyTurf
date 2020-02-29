<!DOCTYPE html>
<%@ page import="java.sql.*,java.io.*,java.lang.*,UsersTurf.*,DBConnection.*" %>
<html lang="en">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
       	<!--The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Booking Form </title>

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />
        <link type="text/css" rel="stylesheet" href="css/book.css" />
        <link type="text/css" rel="stylesheet" href="css/availableSlots.css" />
    </head>

    <body>
        <%
            
            session.setAttribute("tid",request.getParameter("tid"));
            
            if ((int)session.getAttribute("alertFlag") == 1) {
                out.println("<script>alert('You have to pay 30% of the total amount Online')</script>");
                session.setAttribute("alertFlag", 0);
            }  
            if((String)session.getAttribute("date")==null)
            {
        %>
        
        <div id="booking" class="section">
            <div class="section-center">
                <div class="container">
                    <div class="row">
                        <div class="booking-form">
                            <div class="form-header">
                                <h2>Book Your Turf</h2>
                            </div>
                            <form action="booking.inc.jsp" method="post" id="booking-form">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <span class="form-label">CVV</span>
                                            <input class="form-control" name="cvv" maxlength="3" placeholder="CVV">
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <span class="form-label">Credit Card or Debit Card Number</span>
                                            <input class="form-control" name="ccdc" pattern="^\d{16}$" placeholder="Enter Credit or Debit Card Number ">
                                        </div>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <span class="form-label">Phone</span>
                                    <input class="form-control" type="tel" pattern="^\d{10}$" name="phno" placeholder="Enter your phone number">
                                </div>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <span class="form-label">Game</span>
                                            <select class="form-control" name="game">
                                                    <option>Cricket</option>
                                                    <option>Football</option>
                                                    <option>Volleyball</option>
                                            </select>
                                             <span class="select-arrow"></span>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <span class="form-label">Booking Date</span>
                                            <input class="form-control" name="date" type="date" required>
                                        </div>
                                    </div>
                                </div>



                                <div class="col-sm-6">
                                    <span class="form-label">From</span>
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <span class="time-label">Hour</span>
                                                <select class="form-control" name="from_hr">
                                                    <option>06</option>
                                                    <option>07</option>
                                                    <option>08</option>
                                                    <option>09</option>
                                                    <option>10</option>
                                                    <option>11</option>
                                                    <option>12</option>
                                                    <option>13</option>
                                                    <option>14</option>
                                                    <option>15</option>
                                                    <option>16</option>
                                                    <option>17</option>
                                                    <option>18</option>
                                                    <option>19</option>
                                                    <option>20</option>
                                                    <option>21</option>
                                                    <option>22</option>
                                                   
                                                </select>
                                                <span class="select-arrow"></span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <span class="time-label">Min</span>
                                                <select class="form-control" name="from_min">
                                                    <option>00</option>
                                                    
                                                    <option>30</option>
                                                </select>
                                                <span class="select-arrow"></span>
                                            </div>
                                        </div>
                                      <!-- <div class="col-sm-4">
                                            <div class="form-group">
                                                <span class="time-label">AM/PM</span>
                                                <select class="form-control" name="from_ampm">
                                                    <option>AM</option>
                                                    <option>PM</option>
                                                </select>
                                                <span class="select-arrow"></span>
                                            </div>
                                        </div>-->
                                     
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <span class="form-label">Till</span>
                                    <div class="row">
                                        <div class="col-sm-4">

                                            <div class="form-group">

                                                <span class="time-label">Hour</span>
                                                <select class="form-control" name="to_hr">
                                                    <option>07</option>
                                                    <option>08</option>
                                                    <option>09</option>
                                                    <option>10</option>
                                                    <option>11</option>
                                                    <option>12</option>
                                                    <option>13</option>
                                                    <option>14</option>
                                                    <option>15</option>
                                                     <option>16</option>
                                                    <option>17</option>
                                                    <option>18</option>
                                                    <option>19</option>
                                                     <option>20</option>
                                                    <option>21</option>
                                                    <option>22</option>
                                                    <option>23</option>
                                                </select>
                                                <span class="select-arrow"></span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <span class="time-label">Min</span>
                                                <select class="form-control" name="to_min">
                                                    <option>00</option>
                                                    
                                                    <option>30</option>
                                                </select>
                                                <span class="select-arrow"></span>
                                            </div>
                                            
                                        </div><small>The Time Slots Are in 24 Hour Format</small>
                                        <!--<div class="col-sm-4">
                                            <div class="form-group">
                                                <span class="time-label">AM/PM</span>
                                                <select class="form-control" name="to_ampm">
                                                    <option>AM</option>
                                                    <option>PM</option>
                                                </select>
                                                <span class="select-arrow"></span>
                                            </div>
                                        </div>-->
                                    </div>
                                </div>
                                 
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <div>
                                                <button type="submit" name="check" value="check" class="submit-btn">Check Availibility</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <div>
                                                <button type="submit" name="book" value="book" class="submit-btn">Book Now</button>
                                            </div> 
                                        </div>
                                    </div>

                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
                                                                                                            
<%
    }
    else
    {
%>
        <div id="booking" class="section">
            <div class="section-center">
                <div class="container">
                    <div class="booking-form" id="myForm">

                        <h2><Span style="background-color:#3393ff;">All the Booked Timings For Selected Date
<%

						Connection conn=DBConnection.makeConnection();
						PreparedStatement ps=null;
						ResultSet rs=null;

										String query = "select from_time,to_time from bookings where booking_date = ?";
										PreparedStatement ps1 = conn.prepareStatement(query);
										String date=(String)session.getAttribute("date");
										String usedate=(String)date;
										ps1.setString(1,usedate);
										
										ResultSet rs1 = ps1.executeQuery();
										out.print("From  :  To");
										while(rs1.next())
											out.print("<br>"+rs1.getString("from_time")+" : "+rs1.getString("to_time"));
%>
                        
                        <br><button type="button" class="cancel" onclick="window.location.href ='bookturf.jsp'">Close</button>
                        </Span>
                        </h2>
                    </div>
                </div>
            </div>
        </div>
     
<%
        session.setAttribute("date",null);
    } 
%>


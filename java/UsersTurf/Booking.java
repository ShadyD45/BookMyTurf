package UsersTurf;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import DBConnection.*;
import java.sql.*;

public class Booking extends DBConnection{

    private boolean flag;
    private String query;
  
    /**
    *   Returns the Total price for given turf and duration 
    */
    private int getTotalTurfPrice(int id,int dur[])
    {
        String q = "select rph from turf where tid=?";
        int price=0;
        int rph=0;
        
        try
        {
            Connection conn = DBConnection.makeConnection();
            PreparedStatement ps1 = conn.prepareStatement(q);
            
            ps1.setInt(1,id);
            rs = ps1.executeQuery();
            
            if(rs.next())
                rph = rs.getInt("rph");
            
            System.out.println(rph);
            
            price = rph*dur[0];
            
            System.out.println(price);
            
            rs.close();
            ps1.close();
            conn.close();
            
            if(dur[1]==0)
            {
                return price;
            }
            else
            {
                return price + (rph/2);
            }
            
            
         }
         catch(SQLException e)
         {
             System.out.println(e);
         }
        return price;
    }
     
    /*
       Returns the time difference between the selected time slot
    */
    private int[] getTimeDifference(int fhr,int fmin,int tohr,int tomin)
    {
        int diff[] = new int[2];
        diff[0] = tohr-fhr;    //Difference between hour
        diff[1]  = tomin-fmin; //Difference between minutes
         //System.out.println("Hour Diff: "+diff[0]);
         //System.out.println("Min Diff: "+diff[1]);
        if(diff[1] < 0)
        {
            diff[1] = diff[1] * -1;
            diff[0] = diff[0] - 1;
            return diff; 
        }
        else
        {
            return diff;
        }
    }
           
       
    /*
       Returns true if the turf is booked successfully else return false
    */
    public boolean bookTurf(int uid,String id,String from_hr,String from_min,String to_hr,String to_min,String date,String game_name)
    {
        query="insert into bookings(uid,tid,booking_date,from_time,to_time,duration,game_name,total_amount,paid_amount,pending_amount) values(?,?,?,?,?,?,?,?,?,?)";   
        
        int tid = Integer.parseInt(id);
        
        int thr = Integer.parseInt(to_hr);
        int fhr = Integer.parseInt(from_hr);
        int tomin = Integer.parseInt(to_min);
        int fmin = Integer.parseInt(from_min);
        
        int diff[] = new int[2];
        int totalAmount=1;
        long tamt;
        try
        {
            Connection conn = DBConnection.makeConnection();
            ps = conn.prepareStatement(query);
            
            ps.setInt(1,uid);
            ps.setInt(2,tid);
            ps.setString(3,date);
            ps.setString(4,from_hr+":"+from_min);
            ps.setString(5,to_hr+":"+to_min);
            
            
            diff = getTimeDifference(fhr,fmin,thr,tomin);
            totalAmount = getTotalTurfPrice(tid,diff);
            tamt=totalAmount;
            
            //For Debugging
            System.out.println("Total: "+totalAmount);
            System.out.println("30%: "+((30*totalAmount)/100));
            System.out.println("Pending: "+(totalAmount - ((totalAmount*30)/100)));
            
            ps.setString(6,(diff[0]+":"+diff[1]));
            ps.setString(7,game_name);
            ps.setLong(8,tamt);
            ps.setInt(9,((30*totalAmount)/100));
            ps.setInt(10,(totalAmount - ((totalAmount*30)/100)));
            ps.executeUpdate();

            ps.close();
            conn.close();
            flag = true;  
        }
        catch(SQLException e)
        {
            System.out.println("In booking"+e);
        }
        return flag;
    }
 
    /*
    *   Return true if there is overlap between given two times otherwise returns false
    */
    private boolean hasOverlap(LocalTime givenFromTime,LocalTime givenToTime, LocalTime from_time,LocalTime to_time)
    {
        if(givenFromTime.compareTo(from_time)==0 && givenToTime.compareTo(to_time)==0)
        {
            return true;
        }
        else
        {
            return givenFromTime.isAfter(from_time) && givenFromTime.isBefore(to_time) ||
                   givenToTime.isAfter(from_time) && givenToTime.isBefore(to_time) ||
                   givenFromTime.isBefore(from_time) && givenToTime.isAfter(to_time);
        }
        /*
          Attempt to optimize the code (In testing phase)
            return givenFromTime.isAfter(from_time) && givenFromTime.isBefore(to_time) ||
                       givenToTime.isAfter(from_time) && givenToTime.isBefore(to_time) ||
                       givenFromTime.isBefore(from_time) && givenToTime.isAfter(to_time);
            //return !givenToTime.isBefore(from_time) && !givenFromTime.isAfter(to_time);           
        */           
    }
    
    /*
    *   Returns true if the selected time slot is available otherwise returns false
    */
    public boolean checkAvailability(String id,String from_hr,String from_min,String to_hr,String to_min,String date)
    {
        query = "select * from bookings where tid=? and booking_date=?";
        int tid = Integer.parseInt(id);
        String gFrom = from_hr+":"+from_min;
        String gTo = to_hr+":"+to_min;
        //System.out.println(gFrom+" "+gTo);

        LocalTime givenFromTime = LocalTime.parse(gFrom,DateTimeFormatter.ofPattern("HH:mm"));
        LocalTime givenToTime = LocalTime.parse(gTo,DateTimeFormatter.ofPattern("HH:mm"));
        //System.out.println("in checking after parsing time");
       
          
        try
        {
            Connection conn = DBConnection.makeConnection();
            PreparedStatement  ps1 = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ps1.setInt(1,tid);
            ps1.setString(2,date);
            
            rs = ps1.executeQuery();
            //System.out.println("in checking try ");
            
            if(rs.next())
            {
                rs.beforeFirst();
               
                while(rs.next())
                {
                    LocalTime from_time = LocalTime.parse(rs.getString("from_time"));
                    LocalTime to_time = LocalTime.parse(rs.getString("to_time"));
                    //System.out.println("in checking while ");
                    if(givenFromTime.compareTo(from_time)==0 && givenToTime.compareTo(to_time)==0)
                    {
                            return false;
                    }
                    if(hasOverlap(givenFromTime,givenToTime,from_time,to_time))
                    {

                        //System.out.println("Overlap found ");
                        return false;
                    }
                    else
                    {
                       
                        flag=true;
                        //System.out.println("NO overlap");
                    }
                }
            }
            else
            {
                flag=true;
            }
            
            rs.close();
            ps1.close();
            conn.close();
        }
        catch(SQLException e)
        {
            System.out.println("In checking slot "+e);
        }
        return flag;
    }
}

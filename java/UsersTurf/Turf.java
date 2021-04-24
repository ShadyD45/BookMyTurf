package UsersTurf;

import java.sql.*;
import DBConnection.DBConnection;


public class Turf extends DBConnection
{
    private boolean flag;
    private String query;
    
    public Turf()
    {
    
    }
    
    /*
    *	Returns the last tid(Turf id) from the database 
    */
    protected static int getCurrentTid()
    {
        int tid=0;
        
            try
            {
                try (Connection conn = DBConnection.makeConnection()) 
                {
                   stmt = conn.createStatement();
                   rs = stmt.executeQuery("SELECT * FROM turf");
                   
                    while(rs.next())
                    {
                        tid = rs.getInt("uid");
                    }
                    
                    stmt.close();
                    rs.close();
                    conn.close();
                }
            }
            catch(SQLException e)
            {
                System.out.println(e);
            }
        return tid;
    }
    
   /* //Code pending(Write if needed)
    public boolean checkTurf(String addr,String name)
    {
        boolean flag=true;
        
        return flag;
    }
    */
    
    /*
    *	Returns true if the turf is inserted successfully else return false
    */
    public boolean insertTurf(String name,String addr,String phno,int rph)
    {
        query = "insert into turf(tname,addr,phone,uid,rph) values(?,?,?,?,?)";
        name = name.toLowerCase();
        //addr = addr.toLowerCase();
        long phn = Long.parseLong(phno);
        try
        {
                Connection conn = DBConnection.makeConnection();
                ps = conn.prepareStatement(query);
           
                ps.setString(1,name);
                ps.setString(2,addr);
                ps.setLong(3,phn);
                ps.setInt(4,Users.getCurrentUid());
                ps.setInt(5,rph);
                    
                ps.executeUpdate();
                ps.close();
                conn.close();
                    
                flag=true;
        }
        catch(SQLException e)
        {
            System.out.println(e);
            flag=false;
        }
        return flag;  
    }
    
    /*	Takes uid as parameter
    *	Returns true if the turf is deleted successfully else return false
    */
    public boolean deleteTurf(int id)
    {
        query = "DELETE FROM turf where uid=?";
        try
        { 
            Connection conn = DBConnection.makeConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1,id);
            ps.executeUpdate();
            ps.close();
            conn.close();
            flag = true;         
        }
        catch(SQLException e){
            System.out.println(e);
            flag = false;
        }
        return flag;      
    }
    
    /*	Takes rate and turfid as parameter
    *	Updates the Specified turfs rate per hour
    *	Returns true if the turf rate per hour is updated successfully else return false
    */
    public boolean updateTurfRPH(int rate,int tid)
    {
        try
        {
            Connection conn = DBConnection.makeConnection();
	    
            ps = conn.prepareStatement("update turf set rph=? where tid=?");
            ps.setInt(1,rate);
            ps.setInt(2,tid);
            ps.executeUpdate();
            flag=true;
        }
        catch(SQLException e)
        {
            System.out.println(e);
            flag=false;
        }   
        return flag;
    }
    
    /*	Takes image path and turfid as parameter
    *	Updates the Specified turf's Logo
    *	Returns true if the turf logo is updated successfully else return false
    */
    public boolean updateTurfLogo(String path,int tid)
    {
            
        try
        {
            Connection conn = DBConnection.makeConnection();    
            ps = conn.prepareStatement("update turf set logo=? where tid=?");
            ps.setString(1,path);
	    ps.setInt(2,tid);
            ps.executeUpdate();
            flag=true;
        }
        catch(SQLException e){
            System.out.println(e);
            flag=false;
        }
        return flag;
    }
    
    /*	Takes turfid as parameter
    *	Returns the path of the specified turfs logo from database
    */
    public String getTurfLogo(int i)
    {
        query = "select * from turf where uid=?";
        String path = null;
        try
        {
            Connection conn = DBConnection.makeConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1,i);
            rs = ps.executeQuery(query);
            
            path = rs.getString("logo");
            
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return path;
    }
}

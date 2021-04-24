package UsersTurf;

import java.sql.*;

import DBConnection.DBConnection;

public class Users extends DBConnection
{
    private String query;
    private boolean flag;
    
    public Users()
    {
        
    }
   
    protected static int getCurrentUid()
    {
        int uid=0;
       
            try
            {
                try (Connection conn = DBConnection.makeConnection()) 
                {
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM users");
                    
                    while(rs.next())
                    {
                        uid = rs.getInt("uid");
                    }
                    
                    rs.close();
                    stmt.close();
                    conn.close();
                }
            }
            catch(SQLException e)
            {
                System.out.println(e);
            }
            
        return uid;
    }
    
    public boolean checkEmail(String email)
    {
        //boolean flag;
        query="select * from users where email=?";
        
        try{
            Connection conn = DBConnection.makeConnection();
            ps = conn.prepareStatement(query);
            
            ps.setString(1,email);
            rs = ps.executeQuery();
            
            flag = rs.next();
            
            rs.close();
            ps.close();
            conn.close();    
        }
        catch(SQLException e)
        {
            System.out.println(e);
            flag=false;
        }
        return flag;
    }
     /*
    *	Insert the user into t database with required details
    */
    public boolean insertUser(String name,String mail,String addr,String phno,String type,String psw,String vs)
    { 
        //boolean flag;
        query = "insert into users(name,email,addr,phone,utype,password,VerificationStatus) values(?,?,?,?,?,?,?)";
        //addr = addr.toLowerCase();
        name = name.toLowerCase();
        long phn = Long.parseLong(phno);
            
        try
        {
            Connection conn = DBConnection.makeConnection();
            ps = conn.prepareStatement(query);

            ps.setString(1,name);
            ps.setString(2,mail);
            ps.setString(3,addr);
            //ps.setString(4,phno);
            ps.setLong(4,phn);
            ps.setString(5,type);
            ps.setString(6,psw);
            ps.setString(7,vs);
            ps.executeUpdate();

            ps.close();
            conn.close();
            flag = true;
        }
        catch(SQLException e)
        {
            System.out.println(e);
            flag = false;
        }
        return flag;
    }
    
    /*
    *	Takes uid as parameter and updates the specified users status to Verified('V')
    */
    public boolean verificationStatus(int id)
    {
        try
        {
                Connection conn = DBConnection.makeConnection();
               
		ps=conn.prepareStatement("update users set verificationStatus = 'V' where uid = ? ");
		ps.setInt(1,id);
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
    /* Takes uid as parameter
    *	Deletes the specified user from the users table
    */
    public boolean deleteUser(int id)
    {
        //boolean flag;
        query = "DELETE FROM users where uid=?";
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
   
    /*
        Returns the array of id's of all verified turf owners
    */
    public int[] searchVerifiedTurfOwners()
    {
        int i=0;
        int id[] = new int[50];
        query = "select * from users where utype=? and verificationstatus=?";
        try
        {
            Connection conn = DBConnection.makeConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1,"O");
            ps.setString(2,"V");
            
            rs = ps.executeQuery();
            
            while(rs.next())
            {
                id[i] = rs.getInt(1);
                i++;
            }
            rs.close();
            ps.close();
            conn.close();
            
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return id;
    }
}

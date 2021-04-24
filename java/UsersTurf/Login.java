/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UsersTurf;

import java.sql.*;
import DBConnection.*;
/**
 *
 * @author ShadyD45
 */
public class Login extends DBConnection
{
    private static String email;
    private static String pass;
    private static int uid;
    private static String utype;
    
    Login()
    {
        
    }
    
    public static String loginCheck(String mail,String pass)
    {
        if(mail.equals("admin@admin.com") && pass.equals("admin"))
        {
            Login.setEmail(mail);
            Login.setPassword(pass);
            Login.setUtype("A");
            return "admin";
        }
        else
        {
            String query = "select * from users where email=? and password=?";
            try
            {
                Connection conn=DBConnection.makeConnection();
                ps=conn.prepareStatement(query);
                ps.setString(1,mail);
                ps.setString(2,pass);
                
                rs=ps.executeQuery();
                
                if(rs.next())
                {
                    setEmail(mail);
                    setPassword(pass);
                    setUid(rs.getInt("uid"));
                    setUtype(rs.getString("utype"));
                    return "true";
                }
                else
                {
                    return "false";
                }
            }
            catch(SQLException e)
            {
                System.out.println(e);
            }
            /*catch(Exception e)
            {
                System.out.println(e);
            }*/
        }
        return "error";
    }
   
    private static void setEmail(String mail)
    {
        email = mail;
    } 
    private static void setUtype(String type)
    {
        utype = type;
    } 
    private static void setUid(int id)
    {
        uid = id;
    } 
   
    private static void setPassword(String pwd)
    {
        pass = pwd;
    }
    
    public static String getEmail()
    {
        return email;
    }
    
    public static int getUid()
    {
        return uid;
    }
 
    public static String getUtype()
    {
        return utype;
    }
}

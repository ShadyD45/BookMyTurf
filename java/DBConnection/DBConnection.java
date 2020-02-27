package DBConnection;

import java.sql.*;

public class DBConnection 
{
    	private static final String URL="jdbc:postgresql://localhost:5432/";
	private static final String DATABASE_NAME="turf";
	private static final String USERNAME="postgres";
	private static final String PASSWORD="shady123";
        
	protected static PreparedStatement ps = null;
        protected static Statement stmt = null;
        protected static ResultSet rs = null;
        
	public static Connection makeConnection()
        {
             Connection conn= null;
		try{
			Class.forName("org.postgresql.Driver");
			conn=DriverManager.getConnection(URL+DATABASE_NAME,USERNAME,PASSWORD);
 
		}
                catch(ClassNotFoundException | SQLException e)
                {
                    System.out.println(e);
                }
		return conn;
	}
}

package sym.common.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionPool {
	public static Connection getConn()
	{
		Connection conn=null;
		DataSource ds=null;
		try {
			Context cxt=new InitialContext();
			ds=(DataSource)cxt.lookup("java:comp/env/mydb");
			if(ds!=null)
			{
				conn=ds.getConnection();
			}
//			if(conn!=null)
//			{
//				System.out.println("connect success");
//			}
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	
	}
	
	
	public static void close(PreparedStatement pstmt,Connection conn)
	{
		
			try {
				if(pstmt!=null)
				{
				  pstmt.close();
				}
				if(conn!=null)
				{
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			
		}
	}
	
	public static void close(PreparedStatement pstmt,ResultSet rs,Connection conn)
	{
		try {
			if(pstmt!=null)
			{
			pstmt.close();
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(conn!=null)
			{
				conn.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
	}
	}
}

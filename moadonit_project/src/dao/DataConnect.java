package dao;

import java.sql.Connection;
import java.sql.DriverManager;


public class DataConnect {

	
	

	public static  Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://132.75.252.108:3306/ms2016", "ms2016", "r118i67");
            //jdbc:mysql://localhost:3306/FacebookDB
            return con;
        } catch (Exception ex) {
            System.out.println("Database.getConnection() Error -->"
                    + ex.getMessage());
            return null;
        }
    }

	 public static void close(Connection con) {
	        try {
	            con.close();
	        } catch (Exception ex) {
	        }
	    }

}
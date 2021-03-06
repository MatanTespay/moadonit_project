package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnection {
	private Connection connection;
	private static final String url = "jdbc:mysql://localhost:3306/ms2016?noAccessToProcedureBodies=true&autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull"; 	
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");  //register with DriverManager
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 

	}
	
	public MyConnection() throws SQLException, Exception {
				
		connection = DriverManager.getConnection(url, "root", "1234");
		System.out.println("open connection !");
	}


	public Connection getConnection() {
		//System.out.println(connection.toString());
		try {
			if (this.connection.isClosed()) {
				//connection = DriverManager.getConnection(url, "ms2016", "r118i67");
				connection = DriverManager.getConnection(url, "root", "1234");
				System.out.println("open connection !");
			}else{
				return connection;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}


	public void setConnection(Connection connection) {
		this.connection = connection;
	}
	
	public void closeConnection() {
		try {
			connection.close();
			System.out.println("Connection closed!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}

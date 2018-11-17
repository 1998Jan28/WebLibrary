package Database;

import java.sql.*;

public class DB {
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://39.108.92.145:3306/Library";
    static final String ACCOUNT = "?user=whut&password=whut@web";
    static final String CHARACTER = "&useUnicode=true&characterEncoding=UTF-8";
    static final String URL = DB_URL + ACCOUNT + CHARACTER;

    public static void main(String[] args){
        Connection connection = null;
        Statement state = null;
        try{
            Class.forName(JDBC_DRIVER);
            System.out.println("连接中。。。");
            connection = DriverManager.getConnection(URL);
        }
        catch (Exception e){

        }
    }
}

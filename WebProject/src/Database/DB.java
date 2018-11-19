package Database;

import java.sql.*;

public class DB {
    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    final String DB_URL = "jdbc:mysql://39.108.92.145:3306/Library";
    final String ACCOUNT = "?user=whut&password=whut@web";
    final String CHARACTER = "&useUnicode=true&characterEncoding=UTF-8";
    final String URL = DB_URL + ACCOUNT + CHARACTER;
    Connection connection = null;
    private Statement state = null;

    public boolean Connection(){//连接数据库
        try{
            connection = DriverManager.getConnection(URL);
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            return connection != null;
        }
    }

    public boolean Statement(){//创建Statement对象
        try{
            state = connection.createStatement();
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            return state != null;
        }
    }

    public boolean Query(String sql){//执行查询
        ResultSet result = null;
        try{
            result = state.executeQuery(sql);
            //进行json数据的转换
            Test(result);
            result.close();
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            try{
                if(result != null){
                    result.close();
                }
            }
            catch (SQLException se){
                se.printStackTrace();
            }
            finally {
                return true;
            }
        }
    }

    public boolean Excute(String sql){//执行插入、删除、修改
        boolean result = false;
        try{
            result = state.execute(sql);
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            return result;
        }
    }

    public boolean CloseStatement(){//关闭Statement
        try {
            state.close();
        }
        catch (SQLException se){
            try{
                if(state != null){
                    state.close();
                }
            }
            catch (SQLException se1){
                se.printStackTrace();
            }
        }
        finally {
            return true;
        }
    }

    public boolean CloseConnection(){//关闭Connection
        try {
            connection.close();
        }
        catch (SQLException se){
            try{
                if(connection != null){
                    connection.close();
                }
            }
            catch (SQLException se1){
                se.printStackTrace();
            }
        }
        finally {
            return true;
        }
    }

    public void Test(ResultSet result){//测试用例
        try{
            while(result.next()){
                String bookName = result.getString("BookName");
                String ISBN = result.getString("ISBN");
                String author = result.getString("Author");
                String digest = result.getString("Digest");
                String price = result.getString("Price");
                String amount = result.getString("Amount");
                String index = result.getString("Index");
                System.out.println("ISBN:"+ISBN);
                System.out.println("书名:"+bookName);
                System.out.println("作者:"+author);
                System.out.println("单价:"+price);
                System.out.println("摘要:"+digest);
                System.out.println("数量:"+amount);
                System.out.println("索书号:"+index);
                System.out.println("");
            }
        }
        catch(SQLException se){
            se.printStackTrace();
        }
    }
}

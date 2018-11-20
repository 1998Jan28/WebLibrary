package Database;

import POJO.Return;

import java.sql.*;

import org.json.JSONArray;
import org.json.JSONObject;

public class ReturnDB {

    private ResultSet result = null;
    private DB db = new DB();
    private Connection connection = null;
    private PreparedStatement statement = null;

    public void Connection(){
        try{
            connection = db.getConnection();
        }
        catch (SQLException se){
            se.printStackTrace();
        }
    }

    public JSONArray Query(String cardNum){
        JSONArray list = new JSONArray();
        try{
            result = null;
            statement = connection.prepareStatement("select BookName, BorrowTime, Book.Index from BorrowAndReturn, Book where CardNum=? and ReturnTime is null and Book.Index=BorrowAndReturn.Index");
            statement.setString(1,cardNum);
            result = statement.executeQuery();
            while(result.next()){
                JSONObject temp = new JSONObject();
                temp.put("BorrowTime", result.getString("BorrowTime"));
                temp.put("Index", result.getString("Index"));
                temp.put("BookName", result.getString("BookName"));
                list.put(temp);
            }
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            Close();
            return list;
        }
    }

    public void Close(){
        db.free(result, statement, connection);
    }



}

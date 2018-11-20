package Database;

import POJO.Return;

import java.sql.*;
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

    public JSONObject Query(String cardNum){
        JSONObject object = new JSONObject();
        try{
            result = null;
            statement = connection.prepareStatement("select * from BorrowAndReturn where CardNum=? and ReturnTime=null");
            statement.setString(1,cardNum);
            result = statement.executeQuery();
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {

            return object;
        }
    }

    public void Close(){
        db.free(result, statement, connection);
    }



}

package Service;

import Database.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterService {
    public String Register(String password, String username, String identification, String tele){
        String sql = "insert into User(Pwd, Name, Identification, Tele, Money) values (?, ?, ?, ?, 0)";
        String sql_cardNum = "select CardNum from User where Identification=?";
        String cardNum = null;
        ResultSet result = null;
        Connection connection = null;
        PreparedStatement ps = null;
        DB db = new DB();
        try{
            connection = db.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1,password);
            ps.setString(2,username);
            ps.setString(3,identification);
            ps.setString(4, tele);
            ps.executeUpdate();
            result = ps.executeQuery("select CardNum from User where Identification='" + identification + "'");
            if(result != null){
                while(result.next()){
                    cardNum = result.getString("CardNum");
                }
            }
            db.free(result, ps, connection);
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            return cardNum;
        }
    }
}

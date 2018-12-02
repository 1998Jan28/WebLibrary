package Database;

import POJO.User;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.smartcardio.Card;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDB {
    private DB db=new DB();
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public int AddUser(User user){
        int cardNum = -1;
        try{
            con = db.getConnection();
            String sql = "insert into User(Pwd, Name, Identification, Tele, Money) values(?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user.getPwd());
            pstmt.setString(2, user.getName());
            pstmt.setString(3, user.getIdentification());
            pstmt.setString(4, user.getTele());
            pstmt.setDouble(5, 0);
            if(pstmt.executeUpdate() == 1){
                pstmt = con.prepareStatement("select * from User where Identification=?");
                pstmt.setString(1, user.getIdentification());
                rs = pstmt.executeQuery();
                while(rs.next()){
                    cardNum = rs.getInt("CardNum");
                }
            }

        }
        catch (SQLException se){
            se.printStackTrace();
            cardNum = -1;
        }
        finally {
            db.free(rs, pstmt, con);
            return cardNum;
        }
    }

    public User SearchUser(int CardNum){
        User user = null;
        try{
            con = db.getConnection();
            String sql = "select * from User where CardNum=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, CardNum);
            rs = pstmt.executeQuery();
            if(rs.next()){
                user = new User();
                user.setCardNum(rs.getInt("CardNum"));
                user.setPwd(rs.getString("Pwd"));
                user.setName(rs.getString("Name"));
                user.setIdentification(rs.getString("Identification"));
                user.setTele(rs.getString("Tele"));
                user.setMoney(rs.getDouble("Money"));
            }
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            return user;
        }
    }

    public boolean ModifyUser(User user){
        boolean flag = false;
        try{
            con = db.getConnection();
            String sql = "update User set Pwd=?, Name=?, Identification=?, Tele=? where CardNum=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user.getPwd());
            pstmt.setString(2, user.getName());
            pstmt.setString(3, user.getIdentification());
            pstmt.setString(4, user.getTele());
            pstmt.setInt(5, user.getCardNum());
            flag = pstmt.executeUpdate() == 1? true : false;
        }
        catch (SQLException se){
            se.printStackTrace();
            flag = false;
        }
        finally {
            return flag;
        }
    }

    public boolean DeleteUser(int cardNum){
        boolean flag = false;
        try {
            con = db.getConnection();
            String sql = "Delete from User where CardNum=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, cardNum);
            if(pstmt.executeUpdate() == 1){
                flag = true;
            }
        }
        catch (SQLException se){
            se.printStackTrace();
            flag = false;
        }
        finally {
            db.free(rs, pstmt, con);
            return flag;
        }
    }

    public JSONArray GetAllUser(){
        JSONArray userList = new JSONArray();
        try{
            con = db.getConnection();
            String sql = "select * from User";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next()){
                JSONObject user = new JSONObject();
                user.put("CardNum", String.valueOf(rs.getInt("CardNum")));
                user.put("Pwd", rs.getString("Pwd"));
                user.put("Name", rs.getString("Name"));
                user.put("Identification", rs.getString("Identification"));
                user.put("Tele", rs.getString("Tele"));
                user.put("Money", rs.getDouble("Money"));
                userList.put(user);
            }
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            db.free(rs, pstmt, con);
            return userList;
        }
    }

    public boolean Pay(int CardNum, double pay){
        boolean flag = false;
        User user = SearchUser(CardNum);
        double balance = user.getMoney() - pay;
        if(balance < 0){
            return false;
        }
        try{
            con = db.getConnection();
            String sql = "update User set Money=? where CardNum=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setDouble(1, balance);
            pstmt.setInt(2, CardNum);
            if(pstmt.executeUpdate() == 1){
                flag = true;
            }
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            db.free(rs, pstmt, con);
            return flag;
        }
    }
}

package Database;

import org.json.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookDB {
    private DB db=new DB();
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public JSONArray getAllBooks() throws Exception{
        JSONArray res = new JSONArray();
        con = db.getConnection();

        String sql="select * from Book";
        pstmt=con.prepareStatement(sql);
        rs=pstmt.executeQuery();

        while(rs.next()){
            JSONObject obj=new JSONObject();
            obj.put("BookName",rs.getString("BookName"));
            obj.put("ISBN",rs.getString("ISBN"));
            obj.put("Author",rs.getString("Author"));
            obj.put("Digest",rs.getString("Digest"));
            obj.put("Price",rs.getDouble("Price"));
            obj.put("Amount",rs.getInt("Amount"));
            obj.put("Index",rs.getString("Index"));
            res.put(obj);
        }

        db.free(rs,pstmt,con);

        return res;
    }
}

package Database;

import POJO.Book;
import org.json.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

    public boolean AddBook(Book book) {
        boolean flag = false;
        try{
            con = db.getConnection();
            String sql = "insert into Book(BookName, ISBN, Author, Digest, Price, Amount, `Index`)";
            sql += " values(?,?,?,?,?,?,?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, book.getBookName());
            pstmt.setString(2, book.getISBN());
            pstmt.setString(3, book.getAuthor());
            pstmt.setString(4, book.getDigest());
            pstmt.setDouble(5, book.getPrice());
            pstmt.setInt(6, book.getAmount());
            pstmt.setString(7, book.getIndex());
            flag = pstmt.executeUpdate()== 1 ? true : false;
            db.free(rs, pstmt, con);
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            return flag;
        }
    }
}

package Database;

import POJO.Book;
import POJO.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.*;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.smartcardio.Card;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

public class BookDB {
    private DB db=new DB();
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private static final int MEMORY_THRESHOLD=1024*1024*5;
    private static final int MAX_FILE_SIZE=1024*1024*10;
    private static final int MAX_REQUEST_SIZE=1024*1024*20;
    public String proISBN = null;

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

    public JSONObject getBookByISBN(String ISBN) throws Exception{
        JSONObject res=new JSONObject();
        con=db.getConnection();

        String sql="select * from Book where ISBN=?";
        pstmt=con.prepareStatement(sql);
        pstmt.setString(1,ISBN);
        rs=pstmt.executeQuery();
        if(rs.next()){
            res.put("BookName",rs.getString("BookName"));
            res.put("ISBN",rs.getString("ISBN"));
            res.put("Author",rs.getString("Author"));
            res.put("Digest",rs.getString("Digest"));
            res.put("Price",rs.getDouble("Price"));
            res.put("Amount",rs.getInt("Amount"));
            res.put("Index",rs.getString("Index"));
            res.put("flag","1");
        }else{
            res.put("flag","0");
        }

        db.free(rs,pstmt,con);

        return res;
    }

    public boolean AddBook(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Book book = uploadFile(request, response);
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

    public boolean ModifyBook(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        boolean flag = false;
        Book book = uploadFile(request, response);
        try{
            con = db.getConnection();
            String sql = "update Book set BookName=?, ISBN=?, Author=?, Digest=?, Price=?, Amount=?, `Index`=? where ISBN=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, book.getBookName());
            pstmt.setString(2, book.getISBN());
            pstmt.setString(3, book.getAuthor());
            pstmt.setString(4, book.getDigest());
            pstmt.setDouble(5, book.getPrice());
            pstmt.setInt(6, book.getAmount());
            pstmt.setString(7, book.getIndex());
            pstmt.setString(8, proISBN);
            flag = pstmt.executeUpdate()== 1 ? true : false;
            db.free(rs, pstmt, con);
        }
        catch (SQLException se){
            se.printStackTrace();
            flag = false;
        }
        finally {
            return flag;
        }
    }

    public Book SearchBook(String Index){
        Book book = null;
        try{
            con = db.getConnection();
            String sql = "select * from Book where `Index`=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, Index);
            rs = pstmt.executeQuery();
            rs.next();
            book = new Book();
            book.setIndex(rs.getString("Index"));
            book.setDigest(rs.getString("Digest"));
            book.setAuthor(rs.getString("Author"));
            book.setISBN(rs.getString("ISBN"));
            book.setAmount(rs.getInt("Amount"));
            book.setPrice(rs.getDouble("Price"));
            book.setBookName(rs.getString("BookName"));
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally {
            return book;
        }
    }

    public boolean DeleteBook(String ISBN, String cover){
        boolean flag = true;
        try{
            con = db.getConnection();
            String sql = "delete from Book where ISBN=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, ISBN);
            pstmt.executeUpdate();
            File file = new File(cover);
            if(file.isFile() && file.exists()){
                file.delete();
            }
        }
        catch (SQLException se){
            se.printStackTrace();
            flag = false;
        }
        finally {
            return flag;
        }
    }

    public Book uploadFile(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Book book = new Book();
        if(!ServletFileUpload.isMultipartContent(request)){
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
            writer.flush();
            return null;
        }

        DiskFileItemFactory factory=new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload=new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);
        upload.setHeaderEncoding("UTF-8");
        String uploadPath=request.getSession().getServletContext().getRealPath("/BookImg");

        File uploadDir=new File(uploadPath);
        if(!uploadDir.exists()){
            uploadDir.mkdir();
        }

        try{
            List<FileItem> formItems=upload.parseRequest(request);
            if(formItems!=null&&formItems.size()>0){
                FileItem img = null;
                for(FileItem item:formItems){
                    if(!item.isFormField()){
                        img = item;
                    }
                    else{
                        if(item.getFieldName().equals("BookName")){
                            book.setBookName(item.getString("utf-8"));
                        }
                        else if(item.getFieldName().equals("ISBN")){
                            book.setISBN(item.getString("utf-8"));
                        }
                        else if(item.getFieldName().equals("Author")){
                            book.setAuthor(item.getString("utf-8"));
                        }
                        else if(item.getFieldName().equals("Digest")){
                            book.setDigest(item.getString("utf-8"));
                        }
                        else if(item.getFieldName().equals("Price")){
                            book.setPrice(Double.parseDouble(item.getString("utf-8")));
                        }
                        else if(item.getFieldName().equals("Amount")){
                            book.setAmount(Integer.parseInt(item.getString("utf-8")));
                        }
                        else if(item.getFieldName().equals("Index")){
                            book.setIndex(item.getString("utf-8"));
                        }
                        else if(item.getFieldName().equals("proISBN")){
                            proISBN = item.getString("utf-8");
                        }
                    }
                }
                if(!img.getName().equals("")){
                    String filePath=uploadPath+File.separator+book.getISBN()+".jpg";
                    File storeFile=new File(filePath);
                    img.write(storeFile);
                    request.setAttribute("message","upload success");
                }
            }
        }catch(Exception e){
            request.setAttribute("message","错误信息："+e.getMessage());
            e.printStackTrace();
            return null;
        }
        return book;
    }

    public int ReturnBook(String Index, int CardNum){
        int flag = 0;
        try{
            con = db.getConnection();
            String sql = "select min(BorrowTime) from BorrowAndReturn where `Index`=? and CardNum=? and ReturnTime is null";
            java.util.Date date = new java.util.Date();
            SimpleDateFormat  df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String  d = df.format(date);
            pstmt = con.prepareStatement(sql);
            //pstmt.setTimestamp(1, Timestamp.valueOf(d));
            pstmt.setString(1, Index);
            pstmt.setInt(2, CardNum);
            rs = pstmt.executeQuery();
            if(rs.next()){
                Timestamp borrowTime = rs.getTimestamp(1);
                Timestamp returnTime = Timestamp.valueOf(d);
                String earliestTime = borrowTime.toString();
                long time = (returnTime.getTime() - borrowTime.getTime()) / 1000 / 60 / 60 /24;
                time -= 30;
                if(time > 0){
                    UserDB userDB = new UserDB();
                    double pay = time * 0.1;
                    if(! userDB.Pay(CardNum, pay)){
                        db.free(rs, pstmt, con);
                        System.out.println("2222222222222222");
                        flag = 2;
                    }
                }
                if(flag != 2){
                    sql = "update BorrowAndReturn set ReturnTime=? where BorrowTime=? and CardNum=? and `Index`=?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setTimestamp(1, Timestamp.valueOf(d));
                    pstmt.setTimestamp(2, Timestamp.valueOf(earliestTime));
                    pstmt.setInt(3, CardNum);
                    pstmt.setString(4, Index);
                    if(pstmt.executeUpdate() == 1){
                        flag = 1;
                    }
                }
            }
        }
        catch (SQLException se){
            se.printStackTrace();
        }
        finally{
            return flag;
        }
    }

    public int BorrowBook(String Index, int CardNum){
        int flag = 0;
        System.out.println(CardNum);
        User user = (new UserDB()).SearchUser(CardNum);
        if(user == null){
            flag = 2;
        }
        else if(user.getMoney() < 30){
            flag = 3;
        }
        else {
            try {
                con = db.getConnection();
                String sql = "insert into BorrowAndReturn(`Index`, BorrowTime, CardNum) values (?, ?, ?)";
                java.util.Date date = new java.util.Date();
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String d = df.format(date);
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, Index);
                pstmt.setTimestamp(2, Timestamp.valueOf(d));
                pstmt.setInt(3, CardNum);
                if (pstmt.executeUpdate() == 1) {
                    flag = 1;
                }
            } catch (SQLException se) {
                se.printStackTrace();
            } finally {
                return flag;
            }
        }
        return flag;
    }
}

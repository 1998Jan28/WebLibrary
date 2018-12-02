package Service;

import Database.BookDB;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class BorrowAndReturnService {
    public int ReturnBook(HttpServletRequest request) throws IOException{
        request.setCharacterEncoding("utf-8");
        String index = request.getParameter("Index");
        int cardNum = Integer.parseInt(request.getParameter("CardNum"));
        BookDB db = new BookDB();
        return db.ReturnBook(index, cardNum);
    }

    public int BorrowBook(HttpServletRequest request) throws IOException{
        request.setCharacterEncoding("utf-8");
        String index = request.getParameter("Index");
        int cardNum = Integer.parseInt(request.getParameter("CardNum"));
        BookDB db = new BookDB();
        return db.BorrowBook(index, cardNum);
    }
}

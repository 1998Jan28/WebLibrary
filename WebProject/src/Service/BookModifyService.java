package Service;

import Database.BookDB;
import POJO.Book;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class BookModifyService {
    public boolean ModifyBook(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        boolean flag = true;
        BookAddService bas = new BookAddService();
        BookDB db = new BookDB();
        flag = db.ModifyBook(request, response);
        return flag;
    }
}

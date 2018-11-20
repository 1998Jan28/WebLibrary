package Servlet;

import POJO.Book;
import Service.BookAddService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "BookAddServlet")
public class BookAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String bookName = request.getParameter("BookName");
        String ISBN = request.getParameter("ISBN");
        String author = request.getParameter("Author");
        String digest = request.getParameter("Digest");
        Double price = Double.parseDouble(request.getParameter("Price"));
        int amount = Integer.parseInt(request.getParameter("Amount"));
        String index = request.getParameter("Index");
        BookAddService bas = new BookAddService();
        Book book = new Book();
        JSONObject flag = new JSONObject();
        book.setAmount(amount);
        book.setAuthor(author);
        book.setBookName(bookName);
        book.setDigest(digest);
        book.setIndex(index);
        book.setISBN(ISBN);
        book.setPrice(price);
        if(bas.AddBook(book)){
            flag.put("flag", 1);
        }
        else{
            flag.put("flag", 0);
        }
        System.out.println("Servlet:"+ flag);
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.write(flag.toString());
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

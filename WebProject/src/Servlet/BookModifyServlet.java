package Servlet;

import Service.BookModifyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "BookModifyServlet")
public class BookModifyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookModifyService bms = new BookModifyService();
        boolean flag = bms.ModifyBook(request, response);
        request.setAttribute("operation", "modify");
        request.setAttribute("flag", flag);
        request.getRequestDispatcher("showResult.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

package Servlet;

import Service.BookDeleteService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "BookDeleteServlet")
public class BookDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String ISBN = request.getParameter("ISBN");
        String cover = request.getSession().getServletContext().getRealPath("/BookImg");
        cover += File.separator + ISBN + ".jpg";
        boolean flag = true;
        JSONObject result = new JSONObject();
        BookDeleteService bds = new BookDeleteService();
        flag = bds.DeleteBook(ISBN, cover);
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        result.put("flag", flag);
        out.print(result.toString());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

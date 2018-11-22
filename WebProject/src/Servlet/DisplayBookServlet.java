package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import Service.UserService;
import org.json.JSONObject;

@WebServlet(name = "DisplayBookServlet")
public class DisplayBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");//指定返回的格式为JSON格式
        response.setCharacterEncoding("UTF-8");

        PrintWriter out=response.getWriter();
        UserService us=new UserService();
        JSONObject obj;
        try{
            obj=us.getBookByISBN(request.getParameter("isbn"));
            out.write(obj.toString());
        }catch (Exception e){
            System.out.println(e.getCause());
            System.out.println(e.getStackTrace());
            System.out.println(e.getMessage());
            e.printStackTrace();
            out.write("");
        }finally {
            out.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}

package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Console;
import java.io.IOException;
import java.io.PrintWriter;

import Service.UserService;
import org.json.JSONArray;

@WebServlet(name = "UserSearchBooksServlet")
public class UserSearchBooksServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");//指定返回的格式为JSON格式
        response.setCharacterEncoding("UTF-8");

        PrintWriter out=response.getWriter();
        UserService us=new UserService();
        JSONArray arr;
        try{
            arr=us.getAllBooks();
            out.write(arr.toString());
        }catch (Exception e){
            out.write("");
        }finally {
            out.close();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}

package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

import Service.LoginService;
import Servlet.LoginServlet;
import javafx.print.Printer;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String cardNum=request.getParameter("cardNum");
        String password=request.getParameter("password");
        LoginService login=new LoginService();
        String message=login.Login(cardNum,password);
        System.out.println(message);

        JSONObject obj = new JSONObject();
        obj.put("flag",message);
        PrintWriter out=response.getWriter();
        out.write(obj.toString());
//        if(message.equals("登陆成功"))
//        {
//            //HttpSession session=
//            //session["cardNum"] = cardNum;
////            if(cardNum.length()>=8)
////                request.getRequestDispatcher("user.jsp").forward(request, response);
////            else
////                request.getRequestDispatcher("administrator.jsp").forward(request, response);
//
//        }
//        else
//        {
//            PrintWriter out=response.getWriter();
//            out.println(message);
//            out.write(message);
//            //request.getRequestDispatcher("index.jsp").forward(request, response);
//        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}

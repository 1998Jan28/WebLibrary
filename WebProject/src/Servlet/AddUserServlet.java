package Servlet;

import Service.AddUserService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AddUserServlet")
public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AddUserService aus = new AddUserService();
        int cardNum = aus.AddUser(request);
        JSONObject result = new JSONObject();
        result.put("CardNum", cardNum);
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.print(result.toString());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

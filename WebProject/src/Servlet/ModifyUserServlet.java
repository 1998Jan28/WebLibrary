package Servlet;

import Service.ModifyUserService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ModifyUserServlet")
public class ModifyUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ModifyUserService mus = new ModifyUserService();
        boolean flag = mus.ModifyUser(request);
        JSONObject result = new JSONObject();
        result.put("flag", flag);
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.print(result.toString());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

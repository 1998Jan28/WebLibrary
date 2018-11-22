package Servlet;

import Service.DeleteUserService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DeleteUserService dus = new DeleteUserService();
        boolean flag = dus.DeleteUser(request);
        JSONObject result = new JSONObject();
        result.put("flag", flag);
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.print(result);
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

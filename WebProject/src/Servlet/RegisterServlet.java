package Servlet;

import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import Service.RegisterService;

@WebServlet(name = "RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("reg_username");
        String password = request.getParameter("reg_password");
        String identification = request.getParameter("reg_identi");
        String tele = request.getParameter("reg_tel");
        RegisterService rs = new RegisterService();
        String cardNum = rs.Register(password, username, identification, tele);
        request.setAttribute("cardNum", cardNum);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}

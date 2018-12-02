package Servlet;

import Service.BorrowAndReturnService;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "BorrowAndReturnServlet")
public class BorrowAndReturnServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BorrowAndReturnService bars = new BorrowAndReturnService();
        int flag = 0;
        JSONObject result = null;
        if(request.getParameter("Operation").equals("1")){
            flag = bars.ReturnBook(request);
        }
        else{
            flag = bars.BorrowBook(request);
        }
        System.out.println(flag);
        result = new JSONObject();
        result.put("flag", flag);
        PrintWriter out = response.getWriter();
        out.print(result);
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

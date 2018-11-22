package Service;

import Database.UserDB;
import POJO.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class AddUserService {
    public int AddUser(HttpServletRequest request)throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        User user = new User();
        UserDB db = new UserDB();
        user.setPwd(request.getParameter("Pwd"));
        user.setName(request.getParameter("Name"));
        user.setIdentification(request.getParameter("Identification"));
        user.setTele(request.getParameter("Tele"));
        user.setMoney(0.0);
        return db.AddUser(user);
    }
}

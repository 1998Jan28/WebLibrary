package Service;

import Database.UserDB;
import POJO.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ModifyUserService {
    public boolean ModifyUser(HttpServletRequest request) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        UserDB db = new UserDB();
        User user = new User();
        user.setTele(request.getParameter("Tele"));
        user.setIdentification(request.getParameter("Identification"));
        user.setName(request.getParameter("Name"));
        user.setPwd(request.getParameter("Pwd"));
        user.setCardNum(Integer.parseInt(request.getParameter("CardNum")));
        return db.ModifyUser(user);
    }
}

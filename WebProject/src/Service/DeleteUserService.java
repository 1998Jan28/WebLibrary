package Service;

import Database.UserDB;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class DeleteUserService {
    public boolean DeleteUser(HttpServletRequest request)throws ServletException, IOException{
        request.setCharacterEncoding("utf-8");
        int cardNum = Integer.parseInt(request.getParameter("CardNum"));
        UserDB db = new UserDB();
        return db.DeleteUser(cardNum);
    }
}

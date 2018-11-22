package Service;

import Database.UserDB;
import org.json.JSONArray;

public class UserListService {
    public JSONArray GetAllUser(){
        UserDB db = new UserDB();
        return db.GetAllUser();
    }
}

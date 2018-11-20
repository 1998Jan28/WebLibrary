package Service;

import Database.ReturnDB;
import org.json.JSONArray;

public class BookReturnService {

    public JSONArray GetRecord(String cardNum){
        JSONArray list = null;
        ReturnDB db = new ReturnDB();
        db.Connection();
        list = db.Query(cardNum);
        return list;
    }
}

package Service;

import Database.BookDB;
import org.json.JSONArray;

public class UserService {
    private BookDB bookDB=new BookDB();
    public JSONArray getAllBooks() throws Exception{
        return bookDB.getAllBooks();
    }
}

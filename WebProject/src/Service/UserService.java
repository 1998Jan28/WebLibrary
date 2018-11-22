package Service;

import Database.BookDB;
import org.json.JSONArray;
import org.json.JSONObject;

public class UserService {
    private BookDB bookDB=new BookDB();
    public JSONArray getAllBooks() throws Exception{
        return bookDB.getAllBooks();
    }

    public JSONObject getBookByISBN(String ISBN) throws Exception{
        return bookDB.getBookByISBN(ISBN);
    }
}

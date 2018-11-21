package Service;

import Database.BookDB;

public class BookDeleteService {
    public boolean DeleteBook(String ISBN, String cover){
        BookDB db = new BookDB();
        return db.DeleteBook(ISBN, cover);
    }
}

package Service;

import Database.BookDB;
import POJO.Book;

public class BookAddService {
    public boolean AddBook(Book book){
        BookDB db = new BookDB();
        return db.AddBook(book);
    }
}

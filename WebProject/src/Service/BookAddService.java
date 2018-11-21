package Service;

import Database.BookDB;
import POJO.Book;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class BookAddService {
    private static final int MEMORY_THRESHOLD=1024*1024*5;
    private static final int MAX_FILE_SIZE=1024*1024*10;
    private static final int MAX_REQUEST_SIZE=1024*1024*20;
    public String proISBN = null;
    public boolean AddBook(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Book book = null;
        BookDB db = new BookDB();
        return db.AddBook(request, response);
    }
}

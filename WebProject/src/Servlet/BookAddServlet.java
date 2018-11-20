package Servlet;

import POJO.Book;
import Service.BookAddService;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;

@WebServlet(name = "BookAddServlet")
public class BookAddServlet extends HttpServlet {
    private static final int MEMORY_THRESHOLD=1024*1024*5;
    private static final int MAX_FILE_SIZE=1024*1024*10;
    private static final int MAX_REQUEST_SIZE=1024*1024*20;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Book book = null;
        book = uploadFile(request, response);
        BookAddService bas = new BookAddService();
        boolean flag = false;
        if(bas.AddBook(book)){
            flag = true;
        }
        request.setAttribute("flag", flag);
        request.getRequestDispatcher("showAddBookResult.jsp").forward(request, response);
    }

    protected Book uploadFile(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        Book book = new Book();
        if(!ServletFileUpload.isMultipartContent(request)){
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
            writer.flush();
            return null;
        }

        DiskFileItemFactory factory=new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload=new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);
        upload.setHeaderEncoding("UTF-8");
        String uploadPath=request.getSession().getServletContext().getRealPath("/BookImg");

        File uploadDir=new File(uploadPath);
        if(!uploadDir.exists()){
            uploadDir.mkdir();
        }

        try{
            List<FileItem> formItems=upload.parseRequest(request);
            if(formItems!=null&&formItems.size()>0){
                FileItem img = null;
                for(FileItem item:formItems){
                    if(!item.isFormField()){
                        img = item;
                    }
                    else{
                        if(item.getFieldName().equals("BookName")){
                            book.setBookName(item.getString("utf-8"));
                        }
                        else if(item.getFieldName().equals("ISBN")){
                            book.setISBN(item.getString("utf-8"));
                        }
                        else if(item.getFieldName().equals("Author")){
                            book.setAuthor(item.getString("utf-8"));
                        }
                        else if(item.getFieldName().equals("Digest")){
                            book.setDigest(item.getString("utf-8"));
                        }
                        else if(item.getFieldName().equals("Price")){
                            book.setPrice(Double.parseDouble(item.getString("utf-8")));
                        }
                        else if(item.getFieldName().equals("Amount")){
                            book.setAmount(Integer.parseInt(item.getString("utf-8")));
                        }
                        else if(item.getFieldName().equals("Index")){
                            book.setIndex(item.getString("utf-8"));
                        }
                    }
                }
                String fileName=new File(img.getName()).getName();
                String filePath=uploadPath+File.separator+book.getISBN()+".jpg";
                File storeFile=new File(filePath);
                img.write(storeFile);
                request.setAttribute("message","upload success");
            }
        }catch(Exception e){
            request.setAttribute("message","错误信息："+e.getMessage());
            e.printStackTrace();
            return null;
        }
        return book;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

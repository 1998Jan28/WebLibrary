package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "uploadFileServlet")
public class uploadFileServlet extends HttpServlet {
    private static final int MEMORY_THRESHOLD=1024*1024*5;
    private static final int MAX_FILE_SIZE=1024*1024*10;
    private static final int MAX_REQUEST_SIZE=1024*1024*20;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!ServletFileUpload.isMultipartContent(request)){
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
            writer.flush();
            return ;
        }

        DiskFileItemFactory factory=new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload=new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);
        upload.setHeaderEncoding("UTF-8");

        String uploadPath=request.getSession().getServletContext().getRealPath("/BookImg");
        System.out.println(uploadPath);

        File uploadDir=new File(uploadPath);
        if(!uploadDir.exists()){
            uploadDir.mkdir();
        }

        try{
            List<FileItem> formItems=upload.parseRequest(request);
            System.out.println(formItems.size());
            if(formItems!=null&&formItems.size()>0){
                for(FileItem item:formItems){
                    if(!item.isFormField()){
                        String fileName=new File(item.getName()).getName();
                        String filePath=uploadPath+File.separator+fileName;
                        File storeFile=new File(filePath);
                        System.out.println(filePath);
                        System.out.println(1);
                        item.write(storeFile);
                        request.setAttribute("message","upload success");
                    }
                }
            }
        }catch(Exception e){
            request.setAttribute("message","错误信息："+e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

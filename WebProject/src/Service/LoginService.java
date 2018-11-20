package Service;
import Database.DB;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


public class LoginService {
    public String Login(String cardNum,String password)
    {
        String sql=null;
        if(cardNum.length()>=8) {
            int num=Integer.parseInt(cardNum);
           sql= "select CardNum,Pwd  from User where CardNum=" + cardNum ;
        }
        else
        {
           sql="select AdminNum,Pwd from  Administrator where AdminNum=\""+cardNum+"\"";
        }
        String message=null;
        Connection con=null;
        Statement sta=null;
        ResultSet res=null;
        DB db=new DB();

        System.out.println(cardNum +" "+password);

        try {
            con = db.getConnection();
            sta=con.createStatement();
            res=sta.executeQuery(sql);
            System.out.println("连接数据库");
            if(!res.next())
                message= "账号不存在";
            else {
                String pwd = res.getString("Pwd");
                if (pwd.equals(password))
                    message = "登陆成功";
                else
                    message = "密码错误";
            }
        }
        catch (Exception e){
            System.out.println(1);
            e.printStackTrace();
        }finally {
            db.free(res,sta,con);
            System.out.println(message);
        }
        return message;

    }


}

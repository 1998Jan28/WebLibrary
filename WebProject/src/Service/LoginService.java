package Service;
import Database.DB;
import org.json.JSONObject;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


public class LoginService {
    public JSONObject Login(String cardNum,String password)
    {
        String sql=null;
        int flag;
        if(cardNum.length()>=8) {
            int num=Integer.parseInt(cardNum);
            flag=1;
           sql= "select *  from User where CardNum=" + cardNum ;
        }
        else
        {
            flag=2;
           sql="select * from  Administrator where AdminNum=\""+cardNum+"\"";
        }
        String message=null;
        Connection con=null;
        Statement sta=null;
        ResultSet res=null;
        DB db=new DB();

        System.out.println(cardNum +" "+password);

        JSONObject obj = new JSONObject();

        try {
            con = db.getConnection();
            sta=con.createStatement();
            res=sta.executeQuery(sql);
            System.out.println("连接数据库");
            if(!res.next())
                obj.put("message","账号不存在");
            else {
                String pwd = res.getString("Pwd");
                if (pwd.equals(password)){
                    obj.put("message","登陆成功");
                    if(flag==1){
                        obj.put("username",res.getString("Name"));
                        obj.put("money",res.getString("Money"));
                    }
                    else
                        obj.put("username",res.getString("AdminName"));
                }
                else
                    obj.put("message","密码错误");
            }
        }
        catch (Exception e){
            System.out.println(1);
            e.printStackTrace();
        }finally {
            db.free(res,sta,con);
            System.out.println(message);
        }
        return obj;

    }


}

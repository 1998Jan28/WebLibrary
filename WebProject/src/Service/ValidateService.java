package Service;

import Database.DB;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class ValidateService {
    public boolean validate(String cardNum)
    {
        String sql=null;
        if(cardNum.length()>=8) {
            int num=Integer.parseInt(cardNum);
            sql= "select CardNum from User where CardNum=" + cardNum ;
        }
        else
        {
            sql="select AdminNum from  Administrator where AdminNum=\""+cardNum+"\"";
        }
        Connection con=null;
        Statement sta=null;
        ResultSet res=null;
        boolean result=false;
        DB db=new DB();
        try{
            con=db.getConnection();
            sta=con.createStatement();
            res=sta.executeQuery(sql);
            if(!res.next())
                result=false;
            else {
                result=true;
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally {
            db.free(res,sta,con);
        }

        return result;
    }
}

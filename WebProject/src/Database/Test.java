package Database;

public class Test {
    public static void main(String[] args){
        DB db = new DB();
        db.Connection();
        db.Statement();
        db.Query("select * from Book");
        db.CloseStatement();
        db.CloseConnection();
    }
}

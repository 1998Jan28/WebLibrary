package POJO;

public class User {
    private int idCard;//卡号
    private String pwd;//密码
    private String userName;//用户名
    private String idNum;//身份证号
    private String cellphone;//手机号
    private float balance;//余额

    public User(){}

    public int getIdCard() {
        return idCard;
    }

    public String getPwd() {
        return pwd;
    }

    public String getUserName() {
        return userName;
    }

    public String getIdNum() {
        return idNum;
    }

    public String getCellphone() {
        return cellphone;
    }

    public float getBalance() {
        return balance;
    }

    public void setIdCard(int idCard) {
        this.idCard = idCard;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setIdNum(String idNum) {
        this.idNum = idNum;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }

    public void setBalance(float balance) {
        this.balance = balance;
    }
}

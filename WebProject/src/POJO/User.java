package POJO;

public class User {
    private int CardNum;
    private String Pwd;
    private String Name;
    private String Identification;
    private String Tele;
    private Double Money;

    public int getCardNum() {
        return CardNum;
    }

    public void setCardNum(int cardNum) {
        CardNum = cardNum;
    }

    public String getPwd() {
        return Pwd;
    }

    public void setPwd(String pwd) {
        Pwd = pwd;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getIdentification() {
        return Identification;
    }

    public void setIdentification(String identification) {
        Identification = identification;
    }

    public String getTele() {
        return Tele;
    }

    public void setTele(String tele) {
        Tele = tele;
    }

    public Double getMoney() {
        return Money;
    }

    public void setMoney(Double money) {
        Money = money;
    }
}

package POJO;

public class Pay {
    private int idCard;//卡号
    private float amount;//金额

    public Pay(){}

    public void setIdCard(int idCard) {
        this.idCard = idCard;
    }

    public int getIdCard() {
        return idCard;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public float getAmount() {
        return amount;
    }
}

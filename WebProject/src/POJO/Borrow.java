package POJO;

public class Borrow {
    private String bookNum;//索书号
    private String borrowTime;//借书时间
    private int idCard;//卡号
    private boolean back;//是否归还 True：已归还 False：未归还

    public Borrow(){}

    public String getBookNum() {
        return bookNum;
    }

    public void setBookNum(String bookNum) {
        this.bookNum = bookNum;
    }

    public String getBorrowTime() {
        return borrowTime;
    }

    public void setBorrowTime(String borrowTime) {
        this.borrowTime = borrowTime;
    }

    public int getIdCard() {
        return idCard;
    }

    public void setIdCard(int idCard) {
        this.idCard = idCard;
    }

    public void setBack(boolean back) {
        this.back = back;
    }

    public boolean isBack() {
        return back;
    }
}

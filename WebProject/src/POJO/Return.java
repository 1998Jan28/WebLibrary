package POJO;

public class Return {
    private String index;//索书号
    private String bookName;//图书名
    private String borrowTime;//借阅时间

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    public String getIndex() {
        return index;
    }

    public void setBorrowTime(String borrowTime) {
        this.borrowTime = borrowTime;
    }

    public String getBorrowTime() {
        return borrowTime;
    }
}

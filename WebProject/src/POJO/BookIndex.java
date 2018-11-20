package POJO;

public class BookIndex{
    private String ISBN;//图书的ISBN
    private String bookNum;//索书号
    private boolean state;//图书是否在馆 True：在管 False：借出

    public BookIndex(){}

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public String getBookNum() {
        return bookNum;
    }

    public void setBookNum(String bookNum) {
        this.bookNum = bookNum;
    }

    public void setState(boolean state) {
        this.state = state;
    }

    public boolean isState() {
        return state;
    }
}
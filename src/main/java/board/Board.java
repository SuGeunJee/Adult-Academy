package board;

public class Board {
	private String author, title, content;

	public Board(String author, String title, String content) {
		this.author = author;
		this.title = title;
		this.content = content;
	}

	public String getAuthor() {
		return author;
	}

	public String getTitle() {
		return title;
	}

	public String getContent() {
		return content;
	}

}

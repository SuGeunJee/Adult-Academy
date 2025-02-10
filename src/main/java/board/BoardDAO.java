package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.mindrot.jbcrypt.BCrypt;

import util.DBUtil;

public class BoardDAO {
	private static final Map<String, List<Board>> posts = new HashMap<>();
	private static final Map<String, List<Board>> qnaPosts = new HashMap<>(); // Q&A 전용 데이터

	private DataSource dataSource;

	public void BoardDAOInit() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/fisaDB");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 일반 게시글 추가
	public boolean addPost(String email, String category, String title, String content) throws Exception {
		posts.computeIfAbsent(category, k -> new ArrayList<>()).add(new Board(title, content, email));
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DBUtil.getConnection();
			pstmt = con
					.prepareStatement("INSERT INTO board_posts (email, category, title, content) VALUES (?, ?, ?, ?)");

			pstmt.setString(1, email);
			pstmt.setString(2, category);
			pstmt.setString(3, title);
			pstmt.setString(4, content);

			if (pstmt.executeUpdate() != 0) {
				System.out.println("게시글이 성공적으로 저장되었습니다.");
				return true;
			}

		} finally {
			DBUtil.close(con, pstmt);
		}

		return false;
	}

	// Q&A 게시글 추가
	public boolean addQnaPost(String email, String category, String title, String content) throws Exception {
		qnaPosts.computeIfAbsent(category, k -> new ArrayList<>()).add(new Board(title, content, email));
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("INSERT INTO qna_posts (email, category, title, content) VALUES (?, ?, ?, ?)");

			pstmt.setString(1, email);
			pstmt.setString(2, category);
			pstmt.setString(3, title);
			pstmt.setString(4, content);

			if (pstmt.executeUpdate() != 0) {
				System.out.println("게시글이 성공적으로 저장되었습니다.");
				return true;
			}

		} finally {
			DBUtil.close(con, pstmt);
		}

		return false;
	}

	// 일반 게시글 가져오기
	public List<Board> getPosts(String category) throws Exception {

		ArrayList<Board> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("SELECT email, title, content FROM board_posts WHERE category = ?");
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(new Board(rs.getString(1), rs.getString(2), rs.getString(3)));
			}

		} finally {
			DBUtil.close(con, pstmt, rs);
		}

		posts.getOrDefault(category, list);

		return list;
	}

	// Q&A 게시글 가져오기
	public List<Board> getQnaPosts(String category) throws Exception {

		ArrayList<Board> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("SELECT email, title, content FROM qna_posts WHERE category = ?");
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(new Board(rs.getString(1), rs.getString(2), rs.getString(3)));
			}

		} finally {
			DBUtil.close(con, pstmt, rs);
		}

		qnaPosts.getOrDefault(category, list);

		return list;
	}

	// 일반 게시글 삭제
	public boolean deletePost(String category, String title) throws Exception {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("DELETE FROM board_posts WHERE category = ? and title = ?");

			pstmt.setString(1, category);
			pstmt.setString(2, title);

			if (pstmt.executeUpdate() != 0) {
				System.out.println("게시글이 성공적으로 삭제되었습니다.");
				return true;
			}

		} finally {
			DBUtil.close(con, pstmt);
		}
		return false;
	}

	// Q&A 게시글 삭제
	public boolean deleteQnaPost(String category, String title) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("DELETE FROM qna_posts WHERE category = ? AND title = ?");
			pstmt.setString(1, category);
			pstmt.setString(2, title);

			if (pstmt.executeUpdate() != 0) {
				System.out.println("Q&A 게시글이 성공적으로 삭제되었습니다.");
				return true;
			}

		} finally {
			DBUtil.close(con, pstmt);
		}
		return false;
	}
}

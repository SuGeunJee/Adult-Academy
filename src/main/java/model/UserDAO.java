package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;

public class UserDAO {
	
	public static boolean getUser(String id, String pw) throws Exception {// 로그인
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		boolean userId = false;
		
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("SELECT id FROM user WHERE id = ? AND pw = ?");
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				userId = true;
			}
			
		} finally {
			DBUtil.close(con, pstmt, rs);
		}
		
		return userId;
	}
	
	public static boolean addUser(String email, String pw, String name, String phone_number, String grade, String pw_question, String pw_answer) throws Exception {
	    Connection con = null;	
	    PreparedStatement pstmt = null;
	    
	    try {
	        con = DBUtil.getConnection();
	        pstmt = con.prepareStatement("INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)");
	       
	        pstmt.setString(1, email);
	        pstmt.setString(2, pw);
	        pstmt.setString(3, name);
	        pstmt.setString(4, phone_number);
	        pstmt.setString(5, grade);
	        pstmt.setString(6, pw_question);
	        pstmt.setString(7, pw_answer);
	        
	        if(pstmt.executeUpdate() != 0) {
	            return true;
	        }
	        
	    } finally {
	        DBUtil.close(con, pstmt);
	    }
	    
	    return false;
	}
	
	public static boolean confirmUser(String id) throws Exception {// 비밀번호찾기시 id 존재 여부 확인
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select id from user where id = ?");
			
			pstmt.setString(1, id);
			
			if(pstmt.executeUpdate() != 0) {
				return true;
			}
			
		} finally {
			DBUtil.close(con, pstmt);
		}
		
		return false;
	}
}

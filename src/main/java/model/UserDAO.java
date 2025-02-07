package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;

import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {
	
	public static boolean getUser(String email, String pw) throws Exception {// 로그인
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		boolean userId = false;
		
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("SELECT pw FROM user WHERE email = ?");
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				String hashedPw = rs.getString("pw");
	            return BCrypt.checkpw(pw, hashedPw);
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
	       
	        System.out.println("dao:"+email);
	        pstmt.setString(1, email);
	        pstmt.setString(2, BCrypt.hashpw(pw, BCrypt.gensalt()));
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
	
	public static boolean confirmUser(String email) throws Exception {// 비밀번호찾기시 email 존재 여부 확인
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select email from user where id = ?");
			
			pstmt.setString(1, email);
			
			if(pstmt.executeUpdate() != 0) {
				return true;
			}
			
		} finally {
			DBUtil.close(con, pstmt);
		}
		
		return false;
	}
	
	public static String findEmail(String name, String phoneNumber) throws Exception {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DBUtil.getConnection();
	        pstmt = con.prepareStatement("SELECT email FROM user WHERE name = ? AND phone_number = ?");
	        pstmt.setString(1, name);
	        pstmt.setString(2, phoneNumber);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            return rs.getString("email");
	        }
	    } finally {
	        DBUtil.close(con, pstmt, rs);
	    }
	    return null;
	}

	public static boolean verifyUser(String email, String name, String phoneNumber) throws Exception {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        con = DBUtil.getConnection();
	        pstmt = con.prepareStatement("SELECT * FROM user WHERE email = ? AND name = ? AND phone_number = ?");
	        pstmt.setString(1, email);
	        pstmt.setString(2, name);
	        pstmt.setString(3, phoneNumber);
	        rs = pstmt.executeQuery();
	        
	        return rs.next();
	    } finally {
	        DBUtil.close(con, pstmt, rs);
	    }
	}
	
	public static boolean updatePassword(String email, String newPassword) throws Exception {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    
	    try {
	        con = DBUtil.getConnection();
	        pstmt = con.prepareStatement("UPDATE user SET pw = ? WHERE email = ?");
	        
	        // BCrypt를 사용하여 새 비밀번호 해시화
	        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
	        
	        pstmt.setString(1, hashedPassword);
	        pstmt.setString(2, email);
	        
	        return pstmt.executeUpdate() > 0;
	    } finally {
	        DBUtil.close(con, pstmt);
	    }
	}
}

package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.domain.UserDTO;
import util.DBUtil;

public class UserDAO {
	
	public static boolean getUser(String id, String pw) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//UserDTO user = null;
		boolean login = false;
		
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select * from user where id = ? AND pw = ?");
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				login = true;
			}
			
		} finally {
			DBUtil.close(con, pstmt, rs);
		}
		
		return login;
	}
}

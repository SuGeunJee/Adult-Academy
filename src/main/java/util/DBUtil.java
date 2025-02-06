/* 학습순서
 * 1. JDBC 코드 각 메소드별로 Connection 생성
 * 2. db접속 정보를 properties파일로 분리(실무적)
 * 3. web & CP 적용
 * 		- 서버 벤더사별 설정 방식이 다름
 * 		- 동시 접속자 수 제어
 * 		- db설정 정보가 서버 자체의 설정 파일로 분리
 * 4. Spring
 * 		- 서버 벤더사별 설정 방식 없이 spring 설정 파일에 설정
 * 		- web server 종류 무관하게 동일한 설정 
 * 		- 개발 및 설정 표준
 * 
 * 5. 개발 방식
 * 	1단계 : context.xml 에 자원 설정
 *  2단계 : 자바 클래스에서 자원 별칭을 활용 해서 자원활용 객체 먼저 획득(DataSource)
 *  3단계 : DataSource로 부터 Connection 객체 획득 및 활용
 *  4단계 : 반환(삭제 개념이 아닌 재사용을 위한 반환)
 */

package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBUtil {

	static DataSource ds;  // 별칭명으로 검색해서 서버로부터 대입받아야 함. new생성 금지

	static {
		try {
			//서버의 설정을 별칭으로 활용가능하게 하는 API
			//lookup : 검색
			//java:/comp/env - 재사용 가능한 자바 객체의미 
			Context initContext = new InitialContext(); //서버 설정 활용 가능한 객체
			Context envContext = (Context) initContext.lookup("java:/comp/env");//설정 정보 검색 활용 객체
			
			ds = (DataSource) envContext.lookup("jdbc/fisaDB");//별칭으로 실제 객체			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//server 내부의 cp 기능 활용해서 Connection 객체 제공
	public static Connection getConnection() throws SQLException {
		return ds.getConnection();
	}

	public static void close(Connection con, Statement stmt) {
		try {			
			if (stmt != null) {
				stmt.close();
				stmt = null;
			}
			if (con != null) {
				con.close();
				con = null;
			}
		} catch (SQLException s) {
			s.printStackTrace();
		}
	}

	public static void close(Connection con, Statement stmt, ResultSet rset) {
		try {
			if (rset != null) {
				rset.close();
				rset = null;
			}		
			if (stmt != null) {
				stmt.close();
				stmt = null;
			}
			if (con != null) {
				con.close();
				con = null;
			}
		} catch (SQLException s) {
			s.printStackTrace();
		}
	}
}

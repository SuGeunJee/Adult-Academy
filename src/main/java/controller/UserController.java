package controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserDAO;

@WebServlet("/login")
public class UserController extends HttpServlet {
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String command = request.getParameter("command");// 로그인인지 회원가입인지 비밀번호찾기인지 구분
		
		if (command == null) {
			response.sendRedirect("login.html");
		} 
		
		else if (command.equals("login")) {// 로그인
			try {
				String id = request.getParameter("id");
				String pw = request.getParameter("pw");
				
				boolean check = UserDAO.getUser(id, pw);
				
				if (check == true) {
					Cookie idCookie = new Cookie("idkey", id);
					response.addCookie(idCookie);
					response.getWriter().write("success");
				}
				else {
					response.getWriter().write("fail");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		
		else if (command.equals("registerUser")) {
		    try {
		        String id = request.getParameter("id");
		        String pw = request.getParameter("pw");
		        String name = request.getParameter("name");
		        String phone_number = request.getParameter("phone_number");
		        String grade = "user";
		        String pw_question = request.getParameter("pw_question");
		        String pw_answer = request.getParameter("pw_answer");

		        // 이메일 형식 체크
		        if (!id.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>alert('올바른 이메일 형식이 아닙니다'); history.back();</script>");
		            out.close();
		            return;
		        }

		        boolean success = UserDAO.addUser(id, pw, name, phone_number, grade, pw_question, pw_answer);
		        
		        if (success) {
		            response.sendRedirect("login.html");
		        } else {
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>alert('회원가입 실패'); history.back();</script>");
		            out.close();
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.setContentType("text/html;charset=UTF-8");
		        PrintWriter out = response.getWriter();
		        out.println("<script>alert('시스템 오류가 발생했습니다'); history.back();</script>");
		        out.close();
		    }
		}
		
		else if (command.equals("signup")) {// 회원가입
			response.sendRedirect("signup.jsp");// r
		}
		
		else if (command.equals("searchpw")) {// 비밀번호 찾기
			response.sendRedirect("searchpw.jsp");// r
		}
		
	}

}

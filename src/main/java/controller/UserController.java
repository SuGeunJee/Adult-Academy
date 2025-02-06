package controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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
				
				System.out.println(id);
				boolean check = UserDAO.getUser(id, pw);
				System.out.println(check);
				
				if (check == true) request.getRequestDispatcher("main.jsp").forward(request, response);// f
				else {
					response.setContentType("text/html;charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>alert('로그인 오류'); location.href='login';</script>");// id랑 pw 유지하지 않으므로 r
					out.close();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
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

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLIntegrityConstraintViolationException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserDAO;

@WebServlet("/login")
public class UserController extends HttpServlet {
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String command = request.getParameter("command");// 로그인인지 회원가입인지 비밀번호찾기인지 구분
		
		System.out.println(command);
		
		if (command == null) {
			response.sendRedirect("login.html");
		} 
		
		else if (command.equals("login")) {// 로그인
			try {
				String email = request.getParameter("email");
				String pw = request.getParameter("pw");
				
				HttpSession session = request.getSession();
				session.setAttribute("resetEmail", email);
				session.setAttribute("email", email);
				
				boolean check = UserDAO.getUser(email, pw);
				
				if (check == true) {
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
		        String email = request.getParameter("email");
		        String pw = request.getParameter("pw");
		        String name = request.getParameter("name");
		        String phone_number = request.getParameter("phone_number");
		        String grade = "user";
		        String pw_question = request.getParameter("pw_question");
		        String pw_answer = request.getParameter("pw_answer");

		        // 이메일 형식 체크
		        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>alert('올바른 이메일 형식이 아닙니다'); history.back();</script>");
		            out.close();
		            return;
		        }

		        boolean success = UserDAO.addUser(email, pw, name, phone_number, grade, pw_question, pw_answer);
		        
		        if (success) {
		            response.sendRedirect("login.html");
		        } else {
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>alert('회원가입 실패'); history.back();</script>");
		            out.close();
		        }
		    } catch (SQLIntegrityConstraintViolationException e) {
		        response.setContentType("text/html;charset=UTF-8");
		        PrintWriter out = response.getWriter();
		        out.println("<script>alert('이미 존재하는 이메일입니다.'); history.back();</script>");
		        out.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		        response.setContentType("text/html;charset=UTF-8");
		        PrintWriter out = response.getWriter();
		        out.println("<script>alert('시스템 오류가 발생했습니다'); history.back();</script>");
		        out.close();
		    }
		}
		
		else if (command.equals("findEmail")) {
		    String name = request.getParameter("name");
		    String phoneNumber = request.getParameter("phone_number");
		    
		    try {
		        String email = UserDAO.findEmail(name, phoneNumber);
		        if (email != null) {
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>");
		            out.println("alert('찾으시는 이메일은 " + email + " 입니다.');");
		            out.println("location.href='login.html';");
		            out.println("</script>");
		        } else {
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>");
		            out.println("alert('일치하는 정보가 없습니다.');");
		            out.println("history.back();");
		            out.println("</script>");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}
		
		else if (command.equals("findPassword")) {
		    String email = request.getParameter("email");
		    String name = request.getParameter("name");
		    String phoneNumber = request.getParameter("phone_number");
		    
		    try {
		        if (UserDAO.verifyUser(email, name, phoneNumber)) {
		            // 비밀번호 재설정 페이지로 이동
		            HttpSession session = request.getSession();
		            session.setAttribute("resetEmail", email);
		            response.sendRedirect("resetpassword.jsp");
		        } else {
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>");
		            out.println("alert('일치하는 정보가 없습니다.');");
		            out.println("history.back();");
		            out.println("</script>");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}
		
		else if (command.equals("resetPassword")) {
		    String email = request.getParameter("email");
		    String newPassword = request.getParameter("password");
		    
		    try {
		        boolean updated = UserDAO.updatePassword(email, newPassword);
		        if (updated) {
		        	HttpSession session = request.getSession();
		            // 세션의 resetEmail 속성 제거
		        	session.removeAttribute("resetEmail");
		            
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>");
		            out.println("alert('비밀번호가 성공적으로 변경되었습니다.');");
		            out.println("location.href='login.html';");
		            out.println("</script>");
		        } else {
		            response.setContentType("text/html;charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>");
		            out.println("alert('비밀번호 변경에 실패했습니다.');");
		            out.println("history.back();");
		            out.println("</script>");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}
		
		else if (command.equals("searchpw")) {// 비밀번호 찾기
			response.sendRedirect("searchpw.jsp");// r
		}
		
	}

}

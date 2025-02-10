package controller;
import jakarta.servlet.ServletException; 
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import board.BoardDAO;

@WebServlet("/board")
public class BoardController extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    
        request.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지
        String email = request.getParameter("email");  // 로그인한 사용자 이메일
        String category = request.getParameter("category"); 
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        // BoardDAO 객체 생성 및 insertPost 호출
        BoardDAO dao = new BoardDAO();
        System.out.println("cont");
        try {
			dao.addPost(email, category, title, content);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
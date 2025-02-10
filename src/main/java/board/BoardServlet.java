package board;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import board.Board;
import board.BoardDAO;

@WebServlet("/BoardServlet")
public class BoardServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        		
        String category = request.getParameter("category");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Board post = new Board(title, content, "익명");
        BoardDAO dao = new BoardDAO();
        
        if ("delete".equals(request.getParameter("action"))) {
            boolean result = false;

            try {
                if ("qna".equals(request.getParameter("type"))) {
                    result = dao.deleteQnaPost(category, title);
                } else {
                    result = dao.deletePost(category, title);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (result) {
            	System.out.println(result);
                response.sendRedirect(request.getHeader("Referer")); // 삭제 후 현재 페이지 유지
            } else {
                
            }
        }
       
        if ("add".equals(request.getParameter("action"))) {
        	
        	if (category == null || title == null || content == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            if ("qna".equals(request.getParameter("type"))) {
                try {
    				dao.addQnaPost(email, category, title, content);
    			} catch (Exception e) {
    				e.printStackTrace();
    			}
                response.sendRedirect("qna.jsp?category=" + category);
            } else {
                try {
    				dao.addPost(email, category, title, content);
    			} catch (Exception e) {
    				e.printStackTrace();
    			}
                response.sendRedirect("board.jsp?category=" + category);
            }
        }
        
        
    }
}
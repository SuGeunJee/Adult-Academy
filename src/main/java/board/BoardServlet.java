package board;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import board.Board;
import board.BoardDAO;

@WebServlet("/BoardServlet") // <= 여기 확인!
public class BoardServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String category = request.getParameter("category");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        if (category == null || title == null || content == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        Board post = new Board(title, content, "익명");
        BoardDAO dao = new BoardDAO();

        if ("qna".equals(request.getParameter("type"))) {
            dao.addQnaPost(category, post);
            response.sendRedirect("qna.jsp?category=" + category);
        } else {
            dao.addPost(category, post);
            response.sendRedirect("board.jsp?category=" + category);
        }
    }
}
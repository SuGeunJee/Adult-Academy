<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, board.Board, board.BoardDAO"%>

<%
	//세션에서 이메일 정보 가져오기
	String userEmail = (String) session.getAttribute("email");
	
	//로그인 상태가 아니면 로그인 페이지로 리다이렉트
	if (userEmail == null) {
	     response.setContentType("text/html;charset=UTF-8");
	     out.println("<script>");
	     out.println("alert('로그인이 필요한 서비스입니다.');");
	     out.println("location.href='login.html';");
	     out.println("</script>");
	     return;
	 }

    BoardDAO dao = new BoardDAO();
    String category = request.getParameter("category");
    if (category == null) category = "youtube";
    
    List<Board> qnaPosts = dao.getQnaPosts(category);
    
    // 페이지네이션 관련 변수
    int pageSize = 5;
    int pageNum = 1;
    if (request.getParameter("page") != null) {
        pageNum = Integer.parseInt(request.getParameter("page"));
    }
    int start = (pageNum - 1) * pageSize;
    int end = Math.min(start + pageSize, qnaPosts.size());
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📌 Q&A 게시판</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-teal.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .header {
            background-color: #00796B;
            color: white;
            padding: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        .menu {
            display: flex;
            justify-content: center;
            background: #ffffff;
            padding: 15px 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .menu a {
            color: #333;
            text-decoration: none;
            font-size: 18px;
            padding: 10px 20px;
            margin: 0 10px;
            font-weight: bold;
        }

        .menu a:hover {
            color: #00796B;
            border-bottom: 2px solid #00796B;
        }

        .container {
            width: 80%;
            margin: 30px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .post {
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        .post h3 {
            margin: 10px 0;
            font-size: 22px;
            color: #00796B;
        }

        .post-content {
            font-size: 16px;
            color: #555;
            white-space: pre-wrap; /* 줄바꿈 유지 */
            word-break: break-word; /* 긴 단어 줄바꿈 */
            text-align: left;
            background: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            margin: 10px 0;
        }

        .form-container {
            margin: 20px 0;
            padding: 25px;
            background: #f1f8fc;
            border-radius: 10px;
        }

        .form-container input, .form-container textarea {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .form-container button {
            background-color: #00796B;
            color: white;
            border: none;
            padding: 12px 20px;
            cursor: pointer;
            border-radius: 6px;
            font-size: 16px;
            transition: 0.3s;
        }

        .form-container button:hover {
            background-color: #005f56;
        }

        .footer {
            background: #00796B;
            color: white;
            padding: 15px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="header">📌 Q&A 게시판</div>

    <div class="menu">
        <a href="index.jsp">홈</a>
    </div>

    <div class="container">
        <h2 style="color: #00796B; font-size: 26px; font-weight: bold; margin-bottom: 20px; border-bottom: 2px solid #00796B; display: inline-block; padding-bottom: 5px;">
            Q&A💡 
        </h2>

        <div class="form-container">
            <form action="board" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="type" value="qna">
                <input type="hidden" name="category" value="<%=category%>">
                <input type="text" name="title" placeholder="질문 제목" required>
                <textarea name="content" placeholder="질문 내용을 입력하세요" required></textarea>
                <button type="submit">질문 등록</button>
            </form>
        </div>

        <!-- 질문 목록 -->
        <div class="content">
            <h2>질문 목록</h2>
            <% for (int i = start; i < end; i++) { Board post = qnaPosts.get(i); %>
                <div class="post">
                    <h3>📝제목 :<%= post.getTitle() %> 
                    <br>
                    (<small>✍ 작성자: <%= post.getAuthor() %></small>)</h3>
                    <p class="post-content"><%= post.getContent().replace("\n", "<br>") %></p>
                    <form action="board" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="title" value="<%= post.getTitle() %>">
                        <input type="hidden" name="category" value="<%= category %>">
                        <input type="hidden" name="type" value="qna">
                        <button type="submit" style="background-color: red; color: white; border: none; padding: 5px 10px; border-radius: 5px;">삭제</button>
                    </form>
                </div>
            <% } %>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <% if (pageNum > 1) { %>
                    <a href="qna.jsp?category=<%= category %>&page=<%= pageNum - 1 %>">이전</a>
                <% } %>
                <% if (end < qnaPosts.size()) { %>
                    <a href="qna.jsp?category=<%= category %>&page=<%= pageNum + 1 %>">다음</a>
                <% } %>
            </div>
            <style>
    .pagination {
        margin-top: 20px;
        display: flex;
        justify-content: center;
        gap: 10px;
    }

    .pagination-btn {
        padding: 12px 20px;
        background: #00796B;
        color: white;
        text-decoration: none;
        font-weight: bold;
        border-radius: 8px;
        transition: 0.3s;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    }

    .pagination-btn:hover {
        background: #005F56;
        box-shadow: 0 6px 10px rgba(0, 0, 0, 0.3);
    }
</style>
        </div>
    </div>

    <div class="footer">
        유익한 답변을 주신 분께는 소정의 상품이 제공됩니다!
    </div>
</body>
</html>
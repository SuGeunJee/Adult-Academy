<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="board.Board, board.BoardDAO"%>

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

    // 카테고리 확인
    String category = request.getParameter("category");
    if (category == null) category = "youtube"; // 기본값

    // 게시글 목록 가져오기
    BoardDAO dao = new BoardDAO();
    List<Board> posts = dao.getPosts(category);

    // 페이지네이션 설정
    int pageSize = 5;
    int pageNum = 1;
    if (request.getParameter("page") != null) {
        pageNum = Integer.parseInt(request.getParameter("page"));
    }
    int start = (pageNum - 1) * pageSize;
    int end = Math.min(start + pageSize, posts.size());
%>

<!DOCTYPE html>    
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title><%= category.equals("friendship") ? "친목 게시판" : category + " 게시판" %></title>
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
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .post {
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }
        .post h3 {
            margin: 10px 0;
            font-size: 20px;
            color: #00796B;
        }
        .post-content {
            font-size: 16px;
            color: #333;
            white-space: pre-wrap;
            word-break: break-word;
            text-align: left;
            background: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            margin: 10px 0;
        }
        .form-container {
            margin: 20px 0;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 8px;
        }
        .form-container input, .form-container textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-container button {
            background-color: #00796B;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
        }
        .form-container button:hover {
            background-color: #005F56;
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
    <div class="header"><%= category.equals("friendship") ? "👥 친목 게시판" : category + " 게시판" %></div>
    
    <div class="menu">
        <a href="index.jsp">🏠 홈</a>
    </div>

    <div class="container">
        <h2 style="color: #00796B; font-size: 26px; font-weight: bold; margin-bottom: 20px; border-bottom: 2px solid #00796B; display: inline-block; padding-bottom: 5px;">
            게시판 - <%= category %>
        </h2>

        <div class="form-container">
            <form action="board" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="category" value="<%= category %>">
                <input type="text" name="title" placeholder="제목" required>
                <textarea name="content" placeholder="내용" rows="5" required></textarea>
                <button type="submit">글 작성</button>
            </form>
        </div>

        <h2>📜 게시글 목록</h2>
        <% for (int i = start; i < end; i++) {
            Board post = posts.get(i);
        %>
        <div class="post">
            <h3>📝제목 : <%= post.getTitle() %>
            <br>
           (<small>✍ 작성자: <%= post.getAuthor() %></small>)</h3>
            <p class="post-content"><%= post.getContent().replace("\n", "<br>") %></p>
            <form action="board" method="post" style="display: inline;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="title" value="<%= post.getTitle() %>">
                <input type="hidden" name="category" value="<%= category %>">
                <button type="submit" style="background: red; color: white; border: none; padding: 5px 10px; cursor: pointer;">삭제</button>
            </form>
        </div>
        <% } %>
    </div>

    <div class="footer">
        🎁 이 달의 꿀팁으로 선정된 분에게는 **100만원** 🎉
    </div>
</body>
</html>

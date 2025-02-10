<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List,board.Board,board.BoardDAO" %>

<%
    // Q&A 게시글 가져오기
    BoardDAO dao = new BoardDAO();
    String category = request.getParameter("category");
    if (category == null) category = "youtube"; // 기본 카테고리 설정

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
<html>
<head>
<meta charset="UTF-8">
<title>📌 Q&A 게시판</title>
<style>
body {
	font-family: Arial, sans-serif;
	text-align: center;
}

.content {
	width: 60%;
	margin: auto;
}

.post-item {
	border-bottom: 1px solid #ccc;
	padding: 10px 0;
}

textarea, select, input {
	width: 90%;
	margin-top: 10px;
}

.category-menu {
	display: flex;
	justify-content: center;
	gap: 15px;
	margin-bottom: 20px;
}

.category-menu a {
	padding: 10px 15px;
	border: 1px solid #000;
	text-decoration: none;
	font-size: 16px;
}
</style>
</head>
<body>
	<h1>📌 Q&A 게시판</h1>
	<a href="index.jsp">홈으로</a>

	<!-- 카테고리 선택 -->
	<div class="category-menu">
		<a href="qna.jsp?category=youtube">유튜브</a>
		<a href="qna.jsp?category=kakao">카카오톡</a>
		<a href="qna.jsp?category=coupang">쿠팡</a>
		<a href="qna.jsp?category=daangn">당근마켓</a>
	</div>

	<!-- 질문 작성 -->
	<form action="board" method="post">
	    <input type="hidden" name="action" value="add">
		<input type="hidden" name="type" value="qna"> <!-- Q&A 글임을 표시 -->
		<input type="hidden" name="category" value="<%= category %>">
		<select name="category">
			<option value="youtube" <%= category.equals("youtube") ? "selected" : "" %>>유튜브</option>
			<option value="kakao" <%= category.equals("kakao") ? "selected" : "" %>>카카오톡</option>
			<option value="coupang" <%= category.equals("coupang") ? "selected" : "" %>>쿠팡</option>
			<option value="daangn" <%= category.equals("daangn") ? "selected" : "" %>>당근마켓</option>
		</select>
		<input type="text" name="title" placeholder="질문 제목" required><br>
		<textarea name="content" placeholder="질문 내용을 입력하세요" required></textarea>
		<br>
		<button type="submit">질문 등록</button>
	</form>

	<!-- 질문 목록 -->
	<div class="content">
		<h2>
			질문 목록 (<%=category%>)
		</h2>
		<%
		for (int i = start; i < end; i++) {
			Board post = qnaPosts.get(i);
		%>
		<div class="post-item">
			<strong><%=post.getTitle()%></strong> (작성자:<%=post.getAuthor()%>)
			<p><%=post.getContent()%></p>
			<form action="board" method="post" style="display: inline;">
				<input type="hidden" name="action" value="delete">
				<input type="hidden" name="title" value="<%=post.getTitle()%>">
				<input type="hidden" name="category" value="<%=category%>">
				<input type="hidden" name="type" value="qna">
				<button type="submit">삭제</button>
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
	</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="board.Board,board.BoardDAO"%>


<%
// 카테고리 확인
String category = request.getParameter("category");
if (category == null)
	category = "youtube"; // 기본값

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
<html>
<head>
<meta charset="UTF-8">
<title><%=category.equals("friendship") ? "친목 게시판" : category + " 게시판"%></title>
<style>
body {
	font-family: Arial, sans-serif;
	text-align: center;
}

.content {
	width: 50%;
	margin: auto;
}

.post-item {
	border-bottom: 1px solid #ccc;
	padding: 10px 0;
}

textarea {
	width: 90%;
	height: 80px;
	margin-top: 10px;
}
</style>
</head>
<body>
	<h1><%=category.equals("friendship") ? "👥 친목 게시판" : category + " 게시판"%></h1>
	<a href="index.jsp">홈으로</a>

	<form action="board" method="post">
		<input type="hidden" name="action" value="add">
		<input type="hidden" name="category" value="<%=category%>">
		<input type="text" name="title" placeholder="제목" required><br>
		<textarea name="content" placeholder="내용" required></textarea>
		<br>
		<button type="submit">글 작성</button>
	</form>

	<div class="content">
		<h2>게시글 목록</h2>
		<%
		for (int i = start; i < end; i++) {
			Board post = posts.get(i);
		%>
		<div class="post-item">
			<strong><%=post.getTitle()%></strong> (작성자:<%=post.getAuthor()%>)
			<p><%=post.getContent()%></p>
			<form action="board" method="post" style="display: inline;">
				<input type="hidden" name="action" value="delete">
				<input type="hidden" name="title" value="<%=post.getTitle()%>">
				<input type="hidden" name="category" value="<%=category%>">
				<button type="submit">삭제</button>
			</form>
		</div>
		<%
		}
		%>

		<div class="pagination">
			<%
			if (pageNum > 1) {
			%>
			<a href="board.jsp?category=<%=category%>&page=<%=pageNum - 1%>">이전</a>
			<%
			}
			%>
			<%
			if (end < posts.size()) {
			%>
			<a href="board.jsp?category=<%=category%>&page=<%=pageNum + 1%>">다음</a>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>
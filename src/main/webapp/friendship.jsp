<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="board.Board,board.BoardDAO"%>

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

// DB에서 친목 게시판 게시글 가져오기
BoardDAO dao = new BoardDAO();
List<Board> posts = dao.getPosts("friendship");

// 페이지네이션 관련 변수
int pageSize = 5; // 한 페이지에 보여줄 게시글 수
int pageNum = 1; // 기본 페이지 번호

// 페이지 파라미터가 있으면 읽어오기
if (request.getParameter("page") != null) {
	pageNum = Integer.parseInt(request.getParameter("page"));
}

// 게시글 목록에서 보여줄 범위 설정
int start = (pageNum - 1) * pageSize;
int end = Math.min(start + pageSize, posts.size());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>👥 친목 게시판</title>
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
	<h1>👥 친목 게시판</h1>
	<a href="index.jsp">홈으로</a>

	<!-- 게시글 작성 -->
	<form action="board" method="post">
		<input type="hidden" name="category" value="friendship"> <input
			type="text" name="title" placeholder="제목" required><br>
		<textarea name="content" placeholder="내용을 입력하세요" required></textarea>
		<br>
		<button type="submit">글 작성</button>
	</form>

	<!-- 게시글 목록 -->
	<div class="content">
		<h2>대화 목록</h2>
		<%
		for (int i = start; i < end; i++) {
			Board post = posts.get(i);
		%>
		<div class="post-item">
			<h3>✍️제목 : <%= post.getAuthor() %>
            <br>
             (작성자 : <%= post.getContent() %>)</h3>
			<p><%=post.getContent()%></p>
			<!-- 댓글 작성 폼 -->
			<form action="CommentServlet" method="post">
				<input type="hidden" name="postId" value="<%=i%>"> <input
					type="hidden" name="category" value="friendship">
				<textarea name="comment" placeholder="댓글을 입력하세요" required></textarea>
				<button type="submit">댓글 작성</button>
			</form>
		</div>
		<%
		}
		%>

		<!-- 페이지네이션 -->
		<div class="pagination">
			<%
			if (pageNum > 1) {
			%>
			<a href="friendship.jsp?page=<%=pageNum - 1%>">이전</a>
			<%
			}
			%>
			<%
			if (end < posts.size()) {
			%>
			<a href="friendship.jsp?page=<%=pageNum + 1%>">다음</a>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>
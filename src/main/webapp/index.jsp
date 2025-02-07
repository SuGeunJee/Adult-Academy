<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생활 꿀팁 & 친목 게시판</title>
<style>
body {
	font-family: Arial, sans-serif;
	text-align: center;
}

.menu {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 50px;
}

.menu a {
	padding: 10px 20px;
	font-size: 16px;
	text-decoration: none;
	border: 1px solid #000;
}

.menu a:hover {
	background-color: #ddd;
}
</style>
</head>
<body>
	<h1>생활 꿀팁 & 친목 게시판</h1>
	<div class="menu">
		<a href="board.jsp?category=youtube">유튜브</a> 
		<a href="board.jsp?category=coupang">쿠팡</a> 
		<a href="board.jsp?category=daangn">당근마켓</a> 
		<a href="board.jsp?category=kakao">카카오톡</a>
		<a href="board.jsp?category=friendship">👥 친목 게시판</a>
		<a href="qna.jsp">❓ Q&A</a> <!-- Q&A 페이지 추가 -->
	</div>
</body>
</html>

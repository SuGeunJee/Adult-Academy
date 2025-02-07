<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <style>
        .container {
            width: 300px;
            margin: 50px auto;
            text-align: center;
        }
        input {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>비밀번호 찾기</h2>
        <form action="login" method="POST">
            <input type="hidden" name="command" value="findPassword">
            <input type="email" name="email" placeholder="이메일" required>
            <input type="text" name="name" placeholder="이름" required>
            <input type="tel" name="phone_number" placeholder="전화번호 (010-1234-5678)" required>
            <button type="submit">다음</button>
        </form>
        <p><a href="login.html">로그인으로 돌아가기</a></p>
    </div>
</body>
</html>
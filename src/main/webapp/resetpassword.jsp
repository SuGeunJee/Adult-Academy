<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정</title>
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
	.error-message {
	    color: #f44336;
	    font-size: 12px;
	    margin-top: -5px;
	    margin-bottom: 5px;
	    text-align: left;
	    display: none;
	}
	</style>
</head>
<body>
    <div class="container">
        <h2>비밀번호 재설정</h2>
        <%
        String resetEmail = (String) session.getAttribute("resetEmail");
        if(resetEmail == null) {
            response.sendRedirect("login.html");
            return;
        }
        %>
        <form action="login" method="POST" onsubmit="return validateForm()">
            <input type="hidden" name="command" value="resetPassword">
            <input type="hidden" name="email" value="<%= resetEmail %>">
            
            <input type="password" id="password" name="password" placeholder="새 비밀번호" required>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="새 비밀번호 확인" required>
            <div id="passwordError" class="error-message">비밀번호가 일치하지 않습니다.</div>
            
            <button type="submit">비밀번호 변경</button>
        </form>
        <p><a href="login.html">로그인으로 돌아가기</a></p>
    </div>

    <script>
    function validateForm() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const errorElement = document.getElementById('passwordError');
        
        if(password !== confirmPassword) {
            errorElement.style.display = 'block';
            return false;
        }
        errorElement.style.display = 'none';
        return true;
    }
    </script>
</body>
</html>
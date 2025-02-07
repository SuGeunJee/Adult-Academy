<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
    }

    .container {
        width: 320px;
        margin: 0 auto;
        text-align: center;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }

    input {
        width: 100%;
        padding: 10px;
        margin: 8px 0;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .button-container {
        display: flex;
        justify-content: space-between;
    }

    button {
        width: 48%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button[type="submit"] {
        background-color: #4CAF50;
        color: white;
    }

    button[type="button"] {
        background-color: #f44336;
        color: white;
    }

    .question-container {
        text-align: left;
        margin: 15px 0;
    }

    .question-container p {
        font-weight: bold;
        margin-bottom: 8px;
    }

    .question-box {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .question-box label {
        display: flex;
        align-items: center;
        background-color: #f9f9f9;
        padding: 10px;
        border-radius: 5px;
        cursor: pointer;
        transition: all 0.3s ease;
        border: 1px solid #ddd;
    }

    .question-box label:hover {
        background-color: #e6f7ff;
    }

    .question-box input {
        display: none;
    }

    .question-box input:checked + label {
        background-color: #4CAF50;
        color: white;
        border-color: #4CAF50;
    }

    .question-box label::before {
        content: "✔";
        display: inline-block;
        width: 20px;
        height: 20px;
        margin-right: 10px;
        text-align: center;
        line-height: 20px;
        border: 1px solid #4CAF50;
        border-radius: 50%;
        color: transparent;
        transition: all 0.2s;
    }
    
	/* 질문 선택 UI */
    .question-box input:checked + label::before {
        background-color: white;
        color: #4CAF50;
    }

    /* 이메일 에러 메시지를 위한 스타일 */
    #emailError {
        color: #f44336;
        font-size: 12px;
        margin-top: -5px;
        margin-bottom: 5px;
        text-align: left;
        display: none;
    }
    
    #phoneError {
    color: #f44336;
    font-size: 12px;
    margin-top: -5px;
    margin-bottom: 5px;
    text-align: left;
    display: none;
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
    <h2>회원가입</h2>
    <form method="post" action="login" onsubmit="return validateForm()">
        <input type="hidden" name="command" value="registerUser">
        <input type="email" name="email" id="email" placeholder="이메일 주소" required>
        <div id="emailError">올바른 이메일 형식이 아닙니다.</div>
        
        <input type="text" name="name" placeholder="이름" required>
        
        <input type="tel" name="phone_number" id="phone" placeholder="전화번호 (예: 010-1234-5678)" required>
        <div id="phoneError">올바른 전화번호 형식이 아닙니다.</div>
		
		<input type="password" name="pw" id="password" placeholder="비밀번호" required>
		<input type="password" id="confirmPassword" placeholder="비밀번호 확인" required>
		<div id="passwordError" class="error-message">비밀번호가 일치하지 않습니다.</div>
		
        <div class="question-container">
            <p>비밀번호 찾기 질문을 선택하세요:</p>
            <div class="question-box">
                <input type="radio" id="q1" name="pw_question" value="좋아하는 색은?" required>
                <label for="q1">좋아하는 색은?</label>

                <input type="radio" id="q2" name="pw_question" value="어릴 적 별명은?" required>
                <label for="q2">어릴 적 별명은?</label>

                <input type="radio" id="q3" name="pw_question" value="첫 반려동물의 이름은?" required>
                <label for="q3">첫 반려동물의 이름은?</label>
            </div>
            <input type="text" name="pw_answer" placeholder="비밀번호 찾기 답변" required>
        </div>

        <div class="button-container">
            <button type="submit">가입하기</button>
            <button type="button" onclick="goBack()">취소</button>
        </div>
    </form>
</div>

<script>
	function validateForm() {
	    const email = document.getElementById('email').value;
	    const emailError = document.getElementById('emailError');
	    const phone = document.getElementById('phone').value;
	    const phoneError = document.getElementById('phoneError');
	    const password = document.getElementById('password').value;
	    const confirmPassword = document.getElementById('confirmPassword').value;
	    const passwordError = document.getElementById('passwordError');
	    
	    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	    const phoneRegex = /^010-[0-9]{3,4}-[0-9]{4}$/;
	    
	    let isValid = true;
	    
	    if (!emailRegex.test(email)) {
	        emailError.style.display = 'block';
	        isValid = false;
	    } else {
	        emailError.style.display = 'none';
	    }
	    
	    if (!phoneRegex.test(phone)) {
	        phoneError.style.display = 'block';
	        isValid = false;
	    } else {
	        phoneError.style.display = 'none';
	    }
	    
	    if(password !== confirmPassword) {
	        passwordError.style.display = 'block';
	        isValid = false;
	    } else {
	        passwordError.style.display = 'none';
	    }
	    
	    return isValid;
	}

    function goBack() {
        history.back();
    }
</script>

</body>
</html>
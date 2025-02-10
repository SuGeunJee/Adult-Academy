<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>어른스쿨🎓</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-teal.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { font-family: "Roboto", sans-serif; }
        .w3-bar-block .w3-bar-item { padding: 16px; font-weight: bold; }
        .right-sidebar {
            position: fixed;
            top: 50px;
            right: 20px;
            width: 480px;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            text-align: center;
        }
        .time-container {
            font-size: 20px;
            font-weight: bold;
            color: #00796B;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 25px;
        }
        .calendar-container {
            background-color: #ffffff;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }
        .calendar-container iframe {
            width: 100%;
            height: 400px;
            border-radius: 12px;
            border: none;
        }
        .calendar-container h4 {
            font-size: 15px;
            font-weight: bold;
            color: #00796B;
            margin-bottom: 20px;
        }
         .weather-container {
            display: flex;
            justify-content: flex-start;
            margin-top: 40px; /* 추가된 부분: 아래로 조정 */  
        }
    </style>
    <script>
        function updateClock() {
            var now = new Date();
            var year = now.getFullYear();
            var month = now.getMonth() + 1;
            var date = now.getDate();
            var hours = now.getHours();
            var minutes = now.getMinutes();
            var seconds = now.getSeconds();
            var timeString = year + "년 " + month + "월 " + date + "일 " + hours + "시 " + minutes + "분 " + seconds + "초";
            document.getElementById("currentTime").innerText = timeString;
        }
        setInterval(updateClock, 1000);
    </script>
</head>
<body onload="updateClock()">

<nav class="w3-sidebar w3-bar-block w3-collapse w3-animate-left w3-card" style="z-index:3;width:250px;" id="mySidebar">
    <a class="w3-bar-item w3-button w3-border-bottom w3-large" style="display: flex; align-items: center; gap: 10px;">어른스쿨</a>
    <a class="w3-bar-item w3-button w3-teal" href="index.jsp">🏠 홈</a>
    <a class="w3-bar-item w3-button" href="board.jsp?category=youtube">📺 유튜브</a>
    <a class="w3-bar-item w3-button" href="board.jsp?category=coupang">🛒 쿠팡</a>
    <a class="w3-bar-item w3-button" href="board.jsp?category=daangn">🥕 당근마켓</a>
    <a class="w3-bar-item w3-button" href="board.jsp?category=kakao">💬 카카오톡</a>
    <a class="w3-bar-item w3-button" href="board.jsp?category=friendship">🤝 친목 게시판</a>
    <a class="w3-bar-item w3-button" href="qna.jsp">❓ Q&A</a>
</nav>

<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" id="myOverlay"></div>

<div class="w3-main" style="margin-left:250px;">
    <header class="w3-container w3-theme" style="padding:64px 32px ">
        <h1 class="w3-xxxlarge">스마트폰 모르면, 어른스쿨</h1>
    </header>
 	<div class="weather-container">
        <div class="info-box">
            <h3>🌤️ 오늘의 날씨</h3>
            <div id="ww_704c0191edf1f" v='1.3' loc='id' a='{"t":"horizontal","lang":"ko","sl_lpl":1,"ids":[],"font":"Times","sl_ics":"one_a","sl_sot":"celsius","cl_bkg":"#00796B","cl_font":"#FFFFFF","cl_cloud":"#FFFFFF","cl_persp":"#FFFFFF","cl_sun":"#FFC107","cl_moon":"#FFC107","cl_thund":"#FF5722"}'>More forecasts: <a href="https://oneweather.org/seoul/30_days/" id="ww_704c0191edf1f_u" target="_blank">Weather Seoul 30 days</a></div>
            <script async src="https://app3.weatherwidget.org/js/?id=ww_704c0191edf1f"></script>
        </div>

</div>

<!-- 오른쪽 사이드바 -->
<div class="right-sidebar">
    <h4>⏰ 현재 시간</h4>
    <div id="currentTime" class="time-container"></div>
    <div class="calendar-container">
        <h4>📅 달력</h4>
        <iframe src="https://calendar.google.com/calendar/embed?src=ko.south_korea%23holiday%40group.v.calendar.google.com&ctz=Asia%2FSeoul"></iframe>
    </div>
</div>

<script>
    function w3_open() {
        document.getElementById("mySidebar").style.display = "block";
        document.getElementById("myOverlay").style.display = "block";
    }
    function w3_close() {
        document.getElementById("mySidebar").style.display = "none";
        document.getElementById("myOverlay").style.display = "none";
    }
</script>

</body>
</html>

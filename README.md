# Adult-Academy💡
> 50~60대들이 잘 모르는 생활 어플 꿀팁 공유 및 커뮤니티 웹 플랫폼

## 📑 Table of Contents
1. [Project Overview](#-project-overview)
2. [Team Members](#-team-members)
3. [Features](#-features)
4. [Tech Stack](#-tech-stack)
5. [Project Structure](#-project-structure)
6. [Database Schema](#-database-schema)
7. [System Architecture](#%EF%B8%8F-system-architecture)
8. [Troubleshooting](#-troubleshooting)
9. [Future plans](#-future-plans)
10. [Review](#%EF%B8%8F-review)

# 🎯 Project Overview
사용자들이 일상생활에서 유용한 팁을 공유하고 소통할 수 있는 웹 커뮤니티 플랫폼입니다. 유튜브, 쿠팡, 당근마켓, 카카오톡 등 다양한 플랫폼 활용 팁을 카테고리별로 공유하고 토론할 수 있습니다.

## 🤝 Team Members
| <img src="https://github.com/kcklkb.png" width="200px"> | <img src="https://github.com/SuGeunJee.png" width="200px"> | <img src="https://github.com/PleaseErwin.png" width="200px"> | <img src="https://github.com/unoYoon.png" width="200px"> |
| :---: | :---: | :---: | :---: |
| [김창규](https://github.com/kcklkb) | [지수근](https://github.com/SuGeunJee) | [서소원](https://github.com/PleaseErwin) | [윤원호](https://github.com/unoYoon) |

# ✨ Features
- **사용자 인증**
  - 이메일 세션 기반 회원가입/로그인
  - BCrypt를 활용한 안전한 비밀번호 암호화
  - 비밀번호 찾기/재설정 기능

- **카테고리별 게시판**
  - 유튜브 활용 팁
  - 쿠팡 쇼핑 팁
  - 당근마켓 거래 팁
  - 카카오톡 활용 팁
  - 친목 게시판
  - Q&A 게시판

- **게시판 기능**
  - 게시글 CRUD
  - 댓글 시스템
  - 페이지네이션
  - 카테고리별 필터링

# 🛠 Tech Stack

|  **분류**   |   **기술 스택**   |
|--------------|-------------|
| **언어**      | ![Java](https://img.shields.io/badge/Java%2017-007396?style=for-the-badge&logo=java&logoColor=white) ![Jakarta EE](https://img.shields.io/badge/Jakarta%20-D22128?style=for-the-badge&logo=jakarta&logoColor=white)        |
| **데이터베이스** | ![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)   |
| **보안**      | ![BCrypt](https://img.shields.io/badge/BCrypt-2A5BBB?style=for-the-badge&logo=lock&logoColor=white) ![Session Based Auth](https://img.shields.io/badge/Session%20Based%20Auth-000000?style=for-the-badge&logo=session&logoColor=white)                                                          |
| **빌드 도구**   | ![Maven](https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)                                                        |
| **개발 환경**   | ![STS](https://img.shields.io/badge/Spring%20Tool%20Suite-6DB33F?style=for-the-badge&logo=spring&logoColor=white) ![DBeaver](https://img.shields.io/badge/DBeaver-4D4D4D?style=for-the-badge&logo=dbeaver&logoColor=white) |
| **협업툴**     | ![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white) ![Notion](https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white) ![Slack](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white) ![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white) |
| **서버**  | ![Apache Tomcat](https://img.shields.io/badge/Apache%20Tomcat%2010.1-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black) |


# 📁 Project Structure
```plaintext
src/
├── main/
│   ├── java/
│   │   ├── board/
│   │   │   ├── Board.java
│   │   │   ├── BoardDAO.java
│   │   ├── controller/
│   │   │   └── UserController.java
│   │   │   └── BoardController.java
│   │   ├── model/
│   │   │   │   └── domain/
│   │   │   │   │    └── UserDTO.java
│   │   │   └── UserDAO.java
│   │   └── util/
│   │       └── DBUtil.java
│   └── webapp/
│       ├── board.jsp
│       ├── friendship.jsp
│       ├── index.jsp
│       ├── login.html
│       ├── qna.jsp
│       └── signup.jsp
│       └── findemail.jsp
│       └── findpassword.jsp
│       └── resetpassword.jsp
```

# 💾 Database Schema
<img width="461" alt="image" src="https://github.com/user-attachments/assets/77b11dbb-77dd-4fc1-9fbc-e9ddbbb4e9fe" />

## Users Table
| Column | Type | Description |
|--------|------|-------------|
| email | VARCHAR(50) | Primary Key |
| pw | VARCHAR(64) | BCrypt Hashed Password |
| name | VARCHAR(20) | User's Name |
| phone_number | VARCHAR(15) | Contact Number |
| grade | VARCHAR(10) | User Grade (admin/user) |
| pw_question | VARCHAR(100) | Password Recovery Question |
| pw_answer | VARCHAR(100) | Password Recovery Answer |

## Board Posts Table (board_posts)
| Column | Type | Description |
|--------|------|-------------|
| id | INT | Primary Key, Auto Increment |
| email | VARCHAR(50) | Foreign Key (user.email) |
| category | VARCHAR(50) | Post Category |
| title | VARCHAR(255) | Post Title |
| content | TEXT | Post Content |
| created_at | TIMESTAMP | Creation Time, Default CURRENT_TIMESTAMP |

## Q&A Posts Table (qna_posts)
| Column | Type | Description |
|--------|------|-------------|
| id | INT | Primary Key, Auto Increment |
| email | VARCHAR(50) | Foreign Key (user.email) |
| category | VARCHAR(50) | Question Category |
| title | VARCHAR(255) | Question Title |
| content | TEXT | Question Content |
| created_at | TIMESTAMP | Creation Time, Default CURRENT_TIMESTAMP |

## Relationships
- board_posts.email → user.email (CASCADE)
- qna_posts.email → user.email (CASCADE)

# 🏗️ System Architecture


# 👀 Run Screen


# ❗ Troubleshooting

## Issue 1 : /step04_reviewTest/login 경로로 서버가 실행되는 현상
### 🚨 문제 상황
프로젝트명이 Adult-Academy임에도 불구하고 서버가 계속 /step04_reviewTest/login 경로로 실행됨

### 🔍 문제 파악
Maven 설정(pom.xml)의 artifactId가 step04_reviewTest로 되어있음 <br>
실제 프로젝트 폴더명은 Adult-Academy <br> 
이로 인해 서버 배포 시 Context Path가 step04_reviewTest로 설정됨 <br>

하지만 artifactId를 Adult-Academy로 바꾸어 주고, 프로젝트를 재빌드하여도 상황이 해결되지 않음

### pom.xml
```
<!-- Before -->
<artifactId>step04_reviewTest</artifactId>

<!-- After -->
<artifactId>Adult-Academy</artifactId>

```
<img width="1149" alt="123123" src="https://github.com/user-attachments/assets/fc16e011-492d-4479-846c-8c8c838a42d7" />


### ✅ 해결 방법

1. Tomcat 서버의 작업 디렉토리 검사 <br>

- {workspace}\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\work\Catalina\localhost <br>
- 폴더에서 Tomcat의 work 디렉토리에 이전 Context Path 관련 캐시가 남아있는 것을 확인

<img width="526" alt="image" src="https://github.com/user-attachments/assets/6e1288eb-c663-4dde-b30a-8bdab8fc3bcc" /> <br><br>

2. 서버 설정 파일 확인 <br>

- {workspace}\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\conf\server.xml <br>
- 파일을 확인해보니, docBase가 step04_reviewTest로 되어 있는 것을 확인 <br>

```
<Context docBase="C:\01.lab\04.Web\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ROOT" path="" reloadable="false"/><Context docBase="C:\01.lab\04.Web\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\step04_reviewTest" path="/step04_reviewTest" reloadable="true" source="org.eclipse.jst.jee.server:step04_reviewTest">
```
<br>

3. 캐시 및 설정 초기화

- STS의 Servers 뷰에서 Tomcat 서버를 Clean Tomcat Work Directory 명령으로 작업 디렉토리를 정리한 후, 프로젝트를 빌드하면 정상적으로 실행됨을 확인할 수 있음

<img width="544" alt="스크린샷 2025-02-10 000707" src="https://github.com/user-attachments/assets/84d97a07-a94b-4e62-b675-692abb87e5e5" /> <br>

<img width="1159" alt="456456" src="https://github.com/user-attachments/assets/ee6c808b-d51c-4bc7-96bf-52aa0eda6a39" />

### 🎯 결과

- `http://localhost:8080/Adult-Academy/login.html`로 정상 접속
- 프로젝트의 Context Path 가 의도한 대로 변경됨

### 💡 학습 포인트

- Tomcat 서버는 컨텍스트 설정을 캐싱하여 관리함 <br>
- Maven 설정 변경 시 서버의 작업 디렉토리와 설정 파일도 함께 확인 필요 <br>
- 단순 재시작이 아닌 작업 디렉토리 정리가 필요한 경우가 있음 <br>
- Web Project Settings의 Context Root와 Maven의 artifactId 일치가 중요 <br>
- Context Path 변경 시 브라우저 캐시 삭제 필요할 수 있음 <br>

# 📈 Future plans

1. 현재 mysql db서버를 로컬에 설치해서 사용하는데 추후 db서버를 따로 추가할 계획임<br>

2. 유저의 등급을 나타내는 grade 컬럼을 만들기는 했지만 사용하지 않아 현재 
관리자와 일반 사용자 간에 차이가 없음. 관리자 게시글 제목에는 [공지]를 
추가한다거나 빨간 글씨로 보이게 하는 등 차별점을 두고, 게시글의 삭제에 대한 
권한에 차이를 둘 예정임<br>

3. 현재 유튜브, 쿠팡, 당근마켓, 카카오톡, 친목 게시판의 게시글 데이터가 전부 
한 테이블에 저장됨. 추후 데이터가 많아질 경우 카테고리별로 파티션을 
나누거나 샤딩으로 CRUD 성능을 높일 계획임<br>

4. qna 게시판에서 일반 사용자들이 쓴 각각의 질문 게시글에 관리자가 답변을
 달 수 있도록 할 예정임<br><br>


# ✍️ Review

>>>>>>> 80ba7972b94d62f46ddd1990ba2bae9fcede0251

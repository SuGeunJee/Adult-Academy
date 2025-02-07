# Adult-Academy💡
> 50~60대들이 잘 모르는 생활 어플 꿀팁 공유 및 커뮤니티 웹 플랫폼

## 📑 Table of Contents
1. [Project Overview](#-project-overview)
2. [Team Members](#-team-members)
3. [Features](#-features)
4. [Tech Stack](#-tech-stack)
5. [Project Structure](#-project-structure)
6. [Database Schema](#-database-schema)
7. [Troubleshooting](#-troubleshooting)

# 🎯 Project Overview
사용자들이 일상생활에서 유용한 팁을 공유하고 소통할 수 있는 웹 커뮤니티 플랫폼입니다. 유튜브, 쿠팡, 당근마켓, 카카오톡 등 다양한 플랫폼 활용 팁을 카테고리별로 공유하고 토론할 수 있습니다.

## 🤝 Team Members
| <img src="https://github.com/kcklkb.png" width="200px"> | <img src="https://github.com/SuGeunJee.png" width="200px"> | <img src="https://github.com/PleaseErwin.png" width="200px"> | <img src="https://github.com/unoYoon.png" width="200px"> |
| :---: | :---: | :---: | :---: |
| [김창규](https://github.com/kcklkb) | [지수근](https://github.com/SuGeunJee) | [서소원](https://github.com/PleaseErwin) | [윤원호](https://github.com/unoYoon) |

# ✨ Features
- **사용자 인증**
  - 이메일 기반 회원가입/로그인
  - BCrypt를 활용한 안전한 비밀번호 암호화
  - 비밀번호 찾기/재설정 기능

- **카테고리별 게시판**
  ![게시판 스크린샷](image_url)
  - 유튜브 활용 팁
  - 쿠팡 쇼핑 노하우
  - 당근마켓 거래 팁
  - 카카오톡 활용법
  - 친목 게시판
  - Q&A 게시판

- **게시판 기능**
  - 게시글 CRUD
  - 댓글 시스템
  - 페이지네이션
  - 카테고리별 필터링

# 🛠 Tech Stack

## Backend
![Java](https://img.shields.io/badge/Java%2021-007396?style=for-the-badge&logo=java&logoColor=white)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-D22128?style=for-the-badge&logo=jakarta&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

## Security
![BCrypt](https://img.shields.io/badge/BCrypt-2A5BBB?style=for-the-badge&logo=lock&logoColor=white)
![Session Based Auth](https://img.shields.io/badge/Session%20Based%20Auth-000000?style=for-the-badge&logo=session&logoColor=white)

## Development Tools
![Maven](https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)
![STS](https://img.shields.io/badge/Spring%20Tool%20Suite-6DB33F?style=for-the-badge&logo=spring&logoColor=white)
![DBeaver](https://img.shields.io/badge/DBeaver-4D4D4D?style=for-the-badge&logo=dbeaver&logoColor=white)

## Collaboration Tools
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
![Notion](https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white)

# 📁 Project Structure
```plaintext
src/
├── main/
│   ├── java/
│   │   ├── board/
│   │   │   ├── Board.java
│   │   │   ├── BoardDAO.java
│   │   │   └── BoardServlet.java
│   │   ├── controller/
│   │   │   └── UserController.java
│   │   ├── model/
│   │   │   └── UserDAO.java
│   │   └── util/
│   │       └── DBUtil.java
│   └── webapp/
│       ├── board.jsp
│       ├── friendship.jsp
│       ├── index.jsp
│       ├── login.html
│       ├── main.jsp
│       ├── qna.jsp
│       └── signup.jsp
```

# 💾 Database Schema
## Users Table
| Column | Type | Description |
|--------|------|-------------|
| email | VARCHAR(50) | Primary Key |
| pw | VARCHAR(100) | BCrypt Hashed Password |
| name | VARCHAR(20) | User's Name |
| phone_number | VARCHAR(15) | Contact Number |
| grade | VARCHAR(10) | User Grade (admin/user) |
| pw_question | VARCHAR(100) | Password Recovery Question |
| pw_answer | VARCHAR(100) | Password Recovery Answer |

# ❗ Troubleshooting

## Issue 1: Session Implementation
문제: 세션 기반 인증이 페이지 간 유지되지 않는 문제 발생
해결: UserController에서 세션 관리 로직을 개선하고 모든 보안이 필요한 페이지에 세션 체크 로직 추가

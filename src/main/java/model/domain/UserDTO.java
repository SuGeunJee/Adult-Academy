package model.domain;

public class UserDTO {
	String id;
    String pw;
    enum grade {
    	admin, user
    }
    String pw_question;
    String pw_answer;
}

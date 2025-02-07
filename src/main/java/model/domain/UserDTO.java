package model.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class UserDTO {
	String email;
    String pw;
    String name;
    String phone_number;
    enum grade {
    	admin, user
    }
    String pw_question;
    String pw_answer;
}

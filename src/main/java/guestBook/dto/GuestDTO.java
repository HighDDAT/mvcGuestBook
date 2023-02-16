package guestBook.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GuestDTO {

	private int guest_no;
	private String guest_name;
	private String guest_pw;
	private String guest_content;
	private Date append_date;
	
}

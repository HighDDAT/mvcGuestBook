package guestBook.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import guestBook.dto.GuestDTO;

public class GuestDAO {

	private DataSource ds;
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public GuestDAO() {
		
		try {
//			Context initCtx = (Context) new InitialContext();
//			ds = (DataSource) ((InitialContext) initCtx).lookup("java:comp/env/jdbc/maria");
			Context initCtx = new InitialContext();
			ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/maria");
			System.out.print("DBCP 연결 성공...");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 방명록 리스트
	public List<GuestDTO> selectAllBooks() {
		
		List<GuestDTO> guestList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select * from guest order by guest_no desc";
			
//			String sql = "SELECT"
//					+ " guest_no, guest_name, guest_pw, guest_content,"
//					+ " date_format(append_date, '%Y-%m-%d %H:%i:%S')"
//					+ " FROM guest";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				int guest_no = rs.getInt("guest_no");
				String guest_name = rs.getString("guest_name");
				String guest_pw = rs.getString("guest_pw");
				String guest_content = rs.getString("guest_content");
				Date append_date = rs.getDate("append_date");
				
				GuestDTO dto = new GuestDTO();
				
				dto.setGuest_no(guest_no);
				dto.setGuest_name(guest_name);
				dto.setGuest_pw(guest_pw);
				dto.setGuest_content(guest_content);
				dto.setAppend_date(append_date);
				
				guestList.add(dto);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return guestList;
	}
	
	// 방명록 작성
	public boolean insertBooks(GuestDTO dto) {
		
		boolean result = false;
		
		try {
			Connection conn = ds.getConnection();
			
//			int guest_no = dto.getGuest_no();
			String guest_name = dto.getGuest_name();
			String guest_pw = dto.getGuest_pw();
			String guest_content = dto.getGuest_content();
			
			String sql = "insert into guest "
					+ " (guest_name, guest_pw, guest_content) "
					+ " VALUES (?,?,?)";
			System.out.println(sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, guest_name);
			pstmt.setString(2, guest_pw);
			pstmt.setString(3, guest_content);
			
			int count = pstmt.executeUpdate();
			result = (count == 1);
			
			conn.close();
			pstmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 삭제 시 패스워드 받아오기
	
	// 방명록 삭제
	public void deleteBooks (int guest_no) {
		try {
			Connection conn = ds.getConnection();
			String sql = "DELETE FROM guest "
					+ " WHERE guest_no=?";
			System.out.println(sql);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, guest_no);
			pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}

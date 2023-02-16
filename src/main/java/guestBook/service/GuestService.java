package guestBook.service;

import java.util.List;

import guestBook.dao.GuestDAO;
import guestBook.dto.GuestDTO;

public class GuestService {

	GuestDAO guestDAO;
	
	public GuestService() {
		guestDAO = new GuestDAO();
	}
	
	public List<GuestDTO> listBooks() {
		
		List<GuestDTO> guestList = guestDAO.selectAllBooks();
		return guestList;
	}
	
	public void addBooks(GuestDTO dto) {
		guestDAO.insertBooks(dto);
	}
	
	public void removeBooks(int guest_no) {
		guestDAO.deleteBooks(guest_no);
	}
}

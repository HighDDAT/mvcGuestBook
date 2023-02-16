package guestBook.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import guestBook.dto.GuestDTO;
import guestBook.service.GuestService;

@WebServlet("/guest/*")
public class GuestController extends HttpServlet {
	
	GuestService guestService;
	GuestDTO guestDTO;
	
	public void init(ServletConfig config) throws ServletException {
		guestService = new GuestService();
		guestDTO = new GuestDTO();
	}
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandler(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandler(request, response);
	}
	
	protected void doHandler(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
		System.out.println("서블릿 연결 완료");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String action = request.getPathInfo();
		String nextPage = "";
		System.out.println("action: "+action);
		
		
		List<GuestDTO> guestList = new ArrayList<>();
		GuestDTO dto = new GuestDTO();
		
		nextPage = "/book/main.jsp";
		
		// 게시물 목록
		if (action.equals("/listGuest.do")) {
			
			System.out.println("게시물 목록");
			
			guestList = guestService.listBooks();
			request.setAttribute("", guestDTO);
			request.setAttribute("guestList", guestList);
			nextPage = "/book/listBooks.jsp";
		
			
		} else if (action.equals("/insertGuest.do")) {
			
			System.out.println("새 방명록 작성");
			String guest_name = request.getParameter("guest_name");
			String guest_pw = request.getParameter("guest_pw");
			String guest_content = request.getParameter("guest_content");
			
			
			
			dto.setGuest_name(guest_name);
			dto.setGuest_pw(guest_pw);
			dto.setGuest_content(guest_content);
			
			guestService.addBooks(dto);
			
			PrintWriter out = response.getWriter();
			out.print("<script>"
					+ " alert( '방명록 작성 완료');"
					+ " location.href ='"+request.getContextPath()+"/guest/listGuest.do';"
					+ "</script>");
			
			return;
			
			
			// nextPage = "/guest/listGuest.do";
			
	
		} else if (action.equals("/delGuest.do")) {
			System.out.println("방명록 삭제");
			
			int guest_no = Integer.parseInt(request.getParameter("guest_no"));
			
			guestService.removeBooks(guest_no);
			System.out.println("삭제할 방명록 번호 : "+guest_no);
			
			PrintWriter out = response.getWriter();
			out.print("<script>"
					+ " alert( '"+guest_no+"번 방명록을 삭제했습니다');"
					+ " location.href ='"+request.getContextPath()+"/guest/listGuest.do';"
					+ "</script>");
			
			return;
//			nextPage = "/guest/listGuest.do";
		
		
			
		} else if (action.equals("/guestTest.do")) {
			System.err.println("테스트 페이지");
			
			nextPage = "/book/test.jsp";
					
		} else {
			
		}
		
		System.out.println("포 워 딩");
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
		
	}
	

}

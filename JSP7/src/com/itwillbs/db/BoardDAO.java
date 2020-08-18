package com.itwillbs.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.itwillbs.board.BoardBean;

public class BoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	// DB 연결 (커넥션 풀) - DB 연결 정보를 미리 생성해서 pool에다가 저장하고, 
	// 					필요 시 사용/반납하는 형태로 처리
	private Connection getCon() throws Exception{
		
		// 1. 라이브러리 설치 (WEB-INF/lib/ 추가)
		// 2. /META-INF/context.xml 파일 생성(1,2단계 내용)
		// 3. /WEB-INF/web.xml 파일 수정
		// 4. DAO 처리
		
		// Context 객체 생성
		Context init = new InitialContext();
		
		// DB연동 정보를 불러오기(context.xml)
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysqlDB");
		
		
		return con = ds.getConnection();
		
	}
	// DB 연결 (커넥션 풀)
	
	// DB 자원해제
	
	public void closeDB(){
		
		try {
			if(rs != null) rs.close();
			if(pstmt !=null) pstmt.close();
			if(con != null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	// DB 자원해제
	
	// insertBoard(글정보)
	public void insertBoard(BoardBean board){
		int num = 0; // 글번호 저장
		try {
			// DB 연결
			getCon();
		// 3. SQL 작성 & pstmt
		// 글번호 계산
		sql = "select max(bno) from itwill_board ";
		pstmt = con.prepareStatement(sql);
		
		// 4. 실행
		rs = pstmt.executeQuery();
		
		// 5. 데이터 처리 (글번호 계산)
		if(rs.next()){
			// num = rs.getInt("max(bno)")+1;
			num = rs.getInt(1)+1; // -> 인덱스를 사용하여 데이터 검색속도 향상
			// getInt => 데이터 값을 리턴, 값이 SQL-NULL인 경우 0 리턴
		}
		
		System.out.println("글번호 : "+num);
		// 글쓰기(저장)
		// 3. sql(insert)
		sql="insert into itwill_board(bno,name,passwd,subject,content,readcount,re_ref,re_lev,re_seq,date,file,ip) "
			+"values(?,?,?,?,?,?,?,?,?,now(),?,?)"; // now() : SQL구문 실행 시 자동으로 시스템 시간정보를 불러옴
		pstmt = con.prepareStatement(sql);
		
		// 3-1. ?
		
		pstmt.setInt(1, num);
		pstmt.setString(2, board.getName());
		pstmt.setString(3, board.getPasswd());
		pstmt.setString(4, board.getSubject());
		pstmt.setString(5, board.getContent());
		pstmt.setInt(6, 0); // readcount 조회수 0 지정
		pstmt.setInt(7, num); // re_ref 답변글 그룹번호(일반 글 번호와 동일)
		pstmt.setInt(8, 0); // re_lev 답변글 들여쓰기(일반글 0)
		pstmt.setInt(9, 0); // re_seq 답변글 순서(일반글 제일 위쪽)
		pstmt.setString(10, board.getFile());
		pstmt.setString(11, board.getIp());
		
		// 4. 실행
		pstmt.executeUpdate();
		
		System.out.println("회원 글쓰기 완료");
		
		} catch (Exception e) {
			System.out.println("회원 글쓰기 오류");
			e.printStackTrace();
		}finally{
			// 자원해제
			closeDB();
		}
	}
	// insertBoard(글정보)
	
	// getBoardCount() : 게시판의 글 개수 리턴하는 메서드
	
	public int getBoardCount(){
		
		int count = 0;
		
		try {
			// DB연결 
			getCon();
			
			// sql & pstmt
			sql = "select count(*) from itwill_board";
			
			pstmt = con.prepareStatement(sql);
			
			// 실행 -> rs저장
			rs = pstmt.executeQuery();
			
			// 데이터 처리
			if(rs.next()){
				count = rs.getInt(1);
				// rs.getInt("count(*)");
			}
			System.out.println("게시판 글 개수 확인 : "+count);
			
		} catch (Exception e) {

			e.printStackTrace();
		}finally{
			// 자원해제
			closeDB();
			
		}
		
		return count;
	}
	
	// getBoardCount() : 게시판의 글 개수 리턴하는 메서드
	
	// getBoardList(): 게시판의 글을 모두 가져오는 메서드
	
	public ArrayList getBoardList(){
		ArrayList boardList = new ArrayList();
		try {
			// DB연결
			getCon();
			
			// SQL & pstmt
			// sql = "select * from itwill_board";
			
			// 정렬(최신글이 가장 위쪽으로 보이게)
			sql = "select * from itwill_board "
				+ "order by re_ref desc";

			pstmt = con.prepareStatement(sql);
			// 실행 -> rs저장
			rs = pstmt.executeQuery();
			
			// 데이터 처리 (검색된 모든 정보를 저장해서 이동)
			while(rs.next()){
				// 글정보 하나를 BoardBean 객체 하나에 저장
				BoardBean bb = new BoardBean();
				
				bb.setBno(rs.getInt("bno"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFile(rs.getString("file"));
				bb.setIp(rs.getString("ip"));
				bb.setName(rs.getString("name"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
				// 글 하나의 정보를 arrayList 한칸에 저장
				boardList.add(bb);
				
			}
			System.out.println("모든 글정보 저장 완료");
			System.out.println(boardList);
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}finally{
		// 자원해제
		closeDB();
		}
		return boardList;
	}
	
	
	// getBoardList(): 게시판의 글을 모두 가져오는 메서드
	
	// getBoardList(startRow, pageSize)
	public ArrayList getBoardList(int startRow, int pageSize){
		ArrayList boardList = new ArrayList();
		try {
			// DB연결
			getCon();
			
			// SQL & pstmt
			// 게시판 목록 중에서 10개씩 가져오기
			
			// 정렬 - re_ref(그룹번호) 내림차순, 
			// 		re_seq(답글순서) 오름차순
			
			// 데이터 잘라서 가져오기 limit 시작행-1, 개수
			// => 해당 위치부터 개수만큼 가져오기
			
			sql = "select * from itwill_board "
				+ "order by re_ref desc, re_seq asc "
				+ "limit ?,?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			// 실행 -> rs저장
			rs = pstmt.executeQuery();
			
			// 데이터 처리 (검색된 모든 정보를 저장해서 이동)
			while(rs.next()){
				// 글정보 하나를 BoardBean 객체 하나에 저장
				BoardBean bb = new BoardBean();
				
				bb.setBno(rs.getInt("bno"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFile(rs.getString("file"));
				bb.setIp(rs.getString("ip"));
				bb.setName(rs.getString("name"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
				// 글 하나의 정보를 arrayList 한칸에 저장
				boardList.add(bb);
				
			}
			System.out.println("모든 글정보 저장 완료");
			System.out.println(boardList);
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}finally{
		// 자원해제
		closeDB();
		}
		return boardList;
	
	}
	
	// getBoardList(startRow, pageSize)
	
	// updateReadCount(bno)
	public void updateReadCount(int bno){
		try {
			// DB연결
			getCon();
			// sql (해당 글 번호에 맞는 글에 조회수를 1증가)& pstmt
			sql = "update itwill_board "
				+ "set readcount = readcount+1 "
				+ "where bno = ?";
			pstmt =con.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			// 실행
			pstmt.executeUpdate();
			
			System.out.println("조회수 1증가 완료");
			
		} catch (Exception e) {
			System.out.println("조회수 1증가 에러");
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}
	// updateReadCount(bno)
	
	// getBoard(bno)
	
	public BoardBean getBoard(int bno){
		BoardBean bb = null;
		try {
			// DB연결
			getCon();
			// sql작성 & pstmt객체 생성
			// 글번호에 해당하는 모든 글의 정보를 가져오기(select)
			sql = "select * from itwill_board "
					+ "where bno = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			// 실행
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){ // 데이터가 있으면 실행
				// DB -> JSP 전달하기 위해서 BoardBean객체에 저장
				bb = new BoardBean();
				
				bb.setBno(rs.getInt("bno"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFile(rs.getString("file"));
				bb.setIp(rs.getString("ip"));
				bb.setName(rs.getString("name"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
			}
			System.out.println("해당 글 저장 완료");
			System.out.println(bb.toString()); // 정보확인
		} catch (Exception e) {
			System.out.println("해당 글 저장 에러");
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return bb;
	
	}

	// getBoard(bb)
	
	// updateBoard(bb)
	
	public int updateBoard(BoardBean bb){
		int check = -1;
		
		try {
			// DB연결
			getCon();
			System.out.println("DB연결 완료");
			// SQL(select) - 작성자 확인
			// 글이 있는 지 검색하는 sql구문 작성
			sql = "select passwd from itwill_board "
				+ "where bno=?";
			
			pstmt = con.prepareStatement(sql);
			System.out.println("pstmt 객체 생성 완료");
			pstmt.setInt(1, bb.getBno());
			System.out.println("pstmt ? 값 설정 완료");
			rs = pstmt.executeQuery();
			System.out.println("pstmt 실행 및 rs저장 완료");
			
			if(rs.next()){
				if(bb.getPasswd().equals(rs.getString("passwd"))){ // 비밀번호 비교 (수정할 때 저장한 비밀번호 / DB에 저장된 비밀번호)
					sql = "update itwill_board set name=?, subject=?, content=? "
						+ "where bno = ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, bb.getName());
					pstmt.setString(2, bb.getSubject());
					pstmt.setString(3, bb.getContent());
					// pstmt.setDate(4, bb.getDate());
					pstmt.setInt(4, bb.getBno());
					
					pstmt.executeUpdate();
					
					System.out.println("글 수정 완료");
					
					check = 1;
			
				}else{
					check = 0;
					
				}
				
			}else{
				check = -1;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return check;
	}
	
	// updateBoard(bno)
	
	// deleteBoard(bno, passwd)
	public int deleteBoard(int bno, String passwd){
		int result = -1;
		
		try {
			getCon();
			// sql & pstmt
			// -> 삭제하려고 하는 글이 있는지 판단
			sql = "select passwd from itwill_board "
				+ "where bno =?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){ // 비밀번호 같음 -> 삭제
					sql = "delete from itwill_board "
						+ "where bno = ?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, bno);
					
					pstmt.executeUpdate();
					System.out.println("글 삭제 완료");
					result = 1;
				}else{ // 비밀번호 오류 -> 삭제x
					result = 0;
					System.out.println("비밀번호 오류");
				}
			}else{
				result = -1; // 글 존재 x
				System.out.println("글 존재 x");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
		closeDB();
		}
		return result;
	}
	
	
	
	// deleteBoard(bno, passwd)
	
	// reInsertBoard()
	public void reInsertBoard(BoardBean bb){
		int num = 0;
		
		
		try {
			// DB연결
			getCon();
			/*********************답글 번호 계산**************************/
			// sql 작성(select-게시판의 글 번호 중 최대값을 계산) & pstmt 객체 생성
			sql = "select max(bno) from itwill_board";
			
			pstmt = con.prepareStatement(sql);
			
			// 실행
			rs = pstmt.executeQuery();
			
			// 데이터 처리
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			
			System.out.println("답글 번호 : "+num);
			
			/********************************************************/
			
			/*********************답글 순서 재배치*************************/
			// re_ref (같은 그룹 기준) re_seq 값이 기존의 값보다 큰 경우 
			// re_seq 값을 1 증가
			sql = "update itwill_board "
					+ "set re_seq = re_seq + 1 "
					+ "where re_ref = ? and re_seq > ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			
			pstmt.executeUpdate();
			
			/********************************************************/
			
			/*********************답글 추가 동작**************************/
			
			sql = "insert into itwill_board "
					+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num); // 계산한 글 번호 저장
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPasswd());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount()); 
			pstmt.setInt(7, bb.getRe_ref()); // 기존 원글의 그룹번호와 동일 
			pstmt.setInt(8, bb.getRe_lev()+1); // 기존의 값 +1
			pstmt.setInt(9, bb.getRe_seq()+1); // 기존의 값 +1
			pstmt.setString(10, bb.getFile());
			pstmt.setString(11, bb.getIp());
			
			// 실행
			
			pstmt.executeUpdate();
			System.out.println("답글 저장 완료");
			/********************************************************/
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}
	// reInsertBoard()
	
	
}

package com.itwillbs.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Generated;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// 디비 연결
	private Connection getCon() throws Exception {

		// Connection con=null;
		Context init = new InitialContext();

		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/funwebDB");

		con = ds.getConnection();

		return con;
	}

	// 디비 자원해제
	public void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// insertBoard(bb) : 글쓰기 처리
	public void insertBoard(BoardBean bb) {
		int num = 0;
		try {
			// 디비연결
			con = getCon();

			// sql(1) 글번호 계산,(2) 글정보를 저장
			sql = "select max(bno) from fun_board";

			pstmt = con.prepareStatement(sql);
			// 실행
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt(1) + 1;
			}

			System.out.println("저장될 글번호 : " + num);

			// (2) 글정보를 저장
			// sql
			sql = "insert into fun_board (bno,name,pass,subject,content,"
					+ "readcount,re_ref,re_lev,re_seq,date,ip,file) " + "values(?,?,?,?,?,?,?,?,?,now(),?,?)";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0); // readcount
			pstmt.setInt(7, num); // re_ref (답글 그룹번호 == 글번호)
			pstmt.setInt(8, 0); // re_lev 일반글 0
			pstmt.setInt(9, 0); // re_seq 일반글 0
			pstmt.setString(10, bb.getIp());
			pstmt.setString(11, bb.getFile());

			// 실행
			pstmt.executeUpdate();

			System.out.println(num + "번 글쓰기 완료!");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

	}
	// insertBoard(bb) : 글쓰기 처리

	// getBoardCount() : 글 개수 계산
	public int getBoardCount() {
		int count = 0;

		try {
			// 디비연결
			con = getCon();
			// sql(글 개수 계산-count()) & pstmt
			sql = "select count(*) from fun_board";
			pstmt = con.prepareStatement(sql);
			
			// 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}
			
			System.out.println(" 글 개수 : "+count+"개");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		// 값 리턴
		return count;
	}
	// getBoardCount() : 글 개수 계산
	
	// getBoardList() : 글 전체 목록
	
	public ArrayList getBoardList(){
		
		// 리스트 객체(배열) 생성
		ArrayList boardList = new ArrayList();
		try {
			
			// DB연결
			getCon();
			
			// SQL(전체 글 정보 모두를 저장) & pstmt
			sql = "select * from fun_board "
				+ "order by re_ref desc";
			
			pstmt = con.prepareStatement(sql);
			// 실행 -> 정보저장
			rs = pstmt.executeQuery();
			// 데이터 처리 (리스트에 저장)
			while(rs.next()){
				BoardBean bb = new BoardBean();
				
				bb.setBno(rs.getInt("bno"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setFile(rs.getString("file"));
				bb.setIp(rs.getString("ip"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setSubject(rs.getString("subject"));
				
				// 리스트 한칸에 행의 정보 하나를 저장
				boardList.add(bb);
				
				System.out.println("글 정보 저장 완료 : "+boardList);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
			
		return boardList;
	}
	
	// getBoardList() : 글 전체 목록
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
				
				sql = "select * from fun_board "
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
					bb.setPass(rs.getString("pass"));
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
				sql = "update fun_board "
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
				sql = "select * from fun_board "
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
					bb.setPass(rs.getString("pass"));
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
				sql = "select pass from fun_board "
					+ "where bno=?";
				
				pstmt = con.prepareStatement(sql);
				System.out.println("pstmt 객체 생성 완료");
				
				pstmt.setInt(1, bb.getBno());
				System.out.println("pstmt ? 값 설정 완료");
				
				rs = pstmt.executeQuery();
				System.out.println("pstmt 실행 및 rs저장 완료");
				System.out.println(bb.getPass());
				if(rs.next()){
					System.out.println(rs.getString("pass"));
					if(bb.getPass().equals(rs.getString("pass"))){ // 비밀번호 비교 (수정할 때 저장한 비밀번호 / DB에 저장된 비밀번호)
						sql = "update fun_board set name=?, subject=?, content=? "
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
		
		// deleteBoard(bno, pass)
		public int deleteBoard(int bno, String pass){
			int result = -1;
			
			try {
				getCon();
				// sql & pstmt
				// -> 삭제하려고 하는 글이 있는지 판단
				sql = "select pass from fun_board "
					+ "where bno =?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, bno);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					if(pass.equals(rs.getString("pass"))){ // 비밀번호 같음 -> 삭제
						sql = "delete from fun_board "
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
				sql = "select max(bno) from fun_board";
				
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
				sql = "update fun_board "
						+ "set re_seq = re_seq + 1 "
						+ "where re_ref = ? and re_seq > ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, bb.getRe_ref());
				pstmt.setInt(2, bb.getRe_seq());
				
				pstmt.executeUpdate();
				
				/********************************************************/
				
				/*********************답글 추가 동작**************************/
				
				sql = "insert into fun_board "
						+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, num); // 계산한 글 번호 저장
				pstmt.setString(2, bb.getName());
				pstmt.setString(3, bb.getPass());
				pstmt.setString(4, bb.getSubject());
				pstmt.setString(5, bb.getContent());
				pstmt.setInt(6, bb.getReadcount()); 
				pstmt.setInt(7, bb.getRe_ref()); // 기존 원글의 그룹번호와 동일 
				pstmt.setInt(8, bb.getRe_lev()+1); // 기존의 값 +1
				pstmt.setInt(9, bb.getRe_seq()+1); // 기존의 값 +1
				pstmt.setString(10, bb.getIp());
				pstmt.setString(11, bb.getFile());
				
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
		// searchnameList()
		public ArrayList searchBoardList(String id){
			
			// 리스트 객체(배열) 생성
			ArrayList boardList = new ArrayList();
			try {
				
				// DB연결
				getCon();
				
				// SQL(전체 글 정보 모두를 저장) & pstmt
				sql = "select * from fun_board "
					+ "where id=?"
					+ "order by re_ref desc";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				// 실행 -> 정보저장
				rs = pstmt.executeQuery();
				// 데이터 처리 (리스트에 저장)
				while(rs.next()){
					BoardBean bb = new BoardBean();
					
					bb.setBno(rs.getInt("bno"));
					bb.setContent(rs.getString("content"));
					bb.setDate(rs.getDate("date"));
					bb.setFile(rs.getString("file"));
					bb.setIp(rs.getString("ip"));
					bb.setName(rs.getString("name"));
					bb.setPass(rs.getString("pass"));
					bb.setRe_lev(rs.getInt("re_lev"));
					bb.setRe_ref(rs.getInt("re_ref"));
					bb.setRe_seq(rs.getInt("re_seq"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setSubject(rs.getString("subject"));
					
					// 리스트 한칸에 행의 정보 하나를 저장
					boardList.add(bb);
					
					System.out.println("글 정보 저장 완료 : "+boardList);
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				closeDB();
			}
				
			return boardList;
		}
		
		// searchBoardList() : 글 전체 목록

}

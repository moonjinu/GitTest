package com.itwillbs.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReplyDAO {
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
	// insertReply(bb1) : 글쓰기 처리
	public void insertReply(ReplyBean bb1) {
		int num = 0;
		try {
			// 디비연결
			con = getCon();

			// sql(1) 글번호 계산,(2) 글정보를 저장
			sql = "select max(contnent_bno) from content_reply "
					+ "where bno=?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bb1.getBno());
			// 실행
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt(1) + 1;
			}

			System.out.println("저장될 글번호 : " + num);

			// (2) 글정보를 저장
			// sql
			sql = "insert into content_reply (bno,name,pass,content,"
					+ "re_ref,re_lev,re_seq,date) " + "values(?,?,?,?,?,?,?,now())";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, bb1.getName());
			pstmt.setString(3, bb1.getPass());
			pstmt.setString(4, bb1.getContent());
			pstmt.setInt(5, num); // re_ref (답글 그룹번호 == 글번호)
			pstmt.setInt(6, 0); // re_lev 일반글 0
			pstmt.setInt(7, 0); // re_seq 일반글 0
			pstmt.setDate(8, bb1.getDate());

			// 실행
			pstmt.executeUpdate();

			System.out.println(num + "번 글 댓글쓰기 완료");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

	}
	// insertReply(bb1) : 글쓰기 처리

	// getReplyCount() : 글 개수 계산
	public int getReplyCount() {
		int count = 0;

		try {
			// 디비연결
			con = getCon();
			// sql(글 개수 계산-count()) & pstmt
			sql = "select count(*) from content_reply";
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
	// getReplyCount() : 글 개수 계산
	
	// getReplyList() : 글 전체 목록
	
	public ArrayList getReplyList(){
		
		// 리스트 객체(배열) 생성
		ArrayList ReplyList = new ArrayList();
		try {
			
			// DB연결
			getCon();
			
			// SQL(전체 글 정보 모두를 저장) & pstmt
			sql = "select * from content_reply "
				+ "order by re_ref desc";
			
			pstmt = con.prepareStatement(sql);
			// 실행 -> 정보저장
			rs = pstmt.executeQuery();
			// 데이터 처리 (리스트에 저장)
			while(rs.next()){
				ReplyBean bb1 = new ReplyBean();
				
				bb1.setBno(rs.getInt("bno"));
				bb1.setContent(rs.getString("content"));
				bb1.setDate(rs.getDate("date"));
				bb1.setName(rs.getString("name"));
				bb1.setPass(rs.getString("pass"));
				bb1.setRe_lev(rs.getInt("re_lev"));
				bb1.setRe_ref(rs.getInt("re_ref"));
				bb1.setRe_seq(rs.getInt("re_seq"));
				
				// 리스트 한칸에 행의 정보 하나를 저장
				ReplyList.add(bb1);
				
				System.out.println("글 정보 저장 완료 : "+ReplyList);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
			
		return ReplyList;
	}
	
	// getBoardList() : 글 전체 목록
	// getBoardList(startRow, pageSize)
		public ArrayList getReplyList(int startRow, int pageSize){
			ArrayList ReplyList = new ArrayList();
			try {
				// DB연결
				getCon();
				
				// SQL & pstmt
				// 게시판 목록 중에서 10개씩 가져오기
				
				// 정렬 - re_ref(그룹번호) 내림차순, 
				// 		re_seq(답글순서) 오름차순
				
				// 데이터 잘라서 가져오기 limit 시작행-1, 개수
				// => 해당 위치부터 개수만큼 가져오기
				
				sql = "select * from content_reply "
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
					ReplyBean bb1 = new ReplyBean();
					
					bb1.setBno(rs.getInt("bno"));
					bb1.setContent(rs.getString("content"));
					bb1.setDate(rs.getDate("date"));
					bb1.setName(rs.getString("name"));
					bb1.setPass(rs.getString("pass"));
					bb1.setRe_lev(rs.getInt("re_lev"));
					bb1.setRe_ref(rs.getInt("re_ref"));
					bb1.setRe_seq(rs.getInt("re_seq"));

					
					// 글 하나의 정보를 arrayList 한칸에 저장
					ReplyList.add(bb1);
					
				}

			} catch (Exception e) {
			
				e.printStackTrace();
			}finally{
			// 자원해제
			closeDB();
			}
			return ReplyList;
		
		}
		
		// getBoardList(startRow, pageSize)
		
		// getReply(bno)
		
		public ReplyBean getReply(int bno){
			ReplyBean bb1 = null;
			try {
				// DB연결
				getCon();
				// sql작성 & pstmt객체 생성
				// 글번호에 해당하는 모든 글의 정보를 가져오기(select)
				sql = "select * from content_reply "
						+ "where bno = ?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, bno);
				
				// 실행
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){ // 데이터가 있으면 실행
					// DB -> JSP 전달하기 위해서 BoardBean객체에 저장
					bb1 = new ReplyBean();
					
					bb1.setBno(rs.getInt("bno"));
					bb1.setContent(rs.getString("content"));
					bb1.setDate(rs.getDate("date"));
					bb1.setName(rs.getString("name"));
					bb1.setPass(rs.getString("pass"));
					bb1.setRe_lev(rs.getInt("re_lev"));
					bb1.setRe_ref(rs.getInt("re_ref"));
					bb1.setRe_seq(rs.getInt("re_seq"));
					
				}
				System.out.println("해당 글 저장 완료");
				System.out.println(bb1.toString()); // 정보확인
			} catch (Exception e) {
				System.out.println("해당 글 저장 에러");
				e.printStackTrace();
			}finally{
				closeDB();
			}
			
			return bb1;
		
		}

		// getBoard(bb)
		
		// updateReply(bb)
		
		public int updateReply(ReplyBean bb1){
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
				
				pstmt.setInt(1, bb1.getBno());
				System.out.println("pstmt ? 값 설정 완료");
				
				rs = pstmt.executeQuery();
				System.out.println("pstmt 실행 및 rs저장 완료");
				System.out.println(bb1.getPass());
				if(rs.next()){
					System.out.println(rs.getString("pass"));
					if(bb1.getPass().equals(rs.getString("pass"))){ // 비밀번호 비교 (수정할 때 저장한 비밀번호 / DB에 저장된 비밀번호)
						sql = "update content_reply set name=?, content=? "
							+ "where bno = ?";
						
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, bb1.getName());

						pstmt.setString(2, bb1.getContent());
						// pstmt.setDate(4, bb.getDate());
						pstmt.setInt(3, bb1.getBno());
						
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
		
		// updateReply(bno)
		
		// deleteReply(bno, pass)
		public int deleteReply(int bno, String pass){
			int result = -1;
			
			try {
				getCon();
				// sql & pstmt
				// -> 삭제하려고 하는 글이 있는지 판단
				sql = "select pass from content_reply "
					+ "where bno =?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, bno);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					if(pass.equals(rs.getString("pass"))){ // 비밀번호 같음 -> 삭제
						sql = "delete from content_reply "
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
		
		
		
		// deleteReply(bno, pass)
		
		// reInsertBoard()
		public void reInsertReply(ReplyBean bb1){
			int num = 0;
			
			
			try {
				// DB연결
				getCon();
				/*********************답글 번호 계산**************************/
				// sql 작성(select-게시판의 글 번호 중 최대값을 계산) & pstmt 객체 생성
				sql = "select max(bno) from content_reply";
				
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
				
				pstmt.setInt(1, bb1.getRe_ref());
				pstmt.setInt(2, bb1.getRe_seq());
				
				pstmt.executeUpdate();
				
				/********************************************************/
				
				/*********************답글 추가 동작**************************/
				
				sql = "insert into contnent_reply "
						+ "values (?, ?, ?, ?, ?, ?, ?, now())";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, num); // 계산한 글 번호 저장
				pstmt.setString(2, bb1.getName());
				pstmt.setString(3, bb1.getPass());
				pstmt.setString(4, bb1.getContent());
				pstmt.setInt(5, bb1.getRe_ref()); // 기존 원글의 그룹번호와 동일 
				pstmt.setInt(6, bb1.getRe_lev()+1); // 기존의 값 +1
				pstmt.setInt(7, bb1.getRe_seq()+1); // 기존의 값 +1

				
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
		// reInsertReply()

}
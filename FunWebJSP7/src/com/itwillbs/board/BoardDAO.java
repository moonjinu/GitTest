package com.itwillbs.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	// DB연결 메서드
	private Connection getCon() throws Exception{
		
		Context init = new InitialContext();
		
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/funwebDB");
		
		con = ds.getConnection();
		
		return con;
	}
	
	// 자원해제 메서드
	public void closeDB(){
		try{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	// insertBoard(bb); 글쓰기 처리
	
	public void insertBoard(BoardBean bb){
		int num = 0; // 글번호 저장
		try {
			// DB연결
			
			con = getCon();
			
			// sql(1- 글 번호 계산, 2-글 정보를 저장) & pstmt
			
			sql = "select max(bno) from fun_board";
			
			pstmt = con.prepareStatement(sql);
			
			// rs
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1)+1;
			}
			
			System.out.println("저장될 글 번호 : "+ num);
			
			// 글정보를 저장
			// sql & pstmt
			sql = "insert into fun_board(bno, name, pass, subject, content,"
										+ "readcount, re_ref, re_seq, re_lev, date,"
										+ "ip, file) "
					+ "values(?, ?, ?, ?, ?,"
							+ "?, ?, ?, ?, now(),?,?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0); // readcount
			pstmt.setInt(7, num); // re_ref(답글 그룹번호 == 글번호)
			pstmt.setInt(8, 0); // re_seq 일반글 0
			pstmt.setInt(9, 0); // re_lev 일반글 0
			pstmt.setString(10, bb.getIp());
			pstmt.setString(11, bb.getFile());
			
			// 실행
			
			pstmt.executeUpdate();
			
			System.out.println(num+"번 글쓰기 완료");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
	}
	
	
	
	
	// insertBoard(bb); 글쓰기 처리
}

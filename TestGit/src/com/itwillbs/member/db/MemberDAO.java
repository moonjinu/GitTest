package com.itwillbs.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// 디비연결 메서드
	public Connection getCon() throws Exception {
		// 커넥션 풀 사용 디비 연결
		Context init = new InitialContext();

		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/Model2DB");

		con = ds.getConnection();

		return con;
		// return ds.getConnection();
	}

	// 디비 자원해제 메서드
	public void closeDB() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// insertMember(mb)
	public void insertMember(MemberBean mb) {
		try {
			// 디비연결
			con = getCon();
			// sql 작성 & pstmt 객체 생성
			sql = "insert into itwill_member(id,pw,name,age," + "gender,email,reg_date) values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);

			// ?
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPw());
			pstmt.setString(3, mb.getName());
			pstmt.setInt(4, mb.getAge());
			pstmt.setString(5, mb.getGender());
			pstmt.setString(6, mb.getEmail());
			pstmt.setTimestamp(7, mb.getReg_date());

			// 실행
			pstmt.executeUpdate();

			System.out.println("@@@@ DAO : 회원가입 처리 완료!");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
			System.out.println("@@@@ DAO : 자원해제 성공!");
		}

	}
	// insertMember(mb)

	// idCheck(id,pw)
	public int idCheck(String id, String pw) {
		int result = -1;

		try {
			con = getCon();

			sql = "select pw from itwill_member where id=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) { // 회원이 있다
				if (pw.equals(rs.getString("pw"))) {
					// 비밀번호 동일
					result = 1;
				} else {
					// 비밀번호 다름
					result = 0;
				}
			} else { // 회원이 없다
				result = -1;
			}

			System.out.println("@@@@ DAO : 로그인 처리 완료 ");
			System.out.println("@@@@ DAO : " + result);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return result;
	}
	// idCheck(id,pw)

	// getMember(id)
	public MemberBean getMember(String id) {
		MemberBean mb = null;

		try {
			con = getCon();

			sql = "select * from itwill_member where id=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				mb = new MemberBean();

				mb.setAge(rs.getInt("age"));
				mb.setEmail(rs.getString("email"));
				mb.setGender(rs.getString("gender"));
				mb.setId(rs.getString("id"));
				mb.setName(rs.getString("name"));
				mb.setPw(rs.getString("pw"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
			}

			System.out.println("@@@@ DAO : 회원정보 저장완료");
			System.out.println("@@@@ DAO : " + mb);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return mb;
	}
	// getMember(id)

	// updateMember(mb)
	public int updateMember(MemberBean mb) {
		int check = -1;

		try {
			// 디비연결
			con = getCon();
			// sql (회원 존재 여부 판단)
			sql = "select pw from itwill_member where id=?";
			// pstmt 객체 생성
			pstmt = con.prepareStatement(sql);
			// ?
			pstmt.setString(1, mb.getId());
			
			// 실행
			rs = pstmt.executeQuery();
			
			// 데이터 처리
			if(rs.next()){
				// 아이디 있음
				if(mb.getPw().equals(rs.getString("pw"))){
					// 본인 -> 회원정보 수정
					
					// sql작성(update)
					sql ="update itwill_member set name=?,age=?,gender=?,email=? "
							+ "where id=?";					
					// pstmt 생성
					pstmt = con.prepareStatement(sql);
					// ?
					pstmt.setString(1, mb.getName());
					pstmt.setInt(2, mb.getAge());
					pstmt.setString(3, mb.getGender());
					pstmt.setString(4, mb.getEmail());
					pstmt.setString(5, mb.getId());				
					
					// 실행
					pstmt.executeUpdate();
					check = 1;
					System.out.println("DAO : 회원정보 수정 완료");					
				}else{
                  // 비밀번호 오류
				  check = 0;
				  System.out.println("DAO : 회원정보 비밀번호 오류");					
				}
			}else{
				// 아이디가 없음
				check = -1;
				System.out.println("DAO : 회원정보 아이디 없음");					
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return check;
	}
	// updateMember(mb)
	


}

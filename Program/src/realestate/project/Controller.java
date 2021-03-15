package realestate.project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.InputMismatchException;
import java.util.Scanner;

public class Controller extends Dao {

	public void createAccount() {
		try {
			con = DriverManager.getConnection(URL, ID, PW);
			stmt = con.createStatement();

			String cid = null;
			String cpw = null;
			String cname = null;
			String gcode = null;
			String cphone = null;
			String cemail = null;
			String caddress = null;
			boolean isRun = true;

			// 아이디
			while (isRun) {
				System.out.print("ID >> ");
				cid = sc.next();
				String idSelect = "SELECT cid FROM cst WHERE cid='" + cid + "'";
				rs = stmt.executeQuery(idSelect);

				String selectId = null;
				while (rs.next()) {
					selectId = rs.getString(1);
				}
				if (selectId != null) {
					System.out.println("중복된 ID입니다.");
				} else {
					System.out.println("사용 가능한 ID입니다.");
					break;
				}
			}

			// 비밀번호
			System.out.println();
			System.out.print("PW >> ");
			cpw = sc.next();

			// 이름
//			isRun=true;	//위에서 isRun이 false로 바꼈으니까 다시 트루로 실행..!!!
			System.out.println();
			while (isRun) {
				System.out.print("이름 >> ");
				cname = sc.next();
				if (cname.matches("^[가-힣]*$") && cname.length() >= 2) {
					break;
				} else if (cname.length() < 2) {
					System.out.println("이름을 두 글자 이상으로 입력하세요");
				} else {
					System.out.println("이름을 한글로 입력하세요");
				}
			}

			// 주민등록번호
			System.out.println();
			while (isRun) {
				System.out.println("주민등록번호    ex) 901231-1234567");
				System.out.print(">> ");
				gcode = sc.next();
				if (gcode.contains("-") && gcode.length() == 14) {
					break;
				} else {
					System.out.println("주민등록번호를 형식에 맞춰 입력하세요   ex) 901231-1234567");
					System.out.println();
				}
			}

			// 전화번호
			System.out.println();
			while (isRun) {
				System.out.print("전화번호 >> ");
				cphone = sc.next();
				if (cphone.contains("-")) {
					break;
				} else {
					System.out.println("전화번호를 형식에 맞춰 입력하세요");
					System.out.println("ex) 02-1234-5678 / 010-1234-5678");
					System.out.println();
				}
			}

			// 이메일
			System.out.println();
			while (isRun) {
				System.out.print("이메일 >> ");
				cemail = sc.next();
				if (cemail.contains("@")) {
					break;
				} else {
					System.out.println("이메일을 형식에 맞춰 입력하세요    	ex)abc@abc.com");
					System.out.println();
				}
			}

			// 주소
			System.out.println();
			while (isRun) {
				System.out.println("주소를 시단위만 입력하세요    ex) 서울시 ");
				System.out.print(">> ");
				caddress = sc.next();
				if (caddress.length() <= 5) {
					break;
				} else {
					System.out.println("시단위만 입력하세요");
					System.out.println();
				}
			}
			String sql = "INSERT INTO CST (ccode, cid, cpw, cname, gcode, cphone, cemail, caddress, joindate) VALUES (ccode_seq.NEXTVAL, '"
					+ cid + "', '" + cpw + "', '" + cname + "', '" + gcode + "', '" + cphone + "', '" + cemail + "', '"
					+ caddress + "', sysdate)";

			// 실행
			stmt.executeUpdate(sql);
			System.out.println("가입이 완료되었습니다.");
			System.out.println();

			// 종료
			close(con, stmt, rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void login() {
		try {
			con = DriverManager.getConnection(URL, ID, PW);
			stmt = con.createStatement();

			// 5. SQL문
			boolean isRun = true;
			while (isRun) {
				System.out.print("ID >> ");
				logId = sc.nextLine();
				System.out.print("PW >> ");
				String logPw = sc.nextLine();
				String idpwSelect = "SELECT cid, cpw, ccode FROM cst WHERE cid='" + logId + "' AND cpw='" + logPw + "'";
				rs = stmt.executeQuery(idpwSelect);

				String selectId = null;
				String selectPw = null;
				while (rs.next()) {
					selectId = rs.getString("cid");
					selectPw = rs.getString("cpw");
					myCcode = Integer.parseInt(rs.getString("ccode"));
				}
				if (selectId == null && selectPw == null) {
					System.out.println("ID나 PW가 일치하지 않습니다.");
				} else {
					isRun = false;
					System.out.println("로그인이 완료되었습니다.");
					System.out.println();
				}
			}
			close(con, stmt, rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public String searchLocation() {
		// 1. 지역을 검색

		String s = "";
		boolean boo = true;
		while (boo) {
			View.locationMenu();
			s = sc.nextLine();
			if (s.length() < 7) {
				System.out.println("행정동까지 입력하세요   ex) 서초구 방배동");
				System.out.println();
			} else if (s.equals("서초구 방배동") || s.equals("종로구 삼청동") || s.equals("용산구 이태원동") || s.equals("마포구 망원동")) {
				boo = false;
			} else {
				System.out.println("입력한 지역에는 매물이 없습니다.");
				System.out.println();
				continue;
			}

		} // while end
		return s;
	}

	public String searchHouse() {
		View.houseMenu();
//		boolean boo = true;

		for(;;) {
			int i = sc.nextInt();
			String s = "";
			switch (i) {
			case 1:
				s = " AND house = '원룸'"; return s;
			    
			case 2:
				s = " AND house = '투룸'"; return s;
			
			case 3:
				s = " AND house = '아파트'"; return s;
				
			case 4:
				s = " AND house = '오피스텔'"; return s;
				
			case 5:
				s = " AND house = '상가'"; return s;
			
			case 6:
				s = ""; return s;
				
			default:
				System.err.println("잘 못 입력했습니다. 바로 다시 입력해 주세요.");
				System.out.println(">> ");				
			}
		} // while end
//		return null;
	}

	public String searchContract() {
		View.contractMenu();
		boolean boo = true;

		while (boo) {
			int i = sc.nextInt();
			String s = "";
			switch (i) {
			case 1:
				s = " AND CONTRACT = '매매'"; return s;
			case 2:
				s = " AND CONTRACT = '전세'"; return s;
			case 3:
				s = " AND CONTRACT = '월세'"; return s;
			case 4:
				s = ""; return s;
			default:
				System.err.println("잘 못 입력했습니다. 다시 입력해 주세요.");
				System.out.print(">> ");	
			}
			// return s;를 여기다가 주게되면, default 선택의 경우 String s = ""; 가 보내지면서 에러!
		} // while end
		return null;
	}

	public void selectRoom() {
		String searchLoc = searchLocation();
		String searchHou = searchHouse();
		String searchCon = searchContract();

		try {
			con = DriverManager.getConnection(URL, ID, PW);
			stmt = con.createStatement();

			// SQL문
			String sql = "SELECT bcode, blocation, baddress, house, contract, price, monthly, area, officename, rname "
					+ "FROM bld, realtor WHERE bld.rcode = realtor.rcode " + "AND blocation = '" + searchLoc + "'"
					+ searchHou + searchCon;

			rs = stmt.executeQuery(sql);

			// 7. 결과 출력
			int cnt = 1;
			// 간단하게 매물번호 저장을 위한 String배열
			String[] bArr = new String[30];
			if (rs.next()) {
				do {
					System.out.println("========[ 매물 " + cnt + "번 ]========");
					System.out.println("매물번호   : " + rs.getString("bcode"));
					bArr[cnt] = rs.getString("bcode");
					System.out.println("소재지역   : " + rs.getString("blocation"));
					System.out.println("주소   : " + rs.getString("baddress"));
					System.out.println("주거형태   : " + rs.getString("house"));
					System.out.println("계약형태   : " + rs.getString("contract"));
					if (rs.getString(7).equals("0")) {
						System.out.println("매매/전세   : " + rs.getString("price") + "만원");
					} else {
						System.out.println("보증금   : " + rs.getString("price") + "만원");
						System.out.println("월세   : " + rs.getString("monthly") + "만원");
					}
					System.out.println("면적   : " + rs.getString("area"));
					System.out.println("중개사무소 : " + rs.getString("officename"));
					System.out.println("중개인   : " + rs.getString("rname"));
					System.out.println();
					cnt++;
				} while (rs.next());
			} else {
				System.out.println("조건에 해당하는 매물이 없습니다");
				System.out.println();
				return;
			}

			View.doUWantRSV();
			int i = sc.nextInt();
			if (i == 1) { // 예약
				View.whichBld();
				for (int j = 1; j < cnt; j++) {
					System.out.println("[" + j + "]  매물 " + j + "번");
				}
				System.out.print(">> ");
				i = sc.nextInt();

				sql = rsvVisit(Integer.parseInt(bArr[i]), myCcode);
				// SQL문 서버로 전송 후 결과 받기
				rs = stmt.executeQuery(sql);
				// 예약 날짜 받기
				boolean boo = true;
				System.out.println("방문을 원하는 날짜를 입력해주세요   ex)2020/12/25");
				while (boo) {
					System.out.print(">> ");
					rDate = sc.next();
					if (rDate.length() == 10 && rDate.contains("/")) {
						boo = false;
					} else {
						System.out.println("형식에 맞춰 입력하세요   ex)2020/12/25");
					}
				}

				// 7. 결과 출력
				// 7. 결과 가져오기 & 출력
				while (rs.next()) {
					System.out.println("=========매물 방문예약 결과==========");
					System.out.println("매물번호  : " + rs.getString("bcode"));
					System.out.println("소재지역  : " + rs.getString("blocation"));
					System.out.println("주소     : " + rs.getString("baddress"));
					System.out.println("주거형태	: " + rs.getString("house"));
					System.out.println("계약형태  : " + rs.getString("contract"));
					if (rs.getString("monthly").equals("0")) {
						System.out.println("매매/전세 : " + rs.getString("price") + "만원");
					} else {
						System.out.println("보증금   : " + rs.getString("price") + "만원");
						System.out.println("월세     : " + rs.getString("monthly") + "만원");
					}
					System.out.println("면적     : " + rs.getString("area"));
					System.out.println("중개사무소 : " + rs.getString("officename"));
					System.out.println("중개인    : " + rs.getString("rname"));
					System.out.println("중개인연락처: " + rs.getString("rphone"));
					System.out.println("예약자명   : " + rs.getString("cname"));
					System.out.println("회원번호   : " + rs.getString("ccode"));
					System.out.println("예약날짜   : " + rDate);
					System.out.println();

					Reservation rsv = new Reservation();

					rsv.setbCode(rs.getString("bcode"));
					rsv.setbLocation(rs.getString("blocation"));
					rsv.setbAddress(rs.getString("baddress"));
					rsv.setHouse(rs.getString("house"));
					rsv.setContract(rs.getString("contract"));
					if (rs.getString("monthly").equals("0")) {
						rsv.setPrice(rs.getString("price"));
						rsv.setMonthly("0");
					} else {
						rsv.setPrice(rs.getString("price"));
						rsv.setMonthly(rs.getString("monthly"));
					}
					rsv.setArea(rs.getString("area"));
					rsv.setOfficename(rs.getString("officename"));
					rsv.setrName(rs.getString("rname"));
					rsv.setrPhone(rs.getString("rphone"));
					rsv.setcName(rs.getString("cname"));
					rsv.setcCode(rs.getString("ccode"));
					rsv.setrDate(rDate);

					list.add(rsv);

				}

				// Reservation클래스엔 넣어졌고 넣어진값을 이용해서 이제 오라클타임 .. RVS테이블에 b,c,r code 넣어주기…
				sql = insertRsv(list.get(list.size() - 1), myCcode); //
				// 예약확인()은 오라클을 이용해서 예약정보를 확인해야한다. 왜냐하면 이곳이 저장공간이고 사용자가 바껴을때를 위해.
				rs = stmt.executeQuery(sql);
				System.out.println("방문예약이 완료되었습니다. ");
			} else if (i == 2)
				return;

			close(con, stmt, rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public String rsvVisit(int bCode, int cCode) {

		String str = "SELECT bcode, blocation, baddress, house, contract, price, monthly, area, officename, rname, rphone, cname, ccode "
				+ "FROM bld, realtor, cst " + "where bld.rcode = realtor.rcode " + "and bcode = " + bCode
				+ "and ccode = " + cCode;
		return str;
	}

	public String insertRsv(Reservation r, int cCode) {
		String str = "INSERT INTO RSV (Rsequence, Rdate, Bcode, Ccode, Rcode) " + "VALUES (rsequence_seq.NEXTVAL, '"
				+ rDate + "', " + r.bCode + ", " + cCode + "," + "(SELECT REALTOR.RCODE " + "FROM REALTOR, BLD "
				+ "WHERE BLD.RCODE=realtor.RCODE " + "AND BCODE= " + r.bCode + "))";
		return str;
	}

	public void showMyVisit() {
		try {
			con = DriverManager.getConnection(URL, ID, PW);
			stmt = con.createStatement();
			String sql = "SELECT * FROM RSV_VIEW WHERE 회원아이디 = '" + logId + "'";

			rs = stmt.executeQuery(sql);

			if (rs.next()) {

				do {
					
					System.out.println("        	 나의 예약 현황");
					System.out.println("=========================================================");
					System.out.println("예약번호 | 예약 날짜		: " + rs.getString(3) + " | " + rs.getString(4));
					System.out.println("회원번호 | 예약자 이름	: " + rs.getString(1) + " | " + rs.getString(2));
					System.out.println("매물번호			: " + rs.getString(5));
					System.out.println("소재지역			: " + rs.getString(6));
					System.out.println("주소			: " + rs.getString(7));
					System.out.println("주거형태			: " + rs.getString(8));
					System.out.println("계약형태			: " + rs.getString(9));
					if (rs.getString(11).equals("0")) {
						System.out.println("매매 | 전세		: " + rs.getString(10) + "만원");
					} else {
						System.out.println(
								"보증금 | 월세		: " + rs.getString(10) + "만원" + " / " + rs.getString(11) + "만원");
					}
					System.out.println("면적			: " + rs.getString(12));
					System.out.println("중개 사무소		: " + rs.getString(13));
					System.out.println("중개인			: " + rs.getString(14));
					System.out.println("중개인 연락처		: " + rs.getString(15));
					System.out.println();

				} while (rs.next());
			} else {
				System.out.println("예약 정보가 없습니다");
				System.out.println();
			}
			close(con, stmt, rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void delVisit() {
		System.out.println("취소하실 예약의 [예약 번호]를 입력해 주세요");
		System.out.print(">> ");
		int delNo = sc.nextInt();
		sc.nextLine();
		try {
			con = DriverManager.getConnection(URL, ID, PW);
			stmt = con.createStatement();

			View.doUWantDel(delNo);
			int isYes = sc.nextInt();
			if (isYes == 1) {

				// 에약 매물 삭제
				String sql = "DELETE FROM RSV WHERE Rsequence = '" + delNo + "'";
				int cnt = stmt.executeUpdate(sql);
				System.out.println(cnt + " 건의 예약이 취소되었습니다");
				System.out.println();

				// 종료
				close(con, stmt, rs);
			} else if (isYes == 2) {
				return;
			} else {
				System.out.println("잘못 입력하셨습니다. 다시 진행해 주세요");
				System.out.println();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void logout() {
		System.out.println("로그아웃이 완료되었습니다.");
		System.out.println();
		mainRun();
	}

	public void mainRun() {
		// 반복 루프, main함수에서 호출
		boolean isRun = true;
		int select;

		while (isRun) {
			View.homeMenu();
			try {
				select = sc.nextInt();
				sc.nextLine();
				if (select == 1) {
					createAccount();
				} else if (select == 2) {
					login();
					while (isRun) {
						View.showMenu();
						try {
							select = sc.nextInt();
							sc.nextLine();
							switch (select) {
							case 1:
								selectRoom();
								continue;
							case 2:
								showMyVisit();
								continue;
							case 3:
								delVisit();
								continue;
							case 4:
								logout();
								break;
							case 0:
								isRun = false;
								System.out.println("프로그램이 종료되었습니다.");
								break;
							default:
								System.out.println("잘못 선택하셨습니다. 다시 선택해주세요");
								System.out.println();
								continue;
							}
						} catch (InputMismatchException e) {
							sc = new Scanner(System.in);
							System.out.print("잘 못 입력하셨습니다. 번호로 입력해주세요 >> ");
						}
						isRun = false;
					} // while2 end

				} else if (select == 0) {
					isRun = false;
					System.out.println("프로그램이 종료되었습니다.");
				} else {
					System.out.println("잘 못 선택했습니다. 다시 선택하세요");
					continue;
				}
			} catch (InputMismatchException e) {
				sc = new Scanner(System.in);
				System.out.print("잘 못 입력했습니다. 번호로 입력하세요 >> ");
			}

		} // while end

	}// mainRun();

	public void close(Connection con, Statement stmt, ResultSet rs) {

		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
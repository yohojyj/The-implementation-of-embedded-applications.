package realestate.project;

import java.util.Scanner;

public class View {
	private static Scanner sc = new Scanner(System.in); // 변수라서 private

	public static Scanner InputKeyboard() {
		return sc;
	}

	// 로그인 화면
	public static void homeMenu() {
		System.out.println("*..*.. H o u s e m a t e ..*..*");
		System.out.println();
		System.out.println("실행할 항목을 선택하세요");
		System.out.println("==================");
		System.out.println("[1] 회원가입");
		System.out.println("[2] 로그인");
		System.out.println();
		System.out.println("[0] 프로그램 종료");
		System.out.print(">> ");
	}

	// 로그인 화면
	public static void showMenu() {
		System.out.println();
		System.out.println("실행할 항목을 선택하세요");
		System.out.println("==================");
		System.out.println("[1] 매물 검색 및 방문 예약");
		System.out.println("[2] 예약 확인");
		System.out.println("[3] 예약 취소");
		System.out.println("[4] 로그아웃");
		System.out.println();
		System.out.println("[0] 프로그램 종료");
		System.out.print(">> ");
	}

	// 매물검색 메서드
	static void locationMenu() {
		System.out.println();
		System.out.println("원하는 지역을 입력하세요");
		System.out.println("===================");
		System.out.println("[서초구 방배동] [종로구 삼청동] [용산구 이태원동] [마포구 망원동]");
		System.out.print(">> ");
	}

	static void houseMenu() {
		System.out.println();
		System.out.println("원하는 매물을 선택하세요");
		System.out.println("===================");
		System.out.println("[1] 원룸");
		System.out.println("[2] 투룸");
		System.out.println("[3] 아파트");
		System.out.println("[4] 오피스텔");
		System.out.println("[5] 상가");
		System.out.println("[6] 모든 매물 검색");
		System.out.print(">> ");
	}

	static void contractMenu() {
		System.out.println();
		System.out.println("원하는 계약 형태를 선택하세요");
		System.out.println("======================");
		System.out.println("[1] 매매");
		System.out.println("[2] 전세");
		System.out.println("[3] 월세");
		System.out.println("[4] 모든 매물 검색");
		System.out.print(">> ");
	}

	static void doUWantRSV() {
		System.out.println();
		System.out.println("방문하고 싶은 매물이 있나요?");
		System.out.println("======================");
		System.out.println("[1] 네    	 [2] 아니오");
		System.out.print(">> ");

	}

	static void whichBld() {
		System.out.println();
		System.out.println("방문을 예약할 매물 번호를 선택하세요");
		System.out.println("===========================");
	}

	public static void doUWantDel(int delNo) {
		System.out.println();
		System.out.println("예약번호" + delNo +"의 예약을 취소하시겠습니까?");
		System.out.println("======================");
		System.out.println("[1] 네    	 [2] 아니오");
		System.out.print(">> ");
		
	}

	
	
	
	
	
	
	
}

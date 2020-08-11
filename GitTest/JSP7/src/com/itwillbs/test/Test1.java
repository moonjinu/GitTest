package com.itwillbs.test;

class Parent{
 void pprn(){
		System.out.println("Parent_pprn()!");
	}
}
class Child extends Parent{
	public void cprn(){
		System.out.println("Child_cprn()!");
	}
	// public > protected > 기본접근지정자 > private
	// 메서드 오버라이딩 시 접근지정자는 부모의 메서드보다 범위가 줄어들어서는 안됨.
	// 부모의 메서드보다 범위가 증가는 가능
	/*기본 접근지정자*/public void pprn(){
		super.pprn(); // super -> 부모 참조변수
		System.out.println("Child_pprn()!");
	}
}
public class Test1 {

	public static void main(String[] args) {
		
		Parent p = new Parent();
		p.pprn();
		System.out.println("--------------------");
		Child c = new Child();
		c.cprn();
		c.pprn();
		System.out.println("--------------------");
		
		// * 상속관계만 가능
		// 업 캐스팅 : (자동 형변환) 서브클래스를 부모클래스로 형변환
		// 			슈퍼클래스의 레퍼런스에 서브클래스의 인스턴스를 저장
		// 다운 캐스팅 : (강제 형변환) 부모클래스를 서브클래스로 형변환
		//			서브클래스의 레퍼런스에 슈퍼클래스의 인스턴스를 저장
		
		Parent p1 = new Child(); // -> 업캐스팅
		// Parent p2 = c;			// -> 업캐스팅
		p1.pprn(); // 사용o
		// p1.cprn(); 사용x
		// * 업캐스팅은 상속받은 부분만 사용가능
		// * 참조영역이 감소했다
		// * 컴파일러가 자동으로 형변환
		
		// 다운캐스팅
	//	Child c1 = (Child) new Parent(); // -> 다운캐스팅
		// Child c1 = (Child)c; 		// -> 다운캐스팅
	//	c1.pprn();
	//	c1.cprn();
		
		// * 다운캐스팅은 컴파일러가 자동으로 형변환x
		// -> 해당 객체가 존재하지 않을 수 있기 때문에
		// => 개발자가 직접 타입을 구현 => 예외 발생 (실행 후)
		// 						   컴파일에러 (실행전)

		Parent pp = new Child(); // 업캐스팅
		Child c1 = (Child) pp; // 다운캐스팅
		// -> 강제 형변환  : 문제를 인지하고 책임을 지겠다.(개발자) 
		pp.pprn();
		c1.pprn();
		c1.cprn();
		
		
	}

}

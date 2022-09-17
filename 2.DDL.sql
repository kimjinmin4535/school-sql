/*
	* sql을 이용한 데이터 정의
	* 고객 테이블 
	* 
	* 고객 테이블은 고객아이디, 고객이름, 나이, 등급, 직업, 적립금 속성으로 구성되고,
	* 고객아이디 속성이 기본키이다.
	* 고객이름과 등급 속성은 값을 반드시 입력해야 하고,
	* 적립금 속성은 값을 입력하지 않으면 0이 기본으로 입력되도록 고객 테이블을 생성하시오.	
*/
DROP TABLE 고객 CASCADE CONSTRAINT;
CREATE TABLE 고객 (
	고객아이디		VARCHAR(20) NOT NULL
	,고객이름		VARCHAR(10) NOT NULL
	,나이			INT
	,등급			VARCHAR(10) NOT NULL
	,직업			VARCHAR(20)
	,적립금		INT		DEFAULT 0
	,PRIMARY KEY(고객아이디)
);

drop table 주문;
DROP TABLE 고객;

/*
 * 	제품 테이블은 제품번호, 제품명, 재고량, 단가, 제조업체 속성으로 구성되고,
 *  제품번호 속성이 기본키이다.
 *  재고량이 항상 0개 이상 10,000개 이하를 유지하도록 제품 테이블을 생성하시오.
 */
DROP TABLE 제품 CASCADE CONSTRAINT;
CREATE TABLE 제품 (
	제품번호	char(3)		NOT NULL
	,제품명	varchar(20)
	,재고량	int
	,단가		int
	,제조업체	varchar(20)
	,PRIMARY key(제품번호)
	,check(재고량 >= 0 AND 재고량 <= 10000)
);

/*
 * 주문 테이블은 주문번호, 주문고객, 주문제품, 수량, 배송지, 주문일자 속성으로 구성되고,
 * 주문번호 속성이 기본키다.
 * 주문고객 속성이 고객 테이블의 고객아이디 속성을 참조하는 외래키이고,
 * 주문제품 속성이 제품 테이블의 제품번호 속성을 참조하는 외래키가 되도록
 * 주문 테이블을 생성하시오.
 * 
 */
DROP TABLE 주문 CASCADE CONSTRAINT;
CREATE TABLE 주문(
	주문번호	char(3)		NOT NULL
	,주문고객	varchar(20)
	,주문제품	char(3)
	,수량		int
	,배송지	varchar(30)
	,주문일자	DATE
	,PRIMARY key(주문번호)
	,FOREIGN key(주문고객) REFERENCES 고객(고객아이디) 
	,FOREIGN key(주문제품) REFERENCES 제품(제품번호)
);

/*
 * 배송업체 테이블은 업체번호, 업체명, 주소, 전화번호 속성으로 구성되고
 * 업체번호 속성이 기본키다.
 * 배송업체 테이블을 생성하시오.
 */

creatE TABLE 배송업체 (
	업체번호	CHAR(3)		NOT NULL
	,업체명	VARCHAR(20)
	,주소		VARCHAR(100)
	,전화번호	VARCHAR(20)
	,PRIMARY KEY(업체번호)
);


/*
    생성한 고객 테이블에 가입날짜 속성을 추가하시오.
*/
alter table 고객 add 가입날짜 date;

/*
    추가한 고객 테이블의 가입날짜 속성을 삭제하시오.
*/
alter table 고객 drop column 가입날짜;

/*
    고객 테이블에 20세 이상의 고객만 가입할 수 있다는 데이터 무결성 제약조건을 추가하시오.
*/
alter table 고객 add constraint chk_age check(나이 >= 20);


/*
    추가한 고객 테이블에 20 이상의 고객만 가입할 수 있다는 데이터 무결성 제약조건을 삭제하시오.
*/
alter table 고객 drop constraint chk_age;


/*
    배송업체 테이블을 삭제하시오.
*/
drop table 배송업체;





















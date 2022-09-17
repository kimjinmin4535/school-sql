/*
 * 고객 테이블에 고객 아이디가 strawberry, 고객이름이 최유경,
 * 나이가 30세, 등급이 vip, 직업이 공무원, 적립금이 100원인 
 * 새로운 고객의 정보를 삽입하시오.
 * 그런 다음 고객 테이블의 모든 내용을 검색하여 새로 추가된 투플을 확인하시오.
 */

INSERT INTO 고객 
VALUES ('strawberry', '최유경', 30, 'vip', '공무원', 100); 
COMMIT;

INSERT INTO 고객 (고객아이디, 고객이름, 등급)
VALUES ('strawberry', '최유경', 'vip');
COMMIT;

SELECT * FROM 고객;

DELETE FROM 고객;
COMMIT;

-- 고객 테이블에 튜플 삽입
INSERT INTO 고객 VALUES ('apple', '정소화', 20, 'gold', '학생', 1000); 
INSERT INTO 고객 VALUES ('banana', '김선우', 25, 'vip', '간호사', 2500); 
INSERT INTO 고객 VALUES ('carrot', '고명석', 28, 'gold', '교사', 4500); 
INSERT INTO 고객 VALUES ('orange', '김용욱', 22, 'silver', '학생', 0); 
INSERT INTO 고객 VALUES ('melon', '성원용', 35, 'gold', '회사원', 5000); 
INSERT INTO 고객 VALUES ('peach', '오형준', null, 'silver', '의사', 300); 
INSERT INTO 고객 VALUES ('pear', '채광주', 31, 'silver', '회사원', 500); 
commit;

-- 제품 테이블에 튜플 삽입
insert into 제품 values ('p01','그냥만두', 5000, 4500, '대한식품');
insert into 제품 values ('p02','매운쫄면', 2500, 5500, '민국푸드');
insert into 제품 values ('p03','쿵떡파이', 3600, 2600, '한빛제과');
insert into 제품 values ('p04','맛난초콜릿', 1250, 2500, '한빛제과');
insert into 제품 values ('p05','얼큰라면', 2200, 1200, '대한식품');
insert into 제품 values ('p06','통통우동', 1000, 1550, '민국푸드');
insert into 제품 values ('p07','달콤비스킷', 1650, 1500, '한빛제과');
commit;

select * from 제품;

-- 주문 테이블에 튜플 삽입
insert into 주문 values ('o01', 'apple', 'p03', 10, '서울시 마포구', '19/01/01');
insert into 주문 values ('o02', 'melon', 'p01', 5, '인천시 계양구', '19/01/01');
insert into 주문 values ('o03', 'banana', 'p06', 45, '경기도 부천시', '19/01/11');
insert into 주문 values ('o04', 'carrot', 'p02', 8, '부산시 금전구', '19/02/01');
insert into 주문 values ('o05', 'melon', 'p06', 36, '경기도 용인시', '19/02/20');
insert into 주문 values ('o06', 'banana', 'p01', 19, '충청북도 보은군', '19/03/02');
insert into 주문 values ('o07', 'apple', 'p03', 22, '서울시 영등포구', '19/03/15');
insert into 주문 values ('o08', 'pear', 'p02', 50, '강원도 춘천시', '19/04/10');
insert into 주문 values ('o09', 'banana', 'p04', 15, '전라남도 목포시', '19/04/11');
insert into 주문 values ('o10', 'carrot', 'p03', 20, '경기도 안양시', '19/05/22');
commit;

select * from 주문;

/*
    제품 테이블에서 제품번호가 p03인 제품의 제품명을 통큰파이로 수정하시오.
*/
UPDATE 제품
SET 제품명 = '통큰파이'
WHERE 제품번호 = 'p03';

SELECT * FROM 제품;

/*
    제품 테이블에 있는 모든 제품의 단가를 10% 인상하시오.
    그런 다음 제품 테이블의 모든 내용을 검색하여 인상 내용을 확인하시오.
*/
update 제품
set 단가 = 단가 * 1.1;

SELECT * FROM 제품;

/*
    주문 테이블에서 정소화 고객이 주문한 제품의 주문수량 5개로 수정하시오.
    그런 다음 주문 테이블의 모든 내용을 검색하여 수정 내용을 확인하시오.
*/

UPDATE 주문 
SET 수량 = 5
WHERE 주문고객 IN (   SELECT 고객아이디
					FROM 고객
					WHERE 고객이름='정소화'		
				);
COMMIT;

			
SELECT * FROM 주문;
			
SELECT 고객아이디
FROM 고객
WHERE 고객이름='정소화'
;

/*
 * 주문 테이블에서 주문일자가 2019년 5월 22일인 주문내역을 삭제하시오.
 * 그런 다음 주문 테이블의 모든 내용을 검색하여 삭제 여부를 확인하시오.
 */

DELETE FROM 주문 
WHERE 주문일자 = '2019-05-22';

SELECT * FROM 주문;



/*
    주문 테이블에서 정소화 고객이 주문한 내역을 주문 테이블에서 삭제하시오.
    그런 다음 주문 테이블의 모든 내용을 검색하여 수정 내용을 확인하시오.
*/

DELETE FROM 주문
WHERE 주문고객 IN (SELECT 고객아이디
				FROM 고객
				WHERE 고객이름='정소화');

SELECT * FROM 주문;		


DELETE FROM 주문;






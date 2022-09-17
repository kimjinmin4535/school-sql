-- 부속 질의문을 이용한 검색

-- 달콤비스켓을 생산한 제조업체가 만든 제품들의 제품명과 단가를 검색하시오.


-- 부속질의문
SELECT 제조업체
FROM 제품
WHERE 제품명 = '달콤비스킷';

-- 상위질의문
SELECT 제품명, 단가
FROM 제품
WHERE 제조업체 = (SELECT 제조업체
				FROM 제품
				WHERE 제품명 = '달콤비스킷');

-- 적립금이 가장 많은 고객의 고객이름과 적립금을 검색하시오.
SELECT 고객이름, 적립금
FROM 고객
WHERE 적립금 = (SELECT MAX(적립금) 
				FROM 고객);

-- banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오.
SELECT 주문제품			
FROM 주문
WHERE 주문고객 = 'banana';
	
SELECT 제품명, 제조업체
FROM 제품
WHERE 제품번호 IN (SELECT 주문제품			
				FROM 주문
				WHERE 주문고객 = 'banana');
			
-- banana 고객이 주문하지 않은 제품의 제품명과 제조업체를 검색하시오.			
SELECT 제품명, 제조업체
FROM 제품
WHERE 제품번호 NOT IN (SELECT 주문제품			
					FROM 주문
					WHERE 주문고객 = 'banana');			
			
/*
 * 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체를 검색하시오.
 */		
SELECT 	제품명, 단가, 제조업체			
FROM 제품
WHERE 단가 > ALL (SELECT 단가			
				 FROM 제품
				 WHERE 제조업체 = '대한식품'
				)
;

-- 2019년 3월 15일에 제품을 주문한 고객의 고객이름을 검색하시오.
SELECT 고객이름
FROM 고객
WHERE EXISTS (SELECT *
				FROM 주문
				WHERE 주문일자 = '2019-03-15'
				AND 주문.주문고객 = 고객.고객아이디 );


SELECT *
FROM 주문,고객
WHERE 주문일자 = '2019-03-15'
		AND 주문.주문고객 = 고객.고객아이디 
;		

		
-- 2019년 3월 15일에 제품을 주문하지 않은 고객의 고객이름을 검색하시오.			
SELECT 고객이름
FROM 고객
WHERE NOT EXISTS (SELECT *
					FROM 주문
					WHERE 주문일자 = '2019-03-15'
					AND 주문.주문고객 = 고객.고객아이디 );			
			
			
				
INSERT INTO 고객
VALUES ('strawberry', '최유경', 30, 'vip', '공무원', 100);
COMMIT;
				
				
				
				
				
				
				
				
				
				
				
				
				
				
			

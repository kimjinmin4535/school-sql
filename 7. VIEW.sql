/*
 * 고객 테이블에서 등급이 vip인 고객의 고객아이디, 고개이름, 나이로 구성된 뷰를
 * 우수고객이라는 이름으로 생성하시오. 
 * 그럼 다음 우수고객 뷰의 모든 내용을 검색하시오.
 */
DROP VIEW 우수고객;
CREATE VIEW 우수고객 (고객아이디, 고객이름, 나이)
AS SELECT 고객아이디, 고객이름, 나이
	FROM 고객
	WHERE 등급 = 'vip'
WITH CHECK OPTION;

CREATE VIEW 우수고객 
AS SELECT 고객아이디, 고객이름, 나이
	FROM 고객
	WHERE 등급 = 'vip'
WITH CHECK OPTION;


SELECT *
FROM 우수고객;



/*
 * 제품 테이블에서 제조업체별 제품수로 구성된 뷰를 업체별제품수라는 이름으로 생성하시오.
 * 그런 다음 업체별제품수 뷰의 모든 내용을 검색하시오. 
 */
CREATE VIEW 업체별제품수 (제조업체, 제품수) 
AS SELECT 제조업체, COUNT(*) 
	FROM 제품
	GROUP BY 제조업체
WITH CHECK OPTION;

SELECT *
FROM 업체별제품수;

-- 우수고객 뷰에서 나이가 25살 이상인 고객에 대한 모든 내용을 검색하시오.
SELECT *
FROM 우수고객
WHERE 나이 >= 25;


CREATE VIEW 제품1
AS SELECT 제품번호, 재고량, 제조업체
	FROM 제품
WITH CHECK OPTION;	

SELECT * FROM 제품1;

CREATE VIEW 제품2
AS SELECT 제품명, 재고량, 제조업체
	FROM 제품
WITH CHECK OPTION;	

SELECT * FROM 제품2;


/*
 *  제품번호가 p08, 재고량이 1000, 제조업체가 신선식품인 새로운 제품의 정보를
 *  제품1 뷰에 삽입해시오.
 *  그런 다음 제품1뷰에 있는 모든 내용을 검색하시오.
 */

INSERT INTO 제품1 
VALUES ('p08', 1000, '신선식품');
COMMIT;

SELECT * FROM 제품1;

INSERT INTO 제품2 
VALUES ('시원냉면', 1000, '신선식품');




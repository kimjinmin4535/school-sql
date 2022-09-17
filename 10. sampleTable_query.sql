
SELECT 
		A.ORDER_ID 
		,B.ITEM_ID 
		,B.PRODUCT_ID 
		,B.QUANTITY 
		,B.UNIT_PRICE 
		,A.STATUS 
		,A.ORDER_DATE 
		,A.SALESMAN_ID 
FROM ORDERS A 
	,ORDER_ITEMS B 
WHERE A.ORDER_ID = B.ORDER_ID 
;


CREATE TABLE SALES AS
SELECT 
		A.ORDER_ID 
		,B.ITEM_ID 
		,B.PRODUCT_ID 
		,B.QUANTITY 
		,B.UNIT_PRICE 
		,A.STATUS 
		,A.ORDER_DATE 
		,A.SALESMAN_ID 
FROM ORDERS A 
	,ORDER_ITEMS B 
WHERE A.ORDER_ID = B.ORDER_ID 
;

DELETE 
FROM SALES s 
WHERE ORDER_ID = 1
AND ITEM_ID =1
;
COMMIT;

DELETE 
FROM SALES s 
WHERE ORDER_ID =1
;
COMMIT;

DELETE 
FROM SALES s 
;
COMMIT;


--INLINE VIEW 
SELECT A.*
FROM (
		SELECT 
				NAME 
				,CREDIT_LIMIT 
		FROM CUSTOMERS c 
) A
;



SELECT 
		NAME 
		,CREDIT_LIMIT 
FROM CUSTOMERS c 
;

SELECT A.*
FROM (
        SELECT A.*
        FROM (
                SELECT 
                        NAME 
                        ,CREDIT_LIMIT 
                FROM CUSTOMERS c 
        ) A
)A
;

/*
    연도별 각 고객의 매출 총금액을 구하시오.
    고객이름          연도        총금액
    
*/

SELECT
        c.name AS CUSTOMER
        , TO_CHAR(A.ORDER_DATE, 'YYYY') AS YEAR
        , SUM(b.quantity * b.unit_price) SALES_AMOUNT
FROM ORDERS A
    ,ORDER_ITEMS B
    ,CUSTOMERS C
WHERE 1=1
    AND A.STATUS = 'Shipped'
    AND A.ORDER_ID = B.ORDER_ID
    AND A.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY  C.NAME,  TO_CHAR(A.ORDER_DATE, 'YYYY')  
ORDER BY c.name
;
    
-- 뷰 생성 => 뷰를 만들면 SELECT문을 반복적으로 TYPING할 필요없이 해당 뷰를 SELECT하면 됨.
CREATE OR REPLACE VIEW CUSTOMER_SALES AS 
SELECT
        c.name AS CUSTOMER
        , TO_CHAR(A.ORDER_DATE, 'YYYY') AS YEAR
        , SUM(b.quantity * b.unit_price) SALES_AMOUNT
FROM ORDERS A
    ,ORDER_ITEMS B
    ,CUSTOMERS C
WHERE 1=1
    AND A.STATUS = 'Shipped'
    AND A.ORDER_ID = B.ORDER_ID
    AND A.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY  C.NAME,  TO_CHAR(A.ORDER_DATE, 'YYYY')  
ORDER BY c.name
;

SELECT *
 FROM CUSTOMER_SALES;
 
-- 고객별 2017년도 매출을 구하시오. 가장 매출이 높은순서로 구하시오.
-- 고객이름     총매출
SELECT 
    customer,
    sales_amount
FROM CUSTOMER_SALES
WHERE YEAR = 2017
ORDER BY sales_amount DESC;

-- 고객별 전체 매출 합계를 구하시오.가장 매출이 높은순서로 구하시오.
SELECT customer
        ,SUM(sales_amount) AS SUM_sales_amount
FROM CUSTOMER_SALES
GROUP BY CUSTOMER
ORDER BY SUM_sales_amount DESC
;




















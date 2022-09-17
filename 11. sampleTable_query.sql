-- 서브 쿼리
SELECT 
    MAX(list_price)
FROM PRODUCTS
;

-- list_price가 8867.99인 행을 출력하시오.
SELECT
    product_id
    ,product_name
    ,list_price
FROM PRODUCTS
WHERE LIST_PRICE = 8867.99
;


-- 서브쿼리를 이용해서 list_price가 최대값인 행을 출력
SELECT
    product_id
    ,product_name
    ,list_price
FROM PRODUCTS
WHERE LIST_PRICE = (
                        SELECT 
                            MAX(list_price)
                        FROM PRODUCTS
                    )
;

-- 스칼라 서브쿼리 
/*
    각 제품의 가격을 구하면서 
    해당 제품이 위치하고 있는 제품 카테고리의 평균 가격도 같이 구하시오.
    
    PRODUCT_NAME       LIST_PRICE                AVG_LIST_PRICE
*/


SELECT 
        a.product_name
        ,a.list_price
        ,ROUND((
                SELECT AVG(k.list_price)
                FROM PRODUCTS K
                WHERE K.CATEGORY_ID = A.CATEGORY_ID
        ) ,2) AVG_LIST_PRICE
FROM PRODUCTS A 
ORDER BY a.product_name
;    


-- 인라인 뷰 서브 쿼리
SELECT ORDER_ID 
		,SUM(QUANTITY * UNIT_PRICE) ORDER_VALUE 
FROM ORDER_ITEMS oi 
GROUP BY ORDER_ID 
ORDER BY ORDER_VALUE DESC 
;

SELECT ORDER_ID 
		,ORDER_VALUE
FROM
(
	SELECT ORDER_ID 
			,SUM(QUANTITY * UNIT_PRICE) ORDER_VALUE 
	FROM ORDER_ITEMS oi 
	GROUP BY ORDER_ID 
	ORDER BY ORDER_VALUE DESC 
)
WHERE ROWNUM <= 10
;

/*
 *  결과값 일부 조회
 * 		- ROWNUM (가상줄번호)
 * 			- SQL 퀄리 결과 중 상위 몇 개만 보여주는 쿼리
 */

































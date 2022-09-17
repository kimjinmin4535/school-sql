-- ���� ����
SELECT 
    MAX(list_price)
FROM PRODUCTS
;

-- list_price�� 8867.99�� ���� ����Ͻÿ�.
SELECT
    product_id
    ,product_name
    ,list_price
FROM PRODUCTS
WHERE LIST_PRICE = 8867.99
;


-- ���������� �̿��ؼ� list_price�� �ִ밪�� ���� ���
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

-- ��Į�� �������� 
/*
    �� ��ǰ�� ������ ���ϸ鼭 
    �ش� ��ǰ�� ��ġ�ϰ� �ִ� ��ǰ ī�װ��� ��� ���ݵ� ���� ���Ͻÿ�.
    
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


-- �ζ��� �� ���� ����
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
 *  ����� �Ϻ� ��ȸ
 * 		- ROWNUM (�����ٹ�ȣ)
 * 			- SQL ���� ��� �� ���� �� ���� �����ִ� ����
 */

































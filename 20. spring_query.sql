-- ���� ���̺� ����
DROP TABLE cust_account CASCADE CONSTRAINTS;
CREATE TABLE cust_account (
	accountNo	varchar2(20) PRIMARY KEY 	-- ���¹�ȣ
	,custName	varchar2(50)				-- ������
	,balance	number(20,4)				-- ���� �ܰ� 
);

INSERT INTO EZEN.CUST_ACCOUNT
(ACCOUNTNO, CUSTNAME, BALANCE)
VALUES('2022-07-060219', '�̼���', 10000000);

INSERT INTO EZEN.CUST_ACCOUNT
(ACCOUNTNO, CUSTNAME, BALANCE)
VALUES('2022-08-080220', '�Ż��Ӵ�', 10000000);

COMMIT;

SELECT *
FROM CUST_ACCOUNT 
;

UPDATE CUST_ACCOUNT 
SET BALANCE = BALANCE - 5000000
WHERE ACCOUNTNO = '2022-07-060219'
;

UPDATE CUST_ACCOUNT 
SET BALANCE = BALANCE + 5000000
WHERE ACCOUNTNO = '2022-08-080220'
;

ROLLBACK;

SELECT * FROM T_MEMBER
WHERE ID = 'android' AND PWD = '0826'
;


-- �Խ��� ���̺�
DROP TABLE t_board CASCADE CONSTRAINTS
;
CREATE TABLE t_board (
	articleNO		number(10)	PRIMARY KEY 
	,parentNO		number(10) 	DEFAULT 0
	,title			varchar2(500)	NOT NULL
	,content		varchar2(4000)
	,imageFileName	varchar2(100)
	,writeDate		DATE		DEFAULT sysdate NOT NULL
	,id				varchar2(10)
	,CONSTRAINT FK_ID FOREIGN KEY (id) REFERENCES t_member (id)
)
;


INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(1, 0, '�帶ö', '�帶ö �Դϴ�.', null, sysdate , 'lee')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(2, 0, '�ȳ�', '�ȳ��ϼ��� ��ǰ�ı��Դϴ�.', null, sysdate , 'hong')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(3, 2, '�亯�Դϴ�', '��ǰ�ı⿡ ���� �亯�Դϴ�.', null, sysdate , 'hong')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(4, 0, '�Ż��Ӵ��Դϴ�', '�Ż��Ӵ� �׽�Ʈ �Դϴ�.', null, sysdate , 'shin')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(5, 3, '�亯�Դϴ�', '��ǰ�� �����ϴ�.', null, sysdate , 'lee')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(6, 2, '��ǰ �ı��Դϴ�', 'ȫ�浿 ��ǰ ��� �ı��Դϴ�.', null, sysdate , 'lee')
;

COMMIT;

SELECT *
FROM T_BOARD
;

-- �۸�� ��ȸ

SELECT LEVEL
	,ARTICLENO 
	,PARENTNO 
	,lpad(' ', 4*(LEVEL-1)) || TITLE title 
	,CONTENT 
	,WRITEDATE 
	,ID 
FROM T_BOARD 
START WITH PARENTNO=0			-- ������ �������� �ֻ��� �ο�(row)�� �ĺ��ϴ� ���� (�� �θ� �ۺ��� ����)
CONNECT BY PRIOR ARTICLENO = PARENTNO 		-- ���������� ��� ������ ����Ǵ��� �����
ORDER siblings BY ARTICLENO DESC 
;


SELECT nvl(MAX(ARTICLENO),0) + 1 FROM T_BOARD
;

INSERT INTO T_BOARD (ARTICLENO, TITLE, CONTENT, IMAGEFILENAME, ID)
VALUES ('7','�ݿ���','���� �ʺ��Դϴ�.', NULL, 'lee')
;

ROLLBACK;


-- ���� ���� ���ε�
DROP TABLE t_imageFile CASCADE CONSTRAINTS;
CREATE TABLE t_imageFile (
	imageFileNO		number(10)	PRIMARY key
	,imageFileName	varchar2(50)
	,regDate	DATE DEFAULT sysdate
	,articleNO	number(10)
	,CONSTRAINT FK_articleNO FOREIGN key(articleNo) REFERENCES t_board(articleNO)
	 ON DELETE CASCADE	-- �Խ��� ���� ������ ��� �ش� �۹�ȣ�� �����ϴ� �̹��� ������ �ڵ����� ������
);


SELECT nvl(MAX(imageFileNO),0) FROM T_IMAGEFILE;

SELECT * FROM T_BOARD
WHERE ARTICLENO = '12'
;

SELECT *
FROM t_imageFile
;


-- �Խñۿ� ���� �̹��� ���� ��� ��ȸ
SELECT * FROM T_IMAGEFILE
WHERE ARTICLENO = 12
ORDER BY IMAGEFILENO 
;


-- �Խñ� ����
UPDATE T_BOARD 
	SET TITLE = '�帶3'
		,CONTENT = '�����̾� ���õ� �� ���׿�...'
	WHERE ARTICLENO = 14
;
ROLLBACK;


-- �Խñ� �����̹��� ����
UPDATE T_IMAGEFILE 
	SET IMAGEFILENAME = 'abc.jpg'
WHERE 
	ARTICLENO = 12 AND IMAGEFILENO = 7
;
ROLLBACK
;

DELETE FROM T_BOARD
WHERE ARTICLENO = 23
;
ROLLBACK
;

DELETE FROM T_IMAGEFILE
WHERE ARTICLENO = 23
AND IMAGEFILENO = 16
;
ROLLBACK
;

DELETE FROM T_IMAGEFILE
WHERE ARTICLENO = 24
AND IMAGEFILENO = 19
;
ROLLBACK
;

-- �� �׷����� ��ȸ�ϱ� 
SELECT DISTINCT GROUPNO FROM T_BOARD2
ORDER BY GROUPNO DESC 
;

-- ������ ���ȣ�� ���ÿ� ��ȸ�ϱ�
SELECT rowNum AS recNum, GROUPNO
FROM (
	SELECT DISTINCT GROUPNO FROM T_BOARD2
	ORDER BY GROUPNO DESC 
)
;

-- rowNum �ʵ尪�� �̿��ؼ� 1���� 10������ ���ڵ常 ��ȸ�ϱ�
SELECT recNum, groupno
FROM (
		SELECT rowNum AS recNum, GROUPNO
		FROM (
			SELECT DISTINCT GROUPNO FROM T_BOARD2
			ORDER BY GROUPNO DESC 
		)
	 )
WHERE recNum BETWEEN 1 AND 10 
;

SELECT * FROM T_BOARD2
WHERE GROUPNO IN (
	SELECT GROUPNO 
	FROM (
		SELECT recNum, groupno
		FROM (
				SELECT rowNum AS recNum, GROUPNO
				FROM (
					SELECT DISTINCT GROUPNO FROM T_BOARD2
					ORDER BY GROUPNO DESC 
				)
			 )
		WHERE recNum BETWEEN 1 AND 10 
		)
)
;





-- ������ SQL������ ���� �������� ��ȸ
SELECT groupno
		,LEVEL AS lvl
		,articleno
		,parentno
		,title
		,id 
		,writedate
FROM (
		SELECT * FROM T_BOARD2
		WHERE GROUPNO IN (
			SELECT GROUPNO 
			FROM (
				SELECT recNum, groupno
				FROM (
						SELECT rowNum AS recNum, GROUPNO
						FROM (
							SELECT DISTINCT GROUPNO FROM T_BOARD2
							ORDER BY GROUPNO DESC 
						)
					 )
				WHERE recNum BETWEEN 1 AND 10 
				)
		 )		
	 )
 	START WITH PARENTNO=0			
	CONNECT BY PRIOR ARTICLENO = PARENTNO 		
	ORDER siblings BY ARTICLENO DESC 
;	 




SELECT groupno
		,lvl
		,articleno
		,parentno
		,title
		,id
		,writedate		
	FROM (
			SELECT groupno
					,LEVEL AS lvl
					,articleno
					,parentno
					,title
					,id 
					,writedate
			FROM (
					SELECT * FROM T_BOARD2
					WHERE GROUPNO IN (
						SELECT GROUPNO 
						FROM (
							SELECT recNum, groupno
							FROM (
									SELECT rowNum AS recNum, GROUPNO
									FROM (
										SELECT DISTINCT GROUPNO FROM T_BOARD2
										ORDER BY GROUPNO DESC 
									)
								 )
							WHERE recNum BETWEEN 1 AND 10 
							)
					 )		
				 )
			 	START WITH PARENTNO=0			
				CONNECT BY PRIOR ARTICLENO = PARENTNO 		
				ORDER siblings BY ARTICLENO DESC 	
		)
;

SELECT * FROM (
				SELECT groupno
						,lvl
						,articleno
						,parentno
						,title
						,id
						,writedate		
					FROM (
							SELECT groupno
									,LEVEL AS lvl
									,articleno
									,parentno
									,title
									,id 
									,writedate
							FROM (
									SELECT * FROM T_BOARD2
									WHERE GROUPNO IN (
										SELECT GROUPNO 
										FROM (
											SELECT recNum, groupno
											FROM (
													SELECT rowNum AS recNum, GROUPNO
													FROM (
														SELECT DISTINCT GROUPNO FROM T_BOARD2
														ORDER BY GROUPNO DESC 
													)
												 )
											WHERE recNum BETWEEN 1 AND 10 
											)
									 )		
								 )
							 	START WITH PARENTNO=0			
								CONNECT BY PRIOR ARTICLENO = PARENTNO 		
								ORDER siblings BY ARTICLENO DESC 	
						)
			)
;




SELECT count(DISTINCT GROUPNO) FROM T_BOARD2
;



-- ��ȸ�� ������Ʈ
UPDATE T_BOARD2 
SET VIEWCOUNTS = VIEWCOUNTS + 1
WHERE ARTICLENO = 15
;
ROLLBACK
;































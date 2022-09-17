-- 계좌 테이블 생성
DROP TABLE cust_account CASCADE CONSTRAINTS;
CREATE TABLE cust_account (
	accountNo	varchar2(20) PRIMARY KEY 	-- 계좌번호
	,custName	varchar2(50)				-- 예금자
	,balance	number(20,4)				-- 계좌 잔고 
);

INSERT INTO EZEN.CUST_ACCOUNT
(ACCOUNTNO, CUSTNAME, BALANCE)
VALUES('2022-07-060219', '이순신', 10000000);

INSERT INTO EZEN.CUST_ACCOUNT
(ACCOUNTNO, CUSTNAME, BALANCE)
VALUES('2022-08-080220', '신사임당', 10000000);

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


-- 게시판 테이블
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
VALUES(1, 0, '장마철', '장마철 입니다.', null, sysdate , 'lee')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(2, 0, '안녕', '안녕하세요 상품후기입니다.', null, sysdate , 'hong')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(3, 2, '답변입니다', '상품후기에 대한 답변입니다.', null, sysdate , 'hong')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(4, 0, '신사임당입니다', '신사임당 테스트 입니다.', null, sysdate , 'shin')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(5, 3, '답변입니다', '상품이 좋습니다.', null, sysdate , 'lee')
;

INSERT INTO EZEN.T_BOARD
(articleNO, parentNO, TITLE, CONTENT, IMAGEFILENAME, WRITEDATE, ID)
VALUES(6, 2, '상품 후기입니다', '홍길동 상품 사용 후기입니다.', null, sysdate , 'lee')
;

COMMIT;

SELECT *
FROM T_BOARD
;

-- 글목록 조회

SELECT LEVEL
	,ARTICLENO 
	,PARENTNO 
	,lpad(' ', 4*(LEVEL-1)) || TITLE title 
	,CONTENT 
	,WRITEDATE 
	,ID 
FROM T_BOARD 
START WITH PARENTNO=0			-- 계층형 구조에서 최상위 로우(row)를 식별하는 조건 (즉 부모 글부터 시작)
CONNECT BY PRIOR ARTICLENO = PARENTNO 		-- 계층구조가 어떻게 식으로 연결되는지 기술함
ORDER siblings BY ARTICLENO DESC 
;


SELECT nvl(MAX(ARTICLENO),0) + 1 FROM T_BOARD
;

INSERT INTO T_BOARD (ARTICLENO, TITLE, CONTENT, IMAGEFILENAME, ID)
VALUES ('7','금요일','내일 초복입니다.', NULL, 'lee')
;

ROLLBACK;


-- 다중 파일 업로드
DROP TABLE t_imageFile CASCADE CONSTRAINTS;
CREATE TABLE t_imageFile (
	imageFileNO		number(10)	PRIMARY key
	,imageFileName	varchar2(50)
	,regDate	DATE DEFAULT sysdate
	,articleNO	number(10)
	,CONSTRAINT FK_articleNO FOREIGN key(articleNo) REFERENCES t_board(articleNO)
	 ON DELETE CASCADE	-- 게시판 글을 삭제할 경우 해당 글번호를 참조하는 이미지 정보도 자동으로 삭제됨
);


SELECT nvl(MAX(imageFileNO),0) FROM T_IMAGEFILE;

SELECT * FROM T_BOARD
WHERE ARTICLENO = '12'
;

SELECT *
FROM t_imageFile
;


-- 게시글에 대한 이미지 파일 목록 조회
SELECT * FROM T_IMAGEFILE
WHERE ARTICLENO = 12
ORDER BY IMAGEFILENO 
;


-- 게시글 수정
UPDATE T_BOARD 
	SET TITLE = '장마3'
		,CONTENT = '어제이어 오늘도 비가 오네요...'
	WHERE ARTICLENO = 14
;
ROLLBACK;


-- 게시글 기존이미지 수정
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

-- 글 그룹으로 조회하기 
SELECT DISTINCT GROUPNO FROM T_BOARD2
ORDER BY GROUPNO DESC 
;

-- 각각의 행번호를 동시에 조회하기
SELECT rowNum AS recNum, GROUPNO
FROM (
	SELECT DISTINCT GROUPNO FROM T_BOARD2
	ORDER BY GROUPNO DESC 
)
;

-- rowNum 필드값를 이용해서 1에서 10까지의 레코드만 조회하기
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





-- 계층형 SQL문으로 글을 계층별로 조회
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



-- 조회수 업데이트
UPDATE T_BOARD2 
SET VIEWCOUNTS = VIEWCOUNTS + 1
WHERE ARTICLENO = 15
;
ROLLBACK
;































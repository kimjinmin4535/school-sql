-- 회원 테이블 생성 
/*
1	ID	id	varchar2	10
2	비밀번호	pwd	varchar2	10
3	이름	name	varchar2	50
4	이메일	email	varchar2	50
5	가입일자	joinDate	date	 * 
 */ 

DROP TABLE t_member CASCADE CONSTRAINT
;
CREATE TABLE t_member
(
	id		varchar2(10)		PRIMARY KEY
	,pwd	varchar2(10)
	,name	varchar2(50)
	,email	varchar2(50)
	,joinDate	DATE DEFAULT sysdate 
)
;

-- 회원 정보 추가
INSERT INTO T_MEMBER VALUES ('lee', '0824', '이순신', 'lee@gmail.com', sysdate)
;
INSERT INTO T_MEMBER VALUES ('hong', '0824', '홍길동', 'hong@gmail.com', sysdate)
;
INSERT INTO T_MEMBER VALUES ('shin', '0824', '신사임당', 'shin@gmail.com', sysdate)
;
INSERT INTO T_MEMBER (id, PWD, NAME, EMAIL) 
VALUES ('test', '0824', '테스트', 'test@gmail.com');

INSERT INTO T_MEMBER VALUES ('android', '0826', '안드로이드', 'android@gmail.com', sysdate)
;


UPDATE T_MEMBER 
SET PWD = '0826', NAME = '이젠05', EMAIL = 'ezen05@gmail.com'
WHERE ID = 'ezen5'
;

DELETE FROM T_MEMBER 
WHERE ID = 'ezen5'
;


ROLLBACK;
COMMIT;

SELECT * FROM T_MEMBER
;

SELECT * FROM T_MEMBER ORDER BY JOINDATE DESC 
;

SELECT NAME FROM T_MEMBER WHERE ID = 'lee'
;

SELECT PWD FROM T_MEMBER WHERE ID = 'lee'
;

DELETE FROM T_MEMBER WHERE ID = 'ezen'
;
ROLLBACK;


SELECT DECODE(COUNT(*),1,'true','false') AS RESULT FROM T_MEMBER
WHERE ID = 'lee' AND PWD = '0824'
;





-- 테이블 및 시퀀스 생성 
DROP TABLE MEMBER CASCADE CONSTRAINTS;
CREATE TABLE MEMBER (
	id 	varchar2(10) NOT NULL
	,pass varchar2(10) NOT NULL
	,name varchar2(30) NOT NULL 
	,regidate DATE DEFAULT sysdate NOT NULL
	,PRIMARY KEY (id)
)
;

INSERT INTO "MEMBER" (id, PASS, NAME)
VALUES ('ezen', '0824', '이젠')
;

INSERT INTO "MEMBER" (id, PASS, NAME)
VALUES ('lee', '0824', '이순신')
;
COMMIT;

SELECT * FROM "MEMBER" WHERE id = 'ezen' AND PASS = '0824'
;

DROP TABLE board CASCADE CONSTRAINTS;
CREATE TABLE board (
	num		NUMBER				PRIMARY KEY
	, title	varchar2(200)		NOT NULL 
	, content varchar2(2000)	NOT NULL 
	, id 	varchar2(10)		NOT NULL 
	, postdate	DATE	DEFAULT sysdate NOT NULL
	, visitcount	number(6)	
)
;

-- 외래키로 테이블 사이의 관계 설정 
-- board 테이블의 id 컬럼이 member 테이블의 id컬럼을 참조하도록 해주는 외래키 생성
ALTER TABLE BOARD 
	ADD CONSTRAINT board_member_fk FOREIGN KEY (id)
	REFERENCES MEMBER (id)
;	
COMMIT;

-- 일련번호형 시퀀스(Sequence) 객체 생성 
-- 순차적으로 증가하는 순번을 반환하는 데이터베이스 객체임.
DROP SEQUENCE seq_board_num;
CREATE SEQUENCE seq_board_num
	INCREMENT BY 1					-- 1씩 증가
	START WITH 1					-- 시작값 1
	MINVALUE 1						-- 최소값 1
	nomaxvalue						-- 최대값은 무한대
	nocycle							-- 순환하지 않음 
	nocache							-- 캐시 안 함 
; 


INSERT INTO BOARD VALUES (seq_board_num.nextval, '오늘은 6월 2째주', '월요일같은 화요일입니다. 중략...',
		'ezen', sysdate, 0)
;		
INSERT INTO BOARD VALUES (seq_board_num.nextval, '2022년 절반이 감', '어드넛 올해도 절반이 지나가네요...',
		'ezen', sysdate, 0)
;	
INSERT INTO BOARD VALUES (seq_board_num.nextval, '신논현역 분당선 개통', '공사가 다 마무리되어서 인도가 넓어졌으나 건물공사가 한쪽에서...',
		'ezen', sysdate, 0)
;	
INSERT INTO BOARD VALUES (seq_board_num.nextval, '에이프로 스퀘어 건물', '이 건물 1층 톰앤톰 커피점이 없어지고 어떤 가게가 들어올까요?',
		'ezen', sysdate, 0)
;	
COMMIT;

SELECT * FROM BOARD ORDER BY num DESC 
;

SELECT *
FROM BOARD
WHERE title LIKE '%오늘%'
;

SELECT *
FROM BOARD
WHERE content LIKE '%월%'
;

SELECT COUNT(*) FROM BOARD WHERE title LIKE '%오늘%'
;

SELECT COUNT(*) FROM BOARD WHERE content LIKE '%월%'
;

SELECT b.*, m.NAME 
FROM "MEMBER" m 
INNER JOIN BOARD b ON m.ID = b.ID 
WHERE num = 8
;


UPDATE BOARD SET VISITCOUNT = VISITCOUNT + 1
WHERE NUM = 1
;
COMMIT
;

UPDATE BOARD SET TITLE = '인테리어 변경', CONTENT = '어서 마무리가 되어야될테데요.'
WHERE NUM = 9
;
COMMIT;

DELETE FROM BOARD b WHERE NUM = 8;
COMMIT;


SELECT DECODE(COUNT(*),1,'true','false') AS result FROM T_MEMBER
WHERE id = 'lee'
;


/*  모델2(MVC) 방식 파일첨부형 게시판 테이블
idx	number
name	varchar2(50)
title	varchar2(200)
content	varchar2(2000)
postdate	date
ofile	varchar2(200)
sfile	varchar2(30)
download	number
pass	varchar2(50)
visitcount	number * 
 */
DROP TABLE mvcboard CASCADE CONSTRAINTS;
CREATE TABLE mvcboard (
	idx			NUMBER		PRIMARY KEY
	,name		varchar2(50) NOT NULL
	,title  	varchar2(200) NOT NULL
	,content	varchar2(2000) NOT NULL 
	,postdate 	DATE DEFAULT sysdate NOT NULL 
	,ofile		varchar2(200)
	,sfile		varchar2(30)
	,download	NUMBER DEFAULT 0 NOT NULL 
	,pass		varchar2(50) NOT NULL 
	,visitcount	NUMBER DEFAULT 0 NOT NULL 
);

INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화','박해일 주연으로 7월말 상영예정입니다', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화2','박해일 주연으로 7월말 상영예정입니다2', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화3','박해일 주연으로 7월말 상영예정입니다3', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화4','박해일 주연으로 7월말 상영예정입니다4', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화5','박해일 주연으로 7월말 상영예정입니다5', 
'0824');

INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화6','박해일 주연으로 7월말 상영예정입니다6', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화7','박해일 주연으로 7월말 상영예정입니다7', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화8','박해일 주연으로 7월말 상영예정입니다8', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화9','박해일 주연으로 7월말 상영예정입니다9', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화10','박해일 주연으로 7월말 상영예정입니다10', 
'0824');

INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화11','박해일 주연으로 7월말 상영예정입니다11', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화12','박해일 주연으로 7월말 상영예정입니다12', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화13','박해일 주연으로 7월말 상영예정입니다13', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화14','박해일 주연으로 7월말 상영예정입니다14', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '이순신', '한산영화15','박해일 주연으로 7월말 상영예정입니다15', 
'0824');


COMMIT;


SELECT ID , PASS , rownum 
FROM "MEMBER"
;

SELECT id, pwd, rownum FROM T_MEMBER
;


-- 페이징 처리 쿼리문 
SELECT * FROM MVCBOARD ORDER BY idx DESC 
;

SELECT tb.*, rownum rNum FROM (
	SELECT * FROM MVCBOARD ORDER BY idx DESC
) tb 
;

SELECT * FROM (
	SELECT tb.*, rownum rNum FROM (
		SELECT * FROM MVCBOARD ORDER BY idx DESC
	) tb 
)
WHERE rNum BETWEEN 1 AND 10
;


SELECT * FROM (
	SELECT tb.*, rownum rNum FROM (
		SELECT * FROM MVCBOARD ORDER BY idx DESC
	) tb 
)
WHERE rNum BETWEEN 11 AND 20
;

SELECT * FROM MVCBOARD WHERE IDX = '32'
;

UPDATE MVCBOARD SET VISITCOUNT = VISITCOUNT + 1
WHERE IDX = '32'
;
COMMIT;

UPDATE MVCBOARD SET DOWNLOAD = DOWNLOAD + 1
WHERE IDX = '32'
;
COMMIT;

SELECT COUNT(*) FROM MVCBOARD WHERE PASS = 0824 AND IDX = '35'
;

DELETE FROM MVCBOARD WHERE IDX = '35'
;
ROLLBACK;

UPDATE MVCBOARD 
SET TITLE ='', NAME = '', CONTENT = '', OFILE = '', SFILE =''
WHERE IDX = '' AND PASS = ''
;

UPDATE MVCBOARD 
SET TITLE ='여름비2', NAME = '이방원2', CONTENT = '비가 오고 있습니다.2',
OFILE = 'icon22.png', SFILE =''
WHERE IDX = '' AND PASS = '20220623_123069862222.png'
;
ROLLBACK;








-- 파일 업로드와 다운로드용 테이블 생성
/*
 idx	number
name	varchar2(50)
title	varchar2(200)
cate	varchar2(30)
ofile	varchar2(100)
sfile	varchar2(30)
postdate	date* 
 */
DROP TABLE myfile CASCADE CONSTRAINTS;
CREATE TABLE myfile (
	idx	NUMBER		PRIMARY KEY
	,name	varchar2(50) NOT NULL
	,title	varchar2(200) NOT NULL
	,cate	varchar2(30) 
	,ofile	varchar2(100) NOT NULL 
	,sfile	varchar2(30) NOT NULL 
	,postdate DATE DEFAULT sysdate NOT NULL 
)
;

INSERT INTO EZEN.MYFILE
(IDX, NAME, TITLE, CATE, OFILE, SFILE) 
VALUES(seq_board_num.nextval, '이젠IT', '하지', '사진', 'test.jpg', '20220621.jpg' )
;
ROLLBACK;


SELECT * FROM MYFILE ORDER BY IDX DESC 
;















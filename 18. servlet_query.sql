-- ȸ�� ���̺� ���� 
/*
1	ID	id	varchar2	10
2	��й�ȣ	pwd	varchar2	10
3	�̸�	name	varchar2	50
4	�̸���	email	varchar2	50
5	��������	joinDate	date	 * 
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

-- ȸ�� ���� �߰�
INSERT INTO T_MEMBER VALUES ('lee', '0824', '�̼���', 'lee@gmail.com', sysdate)
;
INSERT INTO T_MEMBER VALUES ('hong', '0824', 'ȫ�浿', 'hong@gmail.com', sysdate)
;
INSERT INTO T_MEMBER VALUES ('shin', '0824', '�Ż��Ӵ�', 'shin@gmail.com', sysdate)
;
INSERT INTO T_MEMBER (id, PWD, NAME, EMAIL) 
VALUES ('test', '0824', '�׽�Ʈ', 'test@gmail.com');

INSERT INTO T_MEMBER VALUES ('android', '0826', '�ȵ���̵�', 'android@gmail.com', sysdate)
;


UPDATE T_MEMBER 
SET PWD = '0826', NAME = '����05', EMAIL = 'ezen05@gmail.com'
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





-- ���̺� �� ������ ���� 
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
VALUES ('ezen', '0824', '����')
;

INSERT INTO "MEMBER" (id, PASS, NAME)
VALUES ('lee', '0824', '�̼���')
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

-- �ܷ�Ű�� ���̺� ������ ���� ���� 
-- board ���̺��� id �÷��� member ���̺��� id�÷��� �����ϵ��� ���ִ� �ܷ�Ű ����
ALTER TABLE BOARD 
	ADD CONSTRAINT board_member_fk FOREIGN KEY (id)
	REFERENCES MEMBER (id)
;	
COMMIT;

-- �Ϸù�ȣ�� ������(Sequence) ��ü ���� 
-- ���������� �����ϴ� ������ ��ȯ�ϴ� �����ͺ��̽� ��ü��.
DROP SEQUENCE seq_board_num;
CREATE SEQUENCE seq_board_num
	INCREMENT BY 1					-- 1�� ����
	START WITH 1					-- ���۰� 1
	MINVALUE 1						-- �ּҰ� 1
	nomaxvalue						-- �ִ밪�� ���Ѵ�
	nocycle							-- ��ȯ���� ���� 
	nocache							-- ĳ�� �� �� 
; 


INSERT INTO BOARD VALUES (seq_board_num.nextval, '������ 6�� 2°��', '�����ϰ��� ȭ�����Դϴ�. �߷�...',
		'ezen', sysdate, 0)
;		
INSERT INTO BOARD VALUES (seq_board_num.nextval, '2022�� ������ ��', '���� ���ص� ������ �������׿�...',
		'ezen', sysdate, 0)
;	
INSERT INTO BOARD VALUES (seq_board_num.nextval, '�ų����� �д缱 ����', '���簡 �� �������Ǿ �ε��� �о������� �ǹ����簡 ���ʿ���...',
		'ezen', sysdate, 0)
;	
INSERT INTO BOARD VALUES (seq_board_num.nextval, '�������� ������ �ǹ�', '�� �ǹ� 1�� ����� Ŀ������ �������� � ���԰� ���ñ��?',
		'ezen', sysdate, 0)
;	
COMMIT;

SELECT * FROM BOARD ORDER BY num DESC 
;

SELECT *
FROM BOARD
WHERE title LIKE '%����%'
;

SELECT *
FROM BOARD
WHERE content LIKE '%��%'
;

SELECT COUNT(*) FROM BOARD WHERE title LIKE '%����%'
;

SELECT COUNT(*) FROM BOARD WHERE content LIKE '%��%'
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

UPDATE BOARD SET TITLE = '���׸��� ����', CONTENT = '� �������� �Ǿ�ߵ��׵���.'
WHERE NUM = 9
;
COMMIT;

DELETE FROM BOARD b WHERE NUM = 8;
COMMIT;


SELECT DECODE(COUNT(*),1,'true','false') AS result FROM T_MEMBER
WHERE id = 'lee'
;


/*  ��2(MVC) ��� ����÷���� �Խ��� ���̺�
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
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ','������ �ֿ����� 7���� �󿵿����Դϴ�', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ2','������ �ֿ����� 7���� �󿵿����Դϴ�2', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ3','������ �ֿ����� 7���� �󿵿����Դϴ�3', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ4','������ �ֿ����� 7���� �󿵿����Դϴ�4', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ5','������ �ֿ����� 7���� �󿵿����Դϴ�5', 
'0824');

INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ6','������ �ֿ����� 7���� �󿵿����Դϴ�6', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ7','������ �ֿ����� 7���� �󿵿����Դϴ�7', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ8','������ �ֿ����� 7���� �󿵿����Դϴ�8', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ9','������ �ֿ����� 7���� �󿵿����Դϴ�9', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ10','������ �ֿ����� 7���� �󿵿����Դϴ�10', 
'0824');

INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ11','������ �ֿ����� 7���� �󿵿����Դϴ�11', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ12','������ �ֿ����� 7���� �󿵿����Դϴ�12', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ13','������ �ֿ����� 7���� �󿵿����Դϴ�13', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ14','������ �ֿ����� 7���� �󿵿����Դϴ�14', 
'0824');
INSERT INTO EZEN.MVCBOARD(IDX, NAME, TITLE, CONTENT, PASS)
VALUES(seq_board_num.nextval, '�̼���', '�ѻ꿵ȭ15','������ �ֿ����� 7���� �󿵿����Դϴ�15', 
'0824');


COMMIT;


SELECT ID , PASS , rownum 
FROM "MEMBER"
;

SELECT id, pwd, rownum FROM T_MEMBER
;


-- ����¡ ó�� ������ 
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
SET TITLE ='������2', NAME = '�̹��2', CONTENT = '�� ���� �ֽ��ϴ�.2',
OFILE = 'icon22.png', SFILE =''
WHERE IDX = '' AND PASS = '20220623_123069862222.png'
;
ROLLBACK;








-- ���� ���ε�� �ٿ�ε�� ���̺� ����
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
VALUES(seq_board_num.nextval, '����IT', '����', '����', 'test.jpg', '20220621.jpg' )
;
ROLLBACK;


SELECT * FROM MYFILE ORDER BY IDX DESC 
;















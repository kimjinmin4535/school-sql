-- ezenStore 프로젝트 멤버 테이블
DROP TABLE tb_shopping_member CASCADE CONSTRAINTS;
CREATE TABLE tb_shopping_member (
	member_id		varchar2(20 byte) PRIMARY KEY 
	,member_pw		varchar2(30 byte)
	,member_name	varchar2(50 byte)
	,member_gender	varchar2(10 byte)
	,hp1			varchar2(20 byte)
	,hp2			varchar2(20 byte)
	,hp3			varchar2(20 byte)
	,smssts_yn		varchar2(20 byte)
	,email1			varchar2(20 byte)
	,email2			varchar2(20 byte)
	,emailsts_yn	varchar2(20 byte)
	,zipcode		varchar2(20 byte)
	,roadaddress	varchar2(500 byte)
	,jibunaddress	varchar2(500 byte)
	,namujiaddress	varchar2(500 byte)
	,member_birth_y	varchar2(20 byte)
	,member_birth_m varchar2(20 byte) 
	,member_birth_d varchar2(20 byte) 
	,member_birth_gn varchar2(20 byte)
	,joindate		DATE  DEFAULT sysdate 
	,del_yn			varchar2(20 byte) DEFAULT 'N'
)
;

INSERT INTO EZEN.TB_SHOPPING_MEMBER
(MEMBER_ID, MEMBER_PW, MEMBER_NAME, MEMBER_GENDER, HP1, HP2, HP3, SMSSTS_YN, EMAIL1, EMAIL2, EMAILSTS_YN, ZIPCODE, ROADADDRESS, JIBUNADDRESS, NAMUJIADDRESS, MEMBER_BIRTH_Y, MEMBER_BIRTH_M, MEMBER_BIRTH_D, MEMBER_BIRTH_GN, JOINDATE, DEL_YN)
VALUES('ezen', '0824', '이젠', '101', '010', '3452', '6577', 'Y', 'ezen', 'gmail.com,non', 'Y', '220718', '서울 서초구 서초대로 77길 55', '', '에이프로 스퀘어 3층', '1999', '7', '17', '2','2022-07-18','N');
COMMIT;

SELECT DECODE(COUNT(*), 1, 'true', 0, 'false') 
FROM TB_SHOPPING_MEMBER
WHERE MEMBER_ID = 'ezen1'
;









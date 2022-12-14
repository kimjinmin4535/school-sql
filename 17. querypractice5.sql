-- 부서명이 지원팀인 직원의 사원번호, 사원명, 부서코드, 부서명을 출력하시오.
/*
 *  (최소) 조인조건의 개수 = 조인되는 테이블 수 - 1 
 *     1    =               2 - 1
 * 	   2	=			    3 - 1
 *     3    =               4 - 1
 *                  
 */
SELECT A.EMP_NO 
		,A.EMP_NAME 
		,A.DEPT_CD 
		,B.DEPT_NM 
FROM TB_EMP A
	,TB_DEPT B
WHERE A.DEPT_CD = B.DEPT_CD 
AND B.DEPT_NM = '지원팀'
;


-- INNER JOIN
-- 주소가 수원인 직원의 사원번호, 사원명, 주소, 부서코드, 부서명을 출력하시오.
SELECT A.EMP_NO 
	  ,A.EMP_NAME 
	  ,A.ADDR 
	  ,B.DEPT_CD 
	  ,B.DEPT_NM 
FROM TB_EMP A, TB_DEPT B
WHERE A.DEPT_CD = B.DEPT_CD 
AND A.ADDR LIKE '%수원%'
;


-- USING 절
-- 두 테이블이 공통적으로 가지고 있는 컬럼을 기재함
SELECT A.EMP_NO 
	  ,A.EMP_NAME 
	  ,A.ADDR 
	  ,DEPT_CD 
	  ,B.DEPT_NM 
FROM TB_EMP A JOIN TB_DEPT B USING (DEPT_CD)
WHERE A.ADDR LIKE '%수원%'
;


-- ON 절 
SELECT A.EMP_NO 
	  ,A.EMP_NAME 
	  ,A.ADDR 
	  ,B.DEPT_CD 
	  ,B.DEPT_NM 
FROM TB_EMP A JOIN TB_DEPT B ON (A.DEPT_CD = B.DEPT_CD)
WHERE A.ADDR LIKE '%수원%'
;

-- 부서명이 지원팀인 직원의 사원번호, 사원명, 부서코드, 부서명, 보유자격증 코드를 출력하시오.
SELECT 
	  A.EMP_NO 
	  ,A.EMP_NAME 
	  ,A.DEPT_CD 
	  ,B.DEPT_NM 
	  ,C.CERTI_CD 
FROM TB_EMP A
	,TB_DEPT B
	,TB_EMP_CERTI C
WHERE A.DEPT_CD = B.DEPT_CD 
 AND A.EMP_NO = C.EMP_NO 
 AND B.DEPT_NM = '지원팀'
;


-- 3개 테이블 조인 (ANSI 방식 조인)
SELECT 
	  A.EMP_NO 
	  ,A.EMP_NAME 
	  ,A.DEPT_CD 
	  ,B.DEPT_NM 
	  ,C.CERTI_CD 
FROM TB_EMP A JOIN TB_DEPT B
 ON (A.DEPT_CD = B.DEPT_CD)
 JOIN TB_EMP_CERTI C ON (A.EMP_NO = C.EMP_NO)
WHERE B.DEPT_NM = '지원팀'
;


-- 아웃터 조인 (환경 구축)
INSERT INTO TB_DEPT VALUES ('100014', '4차산업혁신팀', '999999');
INSERT INTO TB_DEPT VALUES ('100015', '포스트코로나팀', '999999');
COMMIT;

-- 참조 무결성 제약 조건(FK) 잠시 DROP 
ALTER TABLE EZEN.TB_EMP DROP CONSTRAINT FK_TB_EMP;

INSERT INTO EZEN.TB_EMP T (T.EMP_NO, T.EMP_NAME, T.BIRTH_DE, T.SEX_CD, T.ADDR, 
T.TEL_NO, T.DIRECT_MANAGER_EMP_NO, T.FINAL_EDU_SE_CD, T.SAL_TRANS_BANK_CD, 
T.SAL_TRANS_ACCNT_NO, T.DEPT_CD, T.LUNAR_YN)
VALUES ('1000000041', '이순신', '19811201', '1', '경기도 용인시 수지구 죽전1동 435',
'010-5456-7878', NULL, '006', '003', '114-554-223433', '000000', 'N');

INSERT INTO EZEN.TB_EMP T (T.EMP_NO, T.EMP_NAME, T.BIRTH_DE, T.SEX_CD, T.ADDR, 
T.TEL_NO, T.DIRECT_MANAGER_EMP_NO, T.FINAL_EDU_SE_CD, T.SAL_TRANS_BANK_CD, 
T.SAL_TRANS_ACCNT_NO, T.DEPT_CD, T.LUNAR_YN)
VALUES ('1000000042', '정약용', '19820402', '1', '경기도 고양시 수지구 죽전1동 435',
'010-5456-7877', NULL, '004', '001', '110-554-223433', '000000', 'Y');

INSERT INTO EZEN.TB_EMP T (T.EMP_NO, T.EMP_NAME, T.BIRTH_DE, T.SEX_CD, T.ADDR, 
T.TEL_NO, T.DIRECT_MANAGER_EMP_NO, T.FINAL_EDU_SE_CD, T.SAL_TRANS_BANK_CD, 
T.SAL_TRANS_ACCNT_NO, T.DEPT_CD, T.LUNAR_YN)
VALUES ('1000000043', '박지원', '19850611', '1', '경기도 수원시 수지구 죽전1동 435',
'010-1254-7878', NULL, '004', '001', '100-554-223433', '000000', 'N');

INSERT INTO EZEN.TB_EMP T (T.EMP_NO, T.EMP_NAME, T.BIRTH_DE, T.SEX_CD, T.ADDR, 
T.TEL_NO, T.DIRECT_MANAGER_EMP_NO, T.FINAL_EDU_SE_CD, T.SAL_TRANS_BANK_CD, 
T.SAL_TRANS_ACCNT_NO, T.DEPT_CD, T.LUNAR_YN)
VALUES ('1000000044', '장보고', '19870102', '1', '경기도 성남시 수지구 죽전1동 435',
'010-1215-7878', NULL, '004', '002', '180-554-223433', '000000', 'Y');

INSERT INTO EZEN.TB_EMP T (T.EMP_NO, T.EMP_NAME, T.BIRTH_DE, T.SEX_CD, T.ADDR, 
T.TEL_NO, T.DIRECT_MANAGER_EMP_NO, T.FINAL_EDU_SE_CD, T.SAL_TRANS_BANK_CD, 
T.SAL_TRANS_ACCNT_NO, T.DEPT_CD, T.LUNAR_YN)
VALUES ('1000000045', '김종서', '19880824', '1', '인천시 수지구 죽전1동 435',
'010-3687-7878', NULL, '004', '002', '325-554-223433', '000000', 'Y');

COMMIT;


-- LEFT OUTER 조인
-- 현재 부서에 소속되어 있지 않은 직원들도 포함
-- TB_EMP(LEFT)는 다 나오고 TB_DEPT는 매칭되는 것만 나오게 됨.
SELECT A.EMP_NO 
	  ,A.EMP_NAME 
	  ,A.DEPT_CD 
	  ,B.DEPT_NM 
FROM TB_EMP A, TB_DEPT B
WHERE A.DEPT_CD IN('000000', '100001')
AND A.DEPT_CD = B.DEPT_CD(+) 
;

-- ANSI 조인 방식 (LEFT OUTER JOIN)
SELECT A.EMP_NO 
	  ,A.EMP_NAME 
	  ,A.DEPT_CD 
	  ,B.DEPT_NM 
FROM TB_EMP A 
LEFT OUTER JOIN TB_DEPT B
ON (A.DEPT_CD = B.DEPT_CD)
WHERE A.DEPT_CD IN('000000', '100001')
;


-- RIGHT OUTER 조인
-- 현재 아무런 사원을 가지고 있지 않은 부서도 모두 출력하시오.
-- TB_DEPT(RIGHT)는 모두 나오고 TB_EMP는 매칭되는 집합만 출력됨
SELECT A.EMP_NO 
	 , A.EMP_NAME 
	 , B.DEPT_CD 
	 , B.DEPT_NM 
FROM TB_EMP A
	,TB_DEPT B
WHERE B.DEPT_CD IN ('100014', '100015', '100001')
 AND A.DEPT_CD(+) = B.DEPT_CD 
; 


-- ANSI 조인 방식 (RIGHT OUTER JOIN)
SELECT A.EMP_NO 
	 , A.EMP_NAME 
	 , B.DEPT_CD 
	 , B.DEPT_NM 
FROM TB_EMP A
RIGHT OUTER JOIN TB_DEPT B 
ON (A.DEPT_CD = B.DEPT_CD)
WHERE B.DEPT_CD IN ('100014', '100015', '100001')
;


-- FULL OUTER 조인
SELECT A.EMP_NO 
	 , A.EMP_NAME 
	 , B.DEPT_CD 
	 , B.DEPT_NM 
FROM TB_EMP A
FULL OUTER JOIN TB_DEPT B ON (A.DEPT_CD = B.DEPT_CD)
WHERE 1 = 1
	AND ( A.EMP_NO IS NULL
		OR B.DEPT_CD IS NULL 				
	)
ORDER BY B.DEPT_CD DESC, A.EMP_NO DESC 
;







-- 데이터 삭제 및 제약 조건 재설정
DELETE 
	FROM TB_DEPT 
	WHERE DEPT_CD IN ('100014', '100015');

DELETE FROM TB_EMP
WHERE EMP_NO IN ('1000000041','1000000042','1000000043','1000000044','1000000045');

commit;

ALTER TABLE EZEN.TB_EMP ADD CONSTRAINT FK_TB_EMP 
	FOREIGN KEY (DEPT_CD) REFERENCES ezen.TB_DEPT(DEPT_CD);








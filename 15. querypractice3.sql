-- 집합의 일부분만 출력 
-- PAY_DE(지급일자) 조건을 만족하는 집합에서 10건만 먼저 출력,
-- 그 10건의 출력 결과를 PAY_AMT로 내림차순 정렬함.

SELECT A.SAL_HIS_NO 
	,A.PAY_DE 
	,A.PAY_AMT 
	,A.EMP_NO 
FROM EZEN.TB_SAL_HIS A
WHERE A.PAY_DE >= '20200501'
	AND A.PAY_DE <= '20200531'
	AND ROWNUM <= 10
ORDER BY A.PAY_AMT DESC	
;	
	
-- PAY_DE 조건을 만족하는 집합에서 
-- PAY_AMT 기준으로 내림차순 정렬한 집합 중 사위 10건만 출력함.
SELECT A.SAL_HIS_NO 
	,A.PAY_DE 
	,A.PAY_AMT 
	,A.EMP_NO 
FROM 
	(
		SELECT 
			 A.SAL_HIS_NO
			,A.PAY_DE 
			,A.PAY_AMT 
			,A.EMP_NO 
		FROM EZEN.TB_SAL_HIS A
		WHERE A.PAY_DE >= '20200501'
			AND A.PAY_DE <= '20200531'
		ORDER BY A.PAY_AMT DESC		
	) A
WHERE rownum <= 10
;

-- 단일행 문자형 함수 
SELECT LOWER('Orcle Server, SQL Develper') AS "LOWER('소문자로 변환')"
	   ,UPPER('Orcle Server, SQL Develper') AS "UPPER('대문자로 변환')"	
	   ,ASCII('a') AS "ASCII('아스키코드값 출력')" 
	   ,CONCAT('SQL', 'Develper') AS "CONCAT('문자열 결합')"
	   ,SUBSTR('SQL Develper',1,3) AS "SUBSTR('문자열 잘라내기')" 
	   ,LENGTH('SQL') AS "LENGTH('문자열의 길이 출력')" 
	   ,LTRIM(' SQL') AS "LTRIM('왼쪽 공객 제거')"
	   ,RTRIM('SQL ') AS "RTRIM('오른쪽 공객 제거')" 
FROM DUAL
;

-- 단일행 숫자형 함수
SELECT ABS(-15) AS "ABS('절대값을 반환')"
		,SIGN(10) AS "SIGN('양수일경우 1, 음수일경우 -1, 0일경우 0 반환')" 
		,MOD(8, 3) AS "MOD('나머지 반환')"
		,CEIL(38.678) AS "CEIL('무조건 올림')"
		,FLOOR(38.678) AS "FLOOR('무조건 버림')" 
		,ROUND(38.678, 2) AS "ROUND('소수점 2번째 자리 반올림')" 
		,TRUNC(38.678) AS "TRUNC('0의 자리에서 무조건 자름')" 
		,TRUNC(38.678,1) AS "TRUNC('1의 자리에서 무조건 자름')" 
		,TRUNC(38.678,2) AS "TRUNC('2의 자리에서 무조건 자름')" 
		,TRUNC(38.678,3) AS "TRUNC('3의 자리에서 무조건 자름')" 
FROM DUAL
;
	
-- 날짜형 데이터 변환 함수
SELECT SYSDATE AS "SYSDATE"	  -- 현재 년월일시분초 출력
		,EXTRACT(YEAR FROM SYSDATE) AS "EXTRACT(YEAR FROM SYSDATE)"  -- 년 출력
		,EXTRACT(MONTH FROM SYSDATE) AS "EXTRACT(MONTH FROM SYSDATE)" -- 월 출력
		,EXTRACT(DAY FROM SYSDATE) AS "EXTRACT(DAY FROM SYSDATE)" -- 일 출력
        ,TO_CHAR(SYSDATE, 'YYYY') AS "TO_CHAR(SYSDATE, 'YYYY')"   -- 년 출력(문자열)
        ,TO_CHAR(SYSDATE, 'MM') AS "TO_CHAR(SYSDATE, 'MM')"  -- 월 출력(문자열) 
        ,TO_CHAR(SYSDATE, 'DD') AS "TO_CHAR(SYSDATE, 'DD')"  -- 일 출력(문자열)
        ,TO_CHAR(SYSDATE, 'HH24') AS "TO_CHAR(SYSDATE, 'HH24')" -- 시 출력(문자열),
        ,TO_CHAR(SYSDATE, 'MI') AS "TO_CHAR(SYSDATE, 'MI')"     -- 분 출력(문자열)
        ,TO_CHAR(SYSDATE, 'SS') AS "TO_CHAR(SYSDATE, 'SS')"     -- 초 출력(문자열))
        ,TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) AS "TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))"   --년 출력
        ,TO_NUMBER(TO_CHAR(SYSDATE, 'MM')) AS "TO_CHAR(SYSDATE, 'MM')"
        ,TO_NUMBER(TO_CHAR(SYSDATE, 'DD')) AS "TO_CHAR(SYSDATE, 'DD')"
        ,TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) AS "TO_CHAR(SYSDATE, 'HH24')"
        ,TO_NUMBER(TO_CHAR(SYSDATE, 'MI')) AS "TO_CHAR(SYSDATE, 'MI')"
        ,TO_NUMBER(TO_CHAR(SYSDATE, 'SS')) AS "TO_CHAR(SYSDATE, 'SS')"
FROM DUAL
;

-- 날짜형 데이터 연산
SELECT 
    SYSDATE AS "SYSDATE"                -- 현재 년월일 시분초
    , SYSDATE - 1 AS "SYSDATE - 1"      -- 1일을 뺀 년월일 시분초
    , SYSDATE - (1/24) AS "SYSDATE - (1/24)"    -- 1시간을 뺀 년월일 시분초
    , SYSDATE - (1/24/60) AS "SYSDATE - (1/24/60)"  -- 1분을 뺀 년월일 시분초
    , SYSDATE - (1/24/60/60) AS "sysdate - (1/24/60/60)" -- 1초를 뺀 년월일 시분초
    , SYSDATE - (1/24/60/60) * 10 AS "SYSDATE - (1/24/60/60) * 10" -- 10초를 뺀 년월일 시분초
    , SYSDATE - (1/24/60/60) * 30 AS "SYSDATE - (1/24/60/60) * 30" -- 30초를 뺀 년월일 시분초
FROM DUAL
;

-- 데이터 변환의 종류
/*
    1) 암시적 형 변환 : DBMS가 자동으로 데이터 유형을 변환하는 경우
    2) 명시적 형 변환 : 데이터 변환 형 함수로 데이터 유형을 변환하도록 명시해주는 경우
 */

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') "TO_CHAR(SYSDATE, ''YYYY/MM/DD'')"
        ,TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') "TO_CHAR(SYSDATE, ''YYYY/MM/DD HH24:MI:SS'')"
        ,TO_CHAR(10.25, '$999,999,999.99') AS "TO_CHAR(10.25, ''$999,999,999.99'')"
        ,TO_CHAR(12500, 'L999,999,999') AS "TO_CHAR(12500, ''L999,999,999'')"
        ,TO_NUMBER('100') + TO_NUMBER('100') AS "TO_NUMBER(''100'') + TO_NUMBER(''100'')"
FROM DUAL;


/*
    CASE WHEN 조건
        THEN 값 혹은 SQL문
        ELSE 값 혹은 SQL문
    END

    :  조건이 맞으면 THEN절 수행하고 그렇지 않으면 ELSE절을 수행한다.
*/

SELECT CASE WHEN SAL_CD = '100001' THEN '기본급1'
            WHEN SAL_CD = '100002' THEN '상여급'
            WHEN SAL_CD = '100003' THEN '특별상여금'
            WHEN SAL_CD = '100004' THEN '야근수당'
            WHEN SAL_CD = '100005' THEN '주말수당'
            WHEN SAL_CD = '100006' THEN '점심식대'
            WHEN SAL_CD = '100007' THEN '복지포인트'
            ELSE '유효하지 않음'
END SAL_NM
FROM EZEN.TB_SAL;

/*
    DECODE(표현식 혹은 기준컬럼, 비교값1, 결과값1, 비교값2, 결과값2, 디폴트 값)

    : 표현식 혹은 기준컬럼과 비교하여 비교값1과 같으면 결과값1을 출력하고,
      표현식 혹은 기준컬럼과 비교하여 비교값2와 같으면 결과값2를 출력하고, 그렇지않으면 디폴트 값을 결과로 출력한다.
*/

SELECT  DECODE(EZEN.TB_SAL.SAL_CD, '100001', '기본급2', '100002', '상여급', '기타') AS SAL_NM
FROM EZEN.TB_SAL;


-- 널관련 함수 사용
SELECT NVL(DIRECT_MANAGER_EMP_NO, '최상위자')       -- 직속상관사원번호가 NULL이면 "최상위자"로 출력
FROM EZEN.TB_EMP
WHERE DIRECT_MANAGER_EMP_NO IS NULL;

-- 최상위부서
SELECT NVL(UPPER_DEPT_CD, '최상위부서') AS 상위부서
FROM EZEN.TB_DEPT
WHERE UPPER_DEPT_CD IS NULL;

SELECT NVL(MAX(EMP_NAME),'존재안함') AS EMP_NAME
FROM EZEN.TB_EMP
WHERE EMP_NAME = '김회장';

-- MAX함수를 쓰면 공집합인 경우에도 한개의 ROW가 나옴.
SELECT NVL(MAX(EMP_NAME),'존재안함') AS EMP_NAME
FROM EZEN.TB_EMP
WHERE EMP_NAME = '류현진';

-- 같지않으면 '박찬호' 리턴
SELECT NULLIF ('박찬호', '박지성') FROM DUAL 
;

SELECT NULLIF ('박찬호', '박찬호') FROM DUAL 
;

SELECT NVL(NULLIF('신사임당', '신사임당'), '같으면널') FROM DUAL 
;

-- COALESCE() : 널이 아닌 첫번째 수식/값을 리턴 함
SELECT COALESCE(NULL, NULL, 0) AS COALESCE_ FROM DUAL 
;
SELECT COALESCE(5000, NULL, 0) AS COALESCE_ FROM DUAL 
;
SELECT COALESCE(NULL, 6000, 0) AS COALESCE_ FROM DUAL 
;




















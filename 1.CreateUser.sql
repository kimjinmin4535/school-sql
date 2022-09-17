-- 오라클 구 버전 방식으로 사용자 계정 생성을 위한 설정
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;	

CREATE USER ezen IDENTIFIED BY 0824;			-- "ezen" 사용자 계정을 생성
ALTER USER ezen account unlock;
GRANT CONNECT, RESOURCE, DBA TO ezen;			-- "ezen" 사용자 계정에게 권한 줌


-- 테이블 스페이스 
CREATE tablespace ezen_data
datafile 'C:\app\ezen\product\18.0.0\oradata\XE\ezen_data.dbf' SIZE 2G
autoextend ON NEXT 512M maxsize unlimited
logging
ONLINE 
permanent
extent management LOCAL autoallocate
blocksize 8k
segment SPACE management auto
flashback ON;

CREATE TEMPORARY tablespace ezen_temp
tempfile 'C:\app\ezen\product\18.0.0\oradata\XE\ezen_temp.dbf' SIZE 500M
autoextend ON NEXT 100M maxsize unlimited
;

-- 생성한 테이블 스페이스를 ezen 사용자 계정의 default 테이블 스페이스로 지정
ALTER USER ezen DEFAULT tablespace ezen_data;
ALTER USER ezen TEMPORARY tablespace ezen_temp;






























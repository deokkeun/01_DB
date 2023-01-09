-- 함수 : 컬럼의 값을 읽어서 연산한 결과를 반환

-- 단일 행 함수 : N개의 값을 읽어 N개의 결과를 반환
-- 그룹 함수 : N개의 값을 읽어 [1개]의 결과를 반환(합계, 평균, 최대, 최소 등등)

-- 함수는 SELECT문의
-- SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절 등 사용 가능

-----------------------단일 행 함수-------------------------

-- LENGTH(컬럼명 | 문자열) : 길이 반환
SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

--------------------------------------------

-- INSTR(컬럼명 | 문자열, '찾을 문자열' [, 찾기 시작할 위치 [, 순번] )
-- 지정한 위치부터 지정한 순번째로 검색되는 문자의 위치를 반환

-- 문자열을 앞에서부터 검색하여 첫번째 B 위치를 조회
-- @ DB에서 INDEX는 1번부터 검색하니, 3이라는 결과가 나옴
SELECT INSTR('AABAACAABBAA', 'B')FROM DUAL;

-- 문자열을 5번째 문자부터 검색하여 첫 번째 B 위치 조회
SELECT INSTR('AABAACAABBAA', 'B', 5)FROM DUAL;

-- 문자열을 5번째 문자부터 검색하여 두 번째 B 위치 조회
SELECT INSTR('AABAACAABBAA', 'B', 5, 2)FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 이메일, 이메일 중 '@' 위치 조회

SELECT EMP_NAME, EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

------------------------------------------

-- SUBSTR('문자열' | 컬럼명, 잘라내기 시작할 위치 [, 잘라낼 길이] )

-- 컬럼이나 문자열에서 지정한 위치부터 지정된 길이만큼 문자열을 잘라서 반환
--> 잘라낼 길이 생략 시 끝까지 잘라냄

-- EMPLOYEE 테이블에서 사원명, 이메일 중 아이디만 조회

-- sun_di@or.kr



SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1 )
FROM EMPLOYEE; 
-- -1까지 써줘야 @가 같이 나온다.

------------------------------------------------

-- TRIM( [[옵션]'문자열' | 컬럼명 FROM ] '문자열' | 컬럼명)

-- 주어진 컬럼이나 문자열의 앞,뒤 양쪽에 있는 지정된 문자를 제거
-- 양 쪽 공백 제거에 많이 사용됨

-- 옵션 : LEADING(앞 쪽), TRAILING(뒤 쪽), BOTH(양 쪽, 기본값)
SELECT TRIM('     HELLO      ') FROM DUAL;

SELECT TRIM(BOTH '#' FROM '####안녕####') FROM DUAL;

------------------------------------------------

/* 숫자 관련 함수 */ 

-- ABS( 숫자 | 컬럼명 ) : 절대값
SELECT ABS(10), ABS(-10) FROM DUAL;

SELECT '절대값 같음'
FROM DUAL
WHERE ABS(10) = ABS(-10);


-- MOD(숫자 | 컬럼명, 숫자 | 컬럼명) : 나머지 값 반환
-- EMPLOYEE 테이블에서 사원의 월급을 100만으로 나눴을 때 나머지를 조회

 SELECT EMP_NAME, SALARY, MOD(SALARY,1000000)
 FROM EMPLOYEE

 -- EMPLOYEE 테이블에서 사번이 짝수인 사원의 사번, 이름 조회
 -- EMPLOYEE 테이블에서 사번이 홀수인 사원의 사번, 이름 조회
 
 SELECT EMP_ID, EMP_NAME 
 FROM EMPLOYEE
 WHERE MOD(EMP_ID, 2) = 0;

-- 만약 홀수라면

 SELECT EMP_ID, EMP_NAME 
 FROM EMPLOYEE
 WHERE MOD(EMP_ID, 2) <> 0; -- 같지않다 ( !=랑 같지만 보통 <> 사용)

 -- ROUND(숫자 | 컬럼명[,소수점 위치]) : 반올림
 
 SELECT ROUND(123.456) FROM DUAL; -- 소수점 첫번째 자리에서 반올림
 SELECT ROUND( 123.456 , 1 ) FROM DUAL; -- 소수점 첫번째 자리 까지 반올림
										-- 두번째 자리에서 반올림해서, 소수점 한자리까지만 표현
 SELECT ROUND(123.456, 0 ) FROM DUAL; -- 첫번째 자리에서 반올림(0 기본값)

  SELECT ROUND(123.456, -1 ) FROM DUAL; -- 120이 나오는데, 소수점 0번째 자리에서 반올림해서
  										-- 소수점 -1 자리 표현
  										-- 1의 자리에서 반올림 해서 10의 자리부터 표현
  										-- (3 버리고 앞에것 그대로 출력)

  ---------------------------------------------------
  
  -- CELL(숫자|컬럼명) : 올림
  -- FLOOR(숫자|컬럼명) : 내림
  --> 둘 다 소수점 첫째 자리에서 올림/내림 처리
  
  SELECT CEIL(123.1), FLOOR(123.9) FROM DUAL;
 -- 첫째 자리 수가 반올림 조건이 되어도, CELL/FLOOR에 집중해야함
 
 -- TRUNC(숫자 | 컬럼명 [,위치] ) : 특정 위치 아래를 버림(절삭)
 
 SELECT TRUNC(123.456) FROM DUAL; --> 소수점 아래를 버림 처리
 SELECT TRUNC(123.456, 1) FROM DUAL; --> 소수점 첫째자리 아래 버림
 SELECT TRUNC(123.456, -1) FROM DUAL --. 10의 자리 아래를 버림
 
 -- 버림 내림 차이점
 SELECT FLOOR(-123.5), TRUNC(-123.5) FROM DUAL;
 --				-124		-123 
 
-------------------------------------------------

/* 날짜(DATE) 관련 함수 */

-- SYSDATE : 시스템에 현재 시간(년,월,일,시,분,초)을 반환
SELECT SYSDATE FROM DUAL;

-- SYSTIMESTAMP : SYSDATE + MS 단위 추가
SELECT SYSTIMESTAMP FROM DUAL;
-- 특정 시간을 나타내거나, 기록하기 위한 문자열

-- MONTHS_BETWEEN(날짜,날짜) : 두 날짜의 개월 수 차이 반환
SELECT ROUND( MONTHS_BETWEEN(SYSDATE, '2023-07-10') , 3) "수강 기간(개월)"
FROM DUAL;

-- EMPLOYEE 테이블에서
-- 사원의 이름, 입사일, 근무개월수, 근무년차 조회

SELECT EMP_NAME, HIRE_DATE,
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) ) "근무한 개월 수",
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) || '년차' "근무 년차"
FROM EMPLOYEE;

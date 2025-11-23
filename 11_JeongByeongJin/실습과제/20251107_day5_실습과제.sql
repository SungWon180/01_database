
/* 문제 1 */
SELECT
    EMP_NAME,
    CONCAT_WS(
            '-',
            SUBSTRING(PHONE, 1, 3),
            SUBSTRING(PHONE, 4, 4),
            SUBSTRING(PHONE, 8, 4)
    ) AS PHONE
FROM EMPLOYEE
WHERE SUBSTRING(PHONE, 1, 3) = '010';
# WHERE PHONE LIKE '010%'


/*
근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.

출력한 결과집합 헤더의 명칭은 각각 ‘직원명’, ‘입사일’, ‘급여’여야 함
입사일은 ‘0000년 00월 00일’ 형식으로 출력해야 함
급여는 천 단위로 , 를 찍어 출력해야 함
HINT 1
CONCAT
HINT 2
FORMAT
HINT 3
DATE 관련 함수
HING 4
YEAR, MONTH, DAY*/


SELECT EMP_NAME  AS '직원명',
       CONCAT (YEAR(HIRE_DATE), '년', LPAD(MONTH(HIRE_DATE),2, 0), '월', LPAD(DAY(HIRE_DATE), 2, 0), '일')  AS '입사일',
       FORMAT(SALARY, 0) AS '급여'
FROM EMPLOYEE
WHERE YEAR(NOW()) - YEAR(HIRE_DATE) >= 20
ORDER BY HIRE_DATE ASC, SALARY DESC;


/*
Q3.
모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요
출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘SALARY’, ‘BONUS’,
‘TOTAL_SALARY’여야 함
보너스를 더한 급여는 소수점이 발생할 경우 반올림 처리함
급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
보너스는 백분율로 출력해야 함
HINT 1
급여에 보너스를 더한 금액을 구하고자 할 때, 보너스가 0이라면 원하는 값이 나오지 않
을 겁니다. 수업 시간에 다루지 않았지만 NULL 값을 다른 값으로 대체하는 내장함수가
있습니다. 해당 함수를 찾아서 사용해 보세요🙂
HINT 2
FORMAT
HINT 3
CONCAT
HINT 4
TRUNCATE
HINT 5
ROUND
*/
SELECT
    EMP_NAME ,
    FORMAT(SALARY,0) SALARY,
    CONCAT( NVL(BONUS, 0) * 100, '%') BONUS,
    FORMAT(ROUND( SALARY * (1 + NVL(BONUS, 0))),0) TOTAL_SALARY

FROM
    EMPLOYEE
ORDER BY ROUND( SALARY * (1 + NVL(BONUS, 0))) DESC;

/*
Q4.
직원의 직원명과 이메일을 다음과 같이 출력하세요.
출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘EMAIL’이어야 함
이메일의 도메인 주소인 greedy.com SUBSTRING_INDEX(EMAIL, '@', 1) 은 모두 동일하므로, 해당 문자열이 맞춰질 수 있
도록 이메일의 앞에 공백을 두고MAX(CHAR_LENGTH(SUBSTRING_INDEX(EMAIL, '@', 1)) 출력해야 함
HINT 1
LPAD
HINT 2
MAX
HINT 3
서브쿼리
답안
+@ (심화)
이메일의 도메인 주소가 모두 다르다고 가정할 때, @의 위치를 한 줄로 맞추고 싶은 경
우에는 어떻게 수정할 수 있을까?
*/
SELECT
    EMP_NAME AS EMP_NAME,
    CONCAT(
            LPAD(SUBSTRING_INDEX(EMAIL, '@', 1),
                 (SELECT MAX(CHAR_LENGTH(SUBSTRING_INDEX(EMAIL, '@', 1))) FROM EMPLOYEE),
                 ' '),
            '@',
            SUBSTRING_INDEX(EMAIL, '@', -1)
    ) AS EMAIL
FROM EMPLOYEE;





SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
SELECT * FROM SAL_GRADE;
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;

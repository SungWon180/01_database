-- 1. 모든 사원의 모든 컬럼 조회
SELECT
    *
FROM
    employee;

-- 2. 사원들의 사번
SELECT
    EMP_NO
FROM
    employee;



-- 3. 201번 사번의 사번 및 이름 조회
SELECT
    EMP_NO,
    EMP_NAME
FROM
    employee
WHERE
    EMP_ID = 201;

/* SELECT
    EMP_NO,
    EMP_NAME
FROM
    employee
WHERE
    emp_id = 201;

 */
 --    EMP_NO = '201';




-- 4. 부서 코드가 'D9'인 사원의 이름과 부서코드 조회
SELECT
    EMP_NAME,
    DEPT_CODE
FROM
    employee
WHERE
DEPT_CODE = 'D9';
 --   DEPT_CODE = D9;
    --    DEPT_CODE IN (D9);

-- 5. 직급 코드가 'J1'인 사원 조회
SELECT
    EMP_NAME,
    DEPT_CODE
FROM
    employee
WHERE
-- DEPT_CODE = 'J1';
-- 왜 공백이냐

-- 6. 급여가 300만원 이상(>=)인 사원의 사번, 이름, 급여를 조회
SELECT
    EMP_NO,
    employee.EMP_NAME,
    SALARY
FROM
    employee
WHERE
    SALARY >= 3000000;
 -- SALARY >= S3;
 --   SALARY = 3000000;
 --   SAL_GRADE >= 3000000;
 --   SAL_LEVEL = S4;
--

-- 7. 부서코드가 'D6'이고 급여를 300만원보다 많이 받는 사원의 이름, 급여 조회
Select
    EMP_NAME,
    SALARY
FROM
    employee
WHERE
    DEPT_CODE = 'D6' AND SALARY > 3000000;

SELECT
    *
FROM
    employee
WHERE
    DEPT_CODE

-- 8. 보너스를 받지 않는 사원의 사번, 이름, 급여, 보너스 조회
SELECT
--    DEPT_CODE, -- DEPT_CODE는 문제 요구사항에 없음. 불필요.
    EMP_NO,
    EMP_NAME,
    BONUS
FROM
    employee
WHERE
    BONUS IS NULL;
-- BOUNS = NULL -- 이거는 불가능 그만좀해 “보너스가 0이다” ❌ “보너스가 없다 (모르겠다)” ✅


-- 9. 'D9' 부서에서 근무하지 않는 사원의 사번, 이름 조회
SELECT
    EMP_NO,
    EMP_NAME
FROM
    employee
WHERE
    DEPT_CODE != 'D9';
-- DEPT_CODE <> 'D9';
--    ref_category_code = 'D9';

-- 10. 퇴사 여부가 N인 직원의 사번, 이름, 입사일 조회 (별칭 사용)
    SELECT
        EMP_NO AS '번호',
        EMP_NAME AS '이름',
        HIRE_DATE AS '고용일',
        ENT_DATE AS '퇴사일'
    FROM
        employee
    WHERE
        ENT_DATE IS NULL;


-- 11. 급여가 350만원 이상 550만원 이하를 받는 직원의 사번, 이름, 급여 조회
    SELECT
    EMP_NO,
    employee.EMP_NAME,
    SALARY
FROM
    employee
WHERE
     SALARY BETWEEN 3500000 AND 5500000;

-- WHERE SALARY >= 3500000 AND SALARY <= 5500000; -- 이건 정답
--  AND, OR,
-- SALARY >= 3500000 <= 5500000;
-- SALARY >= 3500000 AND SALARY < 5500000;
    -- 5500000 >= SALARY >= 3500000;

-- 12. '성이 김씨'인 직원의 사번, 이름, 입사일 조회
SELECT
    HIRE_DATE,
--    DEPT_CODE,
    EMP_ID,
    EMP_NAME
FROM
    employee
where
    EMP_NAME LIKE '김%';


-- 13. '성이 김씨'가 아닌 직원의 사번, 이름, 입사일 조회
SELECT
        EMP_NAME,
        HIRE_DATE,
        DEPT_CODE
FROM
    employee
WHERE
    EMP_NAME NOT LIKE '김%';
-- Ez

-- 14. 이름에 '하' 문자가 포함된 직원의 이름, 주민번호, 부서코드 조회
SELECT
    EMP_NAME,
    EMP_NO,
    DEPT_CODE
FROM
    employee
WHERE
    EMP_NAME LIKE '%하%';

-- 15. 'J2'직급이거나 'J7'직급인 직원들 중 급여가 200만원 이상인 직원의 이름, 급여 조회
SELECT
    EMP_NAME,
    SALARY
FROM
    employee
WHERE
    (
        JOB_CODE = 'J2' -- DEPT_CODE 대신 JOB_CODE
         OR JOB_CODE = 'J7'
        )
  AND
    SALARY >= 2000000; -- IS NOT NULL 제거

/* SELECT
    DISTINCT
    EMP_NAME,
    SALARY
FROM
    employee
WHERE
  DEPT_CODE = 'J2'  IS NOT NULL
AND
DEPT_CODE = 'J7'  IS NOT NULL
AND
SALARY >= 2000000  IS NOT NULL;


 */
 --   SALARY >= 2000000
 --   DEPT_CODE LIKE 'J2' OR DEPT_CODE LIKE 'J7'

-- 16. 급여가 높은 순서대로 사원의 이름, 급여 조회 (상위 5명만)
SELECT
    EMP_NAME,
    SALARY
FROM
    employee
ORDER BY
    SALARY desc
LIMIT 0, 5 ; -- 0은 빼도됨

-- 17. 중복된 급여 범위를 제거하고 급여 조회
SELECT
   DISTINCT SALARY
FROM
    employee;
-- ORDER BY SALARY



-- 18. 사원들의 이름을 사전 순서대로 정렬하고 상위 10명 조회
SELECT
    EMP_NAME -- * 대신 이름만
FROM
    employee
ORDER BY
    EMP_NAME
LIMIT 0, 10 ; -- 0 빼도됨

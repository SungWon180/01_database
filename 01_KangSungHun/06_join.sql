/* 06_JOIN
   - 두 개 이상의 테이블을 관련 있는 컬럼을 통해 결합
 */

 /* 1. INNER JOI
    - 두 테이블의 교집합을 반환
    - ON 키워드 : JOIN에 사용할 두 테이블의 컬럼을 명시
  */

SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

SELECT tbl_menu.menu_code, tbl_menu.menu_name, tbl_menu.category_code
FROM tbl_menu

-- INNER JOIN (ANSI)

SELECT a.menu_name,
       a.menu_price,
       b.category_name
FROM tbl_menu a
INNER JOIN tbl_category b
     ON




/* JOIN은 두 테이블에서 지정된 컬럼 값이 같은 행들의 결합으로 만들어진 큰 테이블
 */

-- Oracle 방 식 join (권장 x)
SELECT
    *
FROM
    tbl_menu a, tbl_category b
WHERE
    A.category_code = b.category_code;

 /* practice 계정으로 변경 후 실습 */
SELECT * FROM employee;
SELECT  * FROM DEPARTMENT;

/* INNER JOIN (ANSI)




 */

 SELECT
     FROM
              employee e
 JOIN -- join == inner join (기본 값)
 DEPARTMENT d
 ON e.DEPT_CODE = d.DEPT_ID;
 WHERE
 e.emp_id < 210;

 /* 2. LEFT [OUTER] JOIN
 - JOIN 구문 기준으로 왼쪽에 테이블의
 모든 레코드(행)이 결과에 포함되도록 하는 JOIN
 - JOIN의 기준이 된 컬럼 값이 일치하지 않아도 결과 포함

  */
 -- practice 계정
 select
     EMP_NAME,
     DEPT_CODE
     FROM
         employee;
SELECT DEPT_ID,DEPT_TITLE
    FROM
        DEPARTMENT;

SELECT *
FROM
    EMPLOYEE e
        LEFT JOIN DEPARTMENT D
                  ON e.dept_code
                         = d.dept_id;

-- INNER JOIN 시 : 하동운,  이오리가 결과 포함 a
LEFT outer join  하동운


SELECT *
FROM
    EMPLOYEE e
        right JOIN DEPARTMENT D
                  ON e.dept_code
                      = d.dept_id;

/* 4. CROSS JOIN
   - 두 테이블의 가능한 모든 조합을 반환하는 조인
 */
-- swcamp 계정

 SELECT a.menu_name,
        b.category_name
     FROM tbl_menu a
 CROSS JOIN
         tbl_category b;

/* 5. SELF JOIN
   - 같은 테이블의 JOIN
   - 같은 테이블의 행과 행 사이의 관계를 찾을 때 주로 사용.
   - TIP. 같은 모양의 서로 다른 테이블이 2개 있고, 이들의 JOIN을 생각하자!
 */
 SELECT
     *
 FROM
     tbl_category a
  LEFT JOIN tbl_category b
 ON a.ref_category_code = b.category_code;


-- practice 계정 --
SELECT
    a.emp_id AS '사번',
    a.emp_name AS '이름',
    b.emp_name AS '사수명',
    NVL(b.emp_name, '없음') AS '사수명'
FROM EMPLOYEE a
LEFt JOIN EMPLOYEE b
ON a.MANAGER_ID = b.EMP_ID;

-- SW camp 계정 --
/* USING :
   - JOIN에 사용되는 컬럼 이름이 같은 경우 사용 가능한 구문
   - JOIN에 사용되는 컬럼을 실제로 하나로 합침

   - 장점 : JOIN 결과 컬럼 개수 감소
   - 단점 : 다른 JOIN, SUBQUERY, 연산 수행 시
           어떤 테이블의 컬럼을 지시하려는 것인지 알 수 없음 (애매모호함)
 */

SELECT
    *
FROM tbl_menu a
JOIN tbl_category b
USING(category_code);
-- ON a.category_code = b.category_code;


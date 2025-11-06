-- 서브 쿼리 예시
-- '민트미역국'과 같은 카테고리의 메뉴를 모두 조회하시오

-- 1) '민트미역국'의 카테고리 코드 찾기
SELECT
    category_code
FROM
    tbl_menu
WHERE
    menu_price = '민트미역국'; -- 4

-- 2) 카테고리 코드가 4인 메뉴 모두 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    category_code = 4; -- 1번, 2번 둘다해야 값이나옴

-- 3) SUBQUERY를 이용해서 한번의 SQL 실행으로 결과 찾기
SELECT
    *
FROM                            -- 2번에 (MAINQUERY)
    tbl_menu
WHERE
    category_code = (
        SELECT
    category_code
FROM                            -- 1번을 괄호에 넣음 (SUBQUERY)
    tbl_menu
WHERE
    menu_name = '민트미역국'
        );
/* 08_SUBQUERY
   - 메인 쿼리(SQL) 내에서 실행되는 보조 쿼리(SELECT)
   - 종류 : 단일행, 다중행, 다중열, 다중행 단일행, 단중열, 스칼라, 상관(어려움), 인라인뷰
   - SUBQUERY를 위한 연산자 : EXISTS
 */

-- 1) 단일행 서브쿼리
-- 서브쿼리가 1개의 행, 1개의 컬럼만 반환
-- 비교 연산자 사용 가능: =, >, <, >=, <=, !=

-- 전체 메뉴의 평균 가격보다 비싼 메뉴 찾기
SELECT menu_name
     , menu_price
FROM tbl_menu
WHERE menu_price > (SELECT AVG(menu_price) FROM tbl_menu);

-- 가장 비싼 메뉴가 속한 카테고리의 모든 메뉴 조회
SELECT menu_name
     , menu_price
     , category_code
FROM tbl_menu
WHERE category_code = (SELECT category_code
                       FROM tbl_menu -- 여기가 1순위라 모든정보있음
                       ORDER BY menu_price DESC
                       LIMIT 1);

-- 2) 다중행 서브쿼리
-- 서브쿼리가 여러 행, 1개의 컬럼 반환
-- 사용 연산자: IN, ANY, ALL, EXISTS

-- '식사' 카테고리의 하위 카테고리에 속하는 모든 메뉴 조회
SELECT menu_name
     , menu_price
     , category_code
FROM tbl_menu
WHERE category_code IN (SELECT category_code
                        FROM tbl_category
                        WHERE ref_category_code = 1);
-- '식사'의 하위 카테고리 다중행

/* SELECT menu_name
     , menu_price
     , category_code
FROM tbl_menu
WHERE category_code IN */

-- 3) 다중열 서브쿼리
-- 서브쿼리가 1개의 행, 여러 컬럼 반환
-- 여러 컬럼을 한 번에 비교

-- 가장 비싼 메뉴와 동일한 카테고리 + 가격을 가진 메뉴
SELECT
    category_code,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC -- 가격 내림차순으로
LIMIT 1; -- 맨위에서 하나

-- 10번째 비싼 메뉴와 동일한 카테고리 + 가격을 가진 메뉴
SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_price DESC -- 가격 내림차순으로
LIMIT 9,1; -- 9개 건너뛰고 하나

-- 10번째 비싼 메뉴와 동일한 카테고리 + 가격을 가진 메뉴
SELECT
    *
FROM
    tbl_menu
WHERE
    (category_code, menu_price) = (ORDER BY
                                    menu_price
                                    DESC -- 가격 내림차순으로
                                    LIMIT 9,1 -- 9개 건너뛰고 하나

                                    );



-- 4) 다중행 다중열 서브쿼리
-- 서브쿼리가 여러 행, 여러 컬럼 반환
-- IN 연산자와 함께 사용

-- 각 카테고리별로 가장 저렴한 메뉴들만 조회
SELECT menu_name
     , category_code
     , menu_price
FROM tbl_menu
WHERE (category_code, menu_price) IN (SELECT category_code, MIN(menu_price)
                                      FROM tbl_menu
                                      GROUP BY category_code)
ORDER BY category_code;

-- 5) 스칼라 서브쿼리 (Scalar Subquery)
-- SELECT 절에서 사용되는 서브쿼리 (1행 1열만 반환)
-- 메뉴 정보와 함께 카테고리명도 조회 (JOIN 대신 서브쿼리 사용)
SELECT menu_code
     , menu_name
     , menu_price
     , (SELECT category_name
        FROM tbl_category
        WHERE category_code = 1) AS category_name
FROM tbl_menu m
ORDER BY menu_code
LIMIT 5;

-- 각 메뉴의 가격과 전체 평균의 차이
SELECT menu_name
     , menu_price
     , (SELECT AVG(menu_price) FROM tbl_menu)              AS avg_price
     , menu_price - (SELECT AVG(menu_price) FROM tbl_menu) AS price_diff
FROM tbl_menu
ORDER BY price_diff DESC;

-- 메뉴 정보와 함께 다양한 통계 (그룹 함수)
SELECT menu_name
     , menu_price
     , (SELECT MIN(menu_price) FROM tbl_menu) AS min_price
     , (SELECT MAX(menu_price) FROM tbl_menu) AS max_price
     , (SELECT AVG(menu_price) FROM tbl_menu) AS avg_price
     , (SELECT COUNT(*) FROM tbl_menu)        AS total_menu_count
FROM tbl_menu
WHERE menu_code = 1;

SELECT menu_name
     , menu_price
     , (SELECT MIN(menu_price) FROM tbl_menu) AS min_price
     , (SELECT MAX(menu_price) FROM tbl_menu) AS max_price
     , (SELECT AVG(menu_price) FROM tbl_menu) AS avg_price
     , (SELECT COUNT(*) FROM tbl_menu)        AS total_menu_count
FROM tbl_menu
WHERE menu_code = 1;

/* ## 1-2. 상관(상호연관) 서브쿼리

- **`메인 쿼리가 서브쿼리의 결과에 영향을 주는 경우`** 상관 서브쿼리라고 한다.
- SUBQUERY를 활용해 카테고리별 평균 가격보다 높은 가격의 메뉴 조회
    - 서브쿼리
1) MAIN쿼리를 1행씩 접근 (커서)
   2) 서브쿼리에서 사용할 메인쿼리의 컬럼값을 전달 (메인쿼리 -> 서브쿼리)
   3) 서브쿼리가 전달 받은 값을 이용해서 SELECT 수행
   4) 서브쿼리 수행 결과를 다시 메인쿼리에 전달(서브쿼리 -> 메인쿼리)
   5) 메인쿼리가 전달 받은 값을 이용해 연산 수행
   - WHERE : 연산 수행 결과에 따라 메인쿼리 1행을 RESULT SET에
   포함 할지, 말지 결정
   -SELECT절 : 단순 출력 OR 추가 연산

 */
SELECT
       *
  FROM
      tbl_menu
 WHERE
     category_code = 4;
-- 15000


SELECT
      menu_code,
      menu_name,
      menu_price,
      category_code,
      orderable_status
  FROM
      tbl_menu Main -- 1 메인쿼리 접근 , 3 서브쿼리값을 메인으로 전달
WHERE
    menu_price > ( -- 2 서브 쿼리 접근
        SELECT AVG(Sub.menu_price)
  FROM
      tbl_menu Sub -- ()기준으로 메인 서브로 나눠서 진행
 WHERE
     Sub.category_code = Main.category_code
        );

/* ## 1-3. EXISTS

- 서브쿼리의 조회 결과가 있을 경우에만
   해당 메인쿼리 1행을 RESULT SET에 포함 시키는 연산자
- 조회 결과가 있을 때 true 아니면 false
- EXISTS와 SUBQUERY를 활용한 메뉴가 있는 카테고리 조회

 */
 -- 실제로 메뉴 테이블에 사용된(등록된) 카테고리만 조회
SELECT
       category_name
  FROM
      tbl_category a
 WHERE
     EXISTS(SELECT 1
                FROM
                    tbl_menu b
                WHERE
                    b.category_code = a.category_code) -- 서브쿼리가 먼저 해석되지만 메인쿼리의 1행을 가져온다
	 ORDER BY
	     1; -- 1은 컬럼순서


/* 1-4. CTE(Common Table Expressions)
   - 인라인뷰(FROM절에 사용되는 서브쿼리, 서브쿼리의 결과를 테이블 처럼 사용)
     로 사용되는 서브쿼리를 미리 정리해서 사용하는 방법

FROM절에서만 사용 됨(JOIN일 시 JOIN 구문에서도 가능)
인라인 뷰로 쓰인 서브쿼리(FROM 절에 쓰인 서브쿼리)를 미리 정의하고
   메인쿼리가 심플해 질 수 있도록 사용하는 문법
 */
-- 인라인뷰 사용
SELECT
    `메뉴명`, `카테고리명`
FROM (
    SELECT
    menu_name AS '메뉴명',
    category_name AS '카테고리명'
FROM
    tbl_menu a
JOIN
    tbl_category b
ON
    a.category_code = b.category_code
) AS menu_category
    WHERE `메뉴명`
        LIKE '%마늘%';

-- CTE 적용 (서브쿼리를 위로 메인쿼리를 아래로한 분리된 쿼리생성 + 속도도 좀 빨라짐)
WITH menu_category AS (
    SELECT
    menu_name AS '메뉴명',
    category_name AS '카테고리명'
FROM
    tbl_menu a
JOIN
    tbl_category b
ON
    a.category_code = b.category_code
)
SELECT
    `메뉴명`, `카테고리명`
FROM  menu_category
    WHERE `메뉴명`
        LIKE '%마늘%';


-- 위의 쿼리에서 'GOUP BY'만 추가 한 버전

WITH menu_category AS (
    SELECT
        menu_name AS '메뉴명',
        category_name AS '카테고리명'
    FROM
        tbl_menu a
    JOIN
        tbl_category b
    ON
        a.category_code = b.category_code
)
SELECT
    `카테고리명`,
    COUNT(`메뉴명`) AS '마늘메뉴개수'
FROM
    menu_category
WHERE
    `메뉴명` LIKE '%마늘%'
GROUP BY
    `카테고리명`;

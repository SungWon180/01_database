-- 서브쿼리 예시

-- '민트미역국'과 같은 카테고리의 메뉴를 모두 조회하시오

-- 1) '민트미역국'의 카테고리 코드 찾기
SELECT
    category_code
FROM
    tbl_menu
WHERE
    menu_name = '민트미역국'; -- 4


-- 2) 카테고리 코드가 4인 메뉴 모두 조회
SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code = 4;


-- 3) 서브쿼리를 이용해서 한 번의 SQL 실행으로 결과 찾기
SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code = (
        SELECT category_code
        FROM   tbl_menu
        WHERE  menu_name = '민트미역국'
    );


/*
    08_SUBQUERY
    - 메인 쿼리(SQL) 내에서 실행되는 보조 쿼리(SELECT)
    - 종류 : 단일행 단일열, 다중행, 다중열, 다중행 다중열, 스칼라, 상관, 인라인뷰
    - 서브쿼리를 위한 연산자 : EXISTS
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
                       FROM tbl_menu
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
-- '식사'의 하위 카테고리


-- 3) 다중열 서브쿼리
-- 서브쿼리가 1개의 행, 여러 컬럼 반환
-- 여러 컬럼을 한 번에 비교

-- 10번째로 비싼 메뉴와 동일한 카테고리 + 가격을 가진 메뉴

SELECT
    *
FROM
    tbl_menu
WHERE
    (category_code, menu_price) = (
            SELECT
                category_code, menu_price
            FROM
                tbl_menu
            ORDER BY
                menu_price DESC
            LIMIT 9, 1);


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
        WHERE category_code = m.category_code) AS category_name
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


-- 메뉴 정보와 함께 다양한 통계 표시
SELECT menu_name
     , menu_price
     , (SELECT MIN(menu_price) FROM tbl_menu) AS min_price
     , (SELECT MAX(menu_price) FROM tbl_menu) AS max_price
     , (SELECT AVG(menu_price) FROM tbl_menu) AS avg_price
     , (SELECT COUNT(*) FROM tbl_menu)        AS total_menu_count
FROM tbl_menu
WHERE menu_code = 1;

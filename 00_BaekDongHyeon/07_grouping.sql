/* 07_GROUPING

   1. GROUP BY
    - 결과 집합을 특정 컬럼 값에 따라 그룹화
*/

/* 그룹 함수
   - 전체 테이블 또는
     GROUP이 지어진 결과 집합에 사용 가능한 함수
   - COUNT(), SUM(), MIN(), MAX(), AVG()
*/
SELECT
    category_code, COUNT(*)
FROM
    tbl_menu
GROUP BY
    category_code;


-- GROUP BY 없이 그룹 함수 사용
-- == 테이블 전체 == 한 그룹
SELECT
    COUNT(*)
FROM
    tbl_menu; -- 전체 메뉴 개수 조회


-- COUNT 함수 특징
SELECT * FROM tbl_category;

SELECT
    COUNT(*),             -- * : 모든 행(NULL 포함)
    COUNT(category_code),  -- 컬럼명 기재 : 지정된 컬럼에 값의 개수(NULL 제외)
    COUNT(ref_category_code) -- NULL 카운트 X
FROM
    tbl_category;


-- SUM, AVG 확인
SELECT
    category_code,
    COUNT(*),
    SUM(menu_price),
    AVG(menu_price)
FROM
    tbl_menu
GROUP BY
    category_code;





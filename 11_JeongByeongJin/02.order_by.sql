/* 02. ORDER BY
   - RESULT SET을 정렬하는 구문
    -> RESULT SET 란?
        SELECT문의 결과 집합 ( SELECT 실행해서 조회되는 데이터의 집합 )

   - 보통 SELECT문 제일 마지막에 작성
   - 정렬 방식
   1) ASC : 오름차순(ascending)
   2) DESC : 낼림차순(descending)
*/
select
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    -- menu_price ASC; -- 오름차순
    menu_price DESC; -- 내림차순

    -- 문자열 컬럼 기준 오름/내림차순
SELECT menu_name
FROM tbl_menu
ORDER BY menu_name DESC;
-- ORDER BY menu_name ASC;

SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price ASC,
    menu_name ASC;
-- 1순위로 정렬 후 동일한 가격이 있으면 ASC or DESC로 2순위 정렬 가능

/* ORDER BY 절에는 컬럼명 외
   연산 결과, 별칭, 컬럼 순서 등을 이용할 수 있다.
 */

-- 컬럼 순서 사용
-- 추천하지 않는 이유 : SELECT 절의 컬럼 순서는 언제든지 바뀔 수 있다.
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    2 DESC;
-- RESULT SET 중 2번째 컬럼(menu_name) 내림차순 정렬


-- 연산 결과를 이용한 정렬

SELECT
    menu_code, menu_price, menu_code * menu_price
FROM tbl_menu
ORDER BY
    menu_code * menu_price ASC;

-- 별칭을 이용하여 정렬
/*(중요) ORDER BY절은 SELECT 해석 이후에 적용된다! */

SELECT
    menu_code AS '메뉴 코드',
    menu_price AS '메뉴 가격',
    menu_code * menu_price AS '연산결과'
FROM
    tbl_menu
ORDER BY
    `연산결과` DESC;
-- ``(백틱으로 감싸야 한다) 문자열 모양을 그대로 인식

/*
    DB에서 NULL == "빈칸"을 의미
*/
-- NULL 값의 정렬 방식
SELECT * FROM tbl_category;

/*
    ASC 정렬 시 NULL은 무조건 윗쪽
    DESC 정렬 시 NULL 무조건 아래쪽

    ORDER BY 대상 컬럼 앞에 - 추가 시
    정렬 방향이 반대로 바뀜
*/
SELECT
    category_code, category_name, ref_category_code

FROM tbl_category
ORDER BY
   -- ref_category_code ASC; NULL 윗쪽, 오름차순
   -- -ref_category_code ASC; NULL 윗쪽, 내림차순
   -- ref_category_code DESC; NULL 아래쪽, 내림차순
   -ref_category_code DESC; -- NULL 아래쪽 오름차순

/*
    field(찾을값, 목록1, 목록2, ...)함수
    - 찾을 값이 목록에 존재하면 해당 위치 (숫자)를 반환
    - 목록에 일치하는 값이 없다면 0 반환
*/

SELECT FIELD('A', 'A', 'B', 'C'); -- 1
SELECT FIELD('B', 'A', 'B', 'C'); -- 2
SELECT FIELD('C', 'A', 'B', 'C'); -- 3
SELECT FIELD('D', 'A', 'B', 'C'); -- 0

-- field() 함수를 이용해 정렬하기
SELECT
    menu_name,
    orderable_status, -- 주문이 가능한 상태
    field(orderable_status, 'Y', 'N')
FROM
    tbl_menu
ORDER BY
    field(orderable_status, 'Y', 'N') ASC;
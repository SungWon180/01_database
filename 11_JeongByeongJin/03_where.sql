/*
    03_where
    - 테이블에서 특정 조건에 맞는 레코드(행, row)만 선택하는 구문
    - 조건을 나타내기 위한 각종 연산자를 사용
*/

-- 1) 비교 연산자(=, !=, <>, <, >, <=, >=)
SELECT
    menu_code
     , menu_name
     , orderable_status
FROM tbl_menu;

-- [=] : 값이 일치하는지 확인
SELECT /*3*/
    menu_code
     , menu_name
     , orderable_status
From /*1*/
    tbl_menu
WHERE /*2*/
    orderable_status = 'Y'
ORDER BY /*4*/
    menu_name;

-- 이름이 '붕어빵초밥'인 메뉴 조회
SELECT
    *
FROM
    tbl_menu
WHERE
    menu_name = '붕어빵초밥';

SELECT
    menu_name,
    menu_price

FROM
    tbl_menu
WHERE
    menu_price = 13000
ORDER BY
    menu_name DESC;

SELECT
    menu_code,
    menu_name,
    orderable_status
FROM
    tbl_menu
WHERE
    -- orderable_status != 'Y'
       orderable_status <> 'Y'

ORDER BY
    menu_name ASC;


SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price > '20000'
ORDER BY
    menu_code DESC;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price >= '20000'
ORDER BY
    menu_code DESC;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price < '20000'
ORDER BY
    menu_code DESC;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price <= '20000'
ORDER BY
    menu_code DESC;

/*
    2) 논리 연산자
    - 논리란? 참(TRUE), 거짓(FALSE)을 나타내는 값

*/

-- A AND B : A 와 B 모두 참(TRUE)인 경우 결과가 TRUE
--           나머진 모두 거짓(FALSE)

-- 주문가능한 상태이며, 카테고리 코드가 10에 해당하는 메뉴만 조회

SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
AND
    category_code = '10';


SELECT
    menu_code,
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    menu_price > 5000
AND
    category_code = 10
ORDER BY
    menu_code ASC;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price >= 5000
AND
    menu_price < 20000
ORDER BY
    menu_price ASC;

SELECT
    menu_name,
    menu_price,
    category_code
FROM
    tbl_menu
WHERE
    (menu_price >= 5000 AND menu_price < 20000)
AND
    category_code = 10
ORDER BY
    menu_price ASC;

-- AND 는 여러개를 사용할 수 있음. 여깃 주의할 점 ) 꼭 순서대로 시작해야함.

/* A OR B 연산자
   - 둘 다 FALSE 인 경우에만 결과가 FALSE
   - 하나라도 TRUE 이면 TRUE
*/

SELECT
    *
FROM
    tbl_menu
WHERE
    orderable_status = 'Y'
OR
    category_code = 10;

SELECT
    menu_name,
    menu_price
FROM
    tbl_menu
WHERE
    menu_price < 5000
OR
    menu_price >= 20000
ORDER BY
    category_code ASC;


/*
    AND, OR 연산 중 우선순위
    AND 가 높다 !
    * 우선순위 문제 해결 시 () 이용
*/

SELECT
    *
FROM
    tbl_menu
WHERE
    category_code = 4
OR
    menu_price = 9000
AND
    menu_code > 10;

SELECT
    *
FROM
    tbl_menu
WHERE
    menu_price = 9000
AND
    menu_code > 10;

SELECT
    *
FROM
    tbl_menu
WHERE
    (category_code = 4
OR
    menu_price = 9000)
  AND
    menu_code > 6;


/*
DATA TYPE
    1. 명시적 형변환
        - CAST(expression AS 데이터형식[(길이)])
        - CONVERT(expression, 데이터형식 [(길이)])
*/
SELECT AVG(menu_price)
FROM tbl_menu;

-- CAST()를 이용한 형변환 ANSI 표준
-- (참고) 실수 -> 정수 변환 시 소수점 반올림 자동 수행
SELECT CAST(AVG(menu_price) AS SIGNED INT) AS 메뉴평균가격
FROM tbl_menu;

-- CONVERT를 이용한 형변환 (MySQL, MariaDB)
SELECT CONVERT(AVG(menu_price), SIGNED INT) AS 메뉴평균가격
FROM tbl_menu;

SELECT CAST(SUM(menu_price) AS CHAR)
FROM tbl_menu;


-- SIGNED, UNSIGNED INTEGER 차이
-- SIGNED : 부호(+,-)를 포함한 범위의 INTEGER
-- UNSIGNED : 부호(+,-)를 포함하지 않는 범위의 INTEGER
--  -> 음수를 UNSIGNED로 변환 시 무조건 0이 된다
SELECT CAST(-123.456 AS SIGNED INT), CAST(-123.467 AS UNSIGNED INT);

-- 날짜 형태 문자열 형변환
--  -> 문자열이 (어느정도) 날짜 형식으로 인식이 되면 변환 가능
SELECT CAST('2023$5$30' AS DATE);
SELECT CAST('2023/5/30' AS DATE);
SELECT CAST('2023%5%30' AS DATE);
SELECT CAST('2023@5@30' AS DATE);

SELECT CAST('2025-11-04 11:11:12' AS DATETIME) > CAST('2025-11-03 11:11:12' AS DATETIME);

-- 메뉴 가격 문자열로 바꿔서 조회
-- (참고) 문자열로 변환 시 지정된 숫자의 크기가 문자열의 크기보다 크면 문자열 크기에 맞춰서 숫자가 잘림.
SELECT CAST(menu_price AS CHAR(5)) AS 문자열가격
FROM tbl_menu;

SELECT CONCAT(menu_price, '원') AS 문자열가격
FROM tbl_menu;

/*
2. 암시적(묵시적) 형변환
    - 연산 수행 시 자동으로 데이터 타입을 맞춰줌
*/
SELECT '1' + '2'; -- 3
SELECT 3 > 'MAY'; -- 1 : 문자열은 0으로 처리
SELECT 5 > '6MAY'; -- 0 : 제일 앞에 숫자가 있으면 그 숫자로 처리
SELECT 5 > 'M6AY'; -- 1 : 숫자가 문자열 중간에 있으면 문자열로 처리
SELECT NOW() > '2024-5-30';
/* 09_SET_OPERATORS
   - 두 개 이상의 SELECT 결과(RESULT SET)
   - UNION(합집합)
   - INTERSECT(교집합)
   - UNION ALL = UNION + INTERSECT
   - MINUS(차집합)

   !중요) '결합'하기 위해서는 두 개의 집합(RESULT SET)의 컬럼은 동일해야 한다
          +) 컬럼 자료형
*/

-- 1) UNION (합집합)
-- 두 집합의 결과를 결합
-- 단, 중복은 제거

SELECT menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM tbl_menu
WHERE category_code = 10
UNION
SELECT menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM tbl_menu
WHERE menu_price < 9000;

-- 2) UNION ALL (합집합 + 중복 포함)
SELECT menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM tbl_menu
WHERE category_code = 10
-- => 6행
UNION ALL
SELECT menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
FROM tbl_menu
WHERE menu_price < 9000;
-- => 9행
-- => 10행 = ( 6행 + 9행 ) - ( 5행 : 중복 제거)

-- 3) INTERSECT ( 교집합 )
-- 구현 1 : INNER JOIN 사용
SELECT a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
FROM tbl_menu a
         INNER JOIN (SELECT menu_code
                          , menu_name
                          , menu_price
                          , category_code
                          , orderable_status
                     FROM tbl_menu -- 인라인 뷰
                     WHERE menu_price < 9000) b
                ON (a.menu_code = b.menu_code)
WHERE a.category_code = 10;

-- 구현 2 : IN 사용
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 WHERE category_code = 10
   AND menu_code IN (SELECT menu_code
                       FROM tbl_menu
                      WHERE menu_price < 9000);

-- 4) MINUS ( 차집합 )
SELECT
       a.menu_code, B.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
  LEFT JOIN (SELECT menu_code
                  , menu_name
                  , menu_price
                  , category_code
                  , orderable_status
               FROM tbl_menu b
              WHERE menu_price < 9000) b ON (a.menu_code = b.menu_code);
 WHERE b.menu_code IS NULL;
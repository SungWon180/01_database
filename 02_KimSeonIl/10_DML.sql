/* 10_DML(Data Manipluation Language)
   - 데이터 조작 언어
   - 테이블에 값(Data)을 삽입(INSERT), 수정(UPDATE), 삭제(DELETE)하는 SQL
*/

/*1. INSERT : 새로운 행을 삽압(추가)

  [작성법]
  INSERT INTO 테이블명 VALUES(col1, col2, col3,.....);
  (테이블 컬럼 순서대로 모든 컬럼값을 values에 작성)
  */

INSERT INTO tbl_menu
    VALUE (NULL, '바나나 해장국', 8500, 4, 'Y');

-- AUTO INCREMENT : NULL 허용 PK 컬럼 NULL 삽입 시 자동으로 증가되는 숫자를 삽입한다.
-- INSERT INTO 후 수행 결과 -> 1(삽입된 행의 개수를 반환)

SELECT *
FROM tbl_menu;

/* INSERT 시 컬럼명 지정

   [작성법]
   INSERT INTO 테이블명(col1, col2, col3, ...)
   VALUES (col1 값, col2값, col3값, ..,)
 */

INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES ('초콜릿 죽', 6500, 7, 'Y');

update tbl_menu
menu_code =23
where menu_name = '초콜릿 죽';

INSERT
  INTO tbl_menu
(orderable_status, menu_price, menu_name, category_code)
VALUES
('Y', 5500, '파인애플탕', 4);

/* MULTI INSERT
   [작성법]
    INSERT INTO 테이블명 VALUES
   (COL1 값, COL2 값, ...),
   (COL1 값, COL2 값, ...),
   (COL1 값, COL2 값, ...);
 */

 INSERT
  INTO tbl_menu
VALUES
(null, '참치맛아이스크림', 1700, 12, 'Y'),
(null, '멸치맛아이스크림', 1500, 11, 'Y'),
(null, '소시지맛커피', 2500, 8, 'Y');

select *
from tbl_menu;

/* UPDATE : 테이블에 기록된 컬럼 값을 수정
   - 선택된 행, 열의 컬럼 값을 수정
   - 수정 결과 행의 개수는 0 ~ N 까지

   [작성법]
   UPDATE '테이블 명'
   SET 수정할 컬럼1 = 수정 값1
   WHERE 행 선택 조건식;

   */
select *
from tbl_menu;


update tbl_menu
set menu_name = '딸기맛붕어빵',
    category_code = 7
WHERE menu_code = 26;

-- subquery 를 이용한 수정
UPDATE tbl_menu
set category_code = (
    SELECT category_code
    from tbl_menu
    where menu_name ='죽방멸치튀김우동'
    )
WHERE menu_code =(
        SELECT menu_code
        from tbl_menu
        where menu_name ='초콜릿죽'
        );


SELECT * FROM tbl_menu
WHERE menu_code = 25;

/* DELETE : 테이블의 행을 삭제하는 구문

   [작성법]
   DELETE
   FROM  테이블명
   WHERE 행 필터링 조건
   ORDER BY 정렬기준
   LIMIT 삭제할 개수
 */
-- 26번 확인
 SELECT * FROM tbl_menu
 WHERE menu_code = 26;

-- 26번 삭제
 DELETE
 FROM tbl_menu
 WHERE menu_code = 26;

select * From tbl_menu


/* TX모드 : 수동으로 변경 후 진행

   --LIMIT을 이용한 삭제

    */

DELETE
FROM tbl_menu
# WHERE 1 = 1;
WHERE menu_code > 0; -- INDEX란 검색기능 때문에 쓴다.

DELETE FROM tbl_menu;

select * FROM tbl_menu;

/* REPLACE : 중복된 데이터를 덮어쓸 수 있음
   - INSERT, UPDATE 진행 시  PK, UNIQUE 설정 컬럼 값이 같으면 에러 발생
   - REPLACE는 에러를 무시하고 덮어씌움
 */

 INSERT INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y'); -- 에러 발생
REPLACE INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y');


-- WHERER 절 없이도 PK(menu_code) 값이 일치하는 행을 찾아서 REPLACE를 진행
REPLACE tbl_menu
    SET menu_code = 2
      , menu_name = '우럭쥬스'
      , menu_price = 2000
      , category_code = 9
      , orderable_status = 'N';

select * from tbl_menu
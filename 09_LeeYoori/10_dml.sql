/* 10_DML(Data Manipulation Language)
  - 데이터 조작 언어
  - 테이블에 값을 삽입, 수정, 삭제하는 언어
  */

-- insert : 새로운 행을 삽입 추가
-- insert into T
-- Values(c1, c2, c3 ...)
-- 테이블 컬럼 순서대로 values에 작성

insert into tbl_menu
values (null,
        '바나나해장국',
        8500,
        4,
        'Y');

select *
from tbl_menu
where menu_name like '%바나나%';

-- auto_increment : null 허용 pk컬럼에 null 삽입 시 자동으로 증가된 숫자 삽입
-- insert 수행 후 결과 > 1 : 삽입된 행의 개수를 반환


/* insert시 컬럼 지정

   [작성법]
   insert into T (c1, c2, c3...)
   values (값1,값2, 값3...)
   */

insert into tbl_menu
    (menu_name, menu_price, category_code, orderable_status)
values ('초콜릿죽', 6500,7,'Y');

select * from tbl_menu;

insert into tbl_menu(orderable_status, menu_price, menu_name,category_code)
values('Y',5500,'파인애플탕',4);

select * from tbl_menu;


/* multi insert
   insert into T
   values (c1값, c2값, c3값 ...),
   values (c1값, c2값, c3값 ...),
   values (c1값, c2값, c3값 ...),
   values (c1값, c2값, c3값 ...) ...
   */

INSERT
INTO tbl_menu
VALUES
    (null, '참치맛아이스크림', 1700, 12, 'Y'),
    (null, '멸치맛아이스크림', 1500, 11, 'Y'),
    (null, '소시지맛커피', 2500, 8, 'Y');

select * from tbl_menu;


/*
    update : 테이블에 기록된 컬럼 값을 수정
    - 선택된 행, 열의 컬럼값을 수정
    - 수정 결과 행의 개수는 0이 나올 수도 있음

    [작성법]
    update T
    set c1 = 값1
    where 조건
*/

update tbl_menu
set category_code = 7, menu_name = '딸기맛붕어빵'
where menu_code = 24;

select * from tbl_menu where menu_code = 24;

update tbl_menu
set category_code = (select category_code from tbl_menu where menu_name = '죽방멸치튀김우동')
where menu_code = (select menu_code
                   from tbl_menu
                   where menu_name = '초콜릿죽');

select * from tbl_menu where category_code = 6;

/*
    Delete : 테이블의 행을 삭제하는 구문

    [작성법]
    Delete
    from 테이블명
    where 행필터링 조건
    Limit
*/


select * from tbl_menu
where menu_code =24;

-- delete는 auto commit
delete from tbl_menu where menu_code = 24;

/* tx모드 수동으로 변경 후 작업 진행 */

-- limit을 이용한 삭제

select *
from tbl_menu
order by menu_price
limit 2;

delete
from tbl_menu
order by menu_price
limit 2;

select * from tbl_menu where menu_name like '%아이스크림%';

-- 전체 행 삭제
delete
from tbl_menu;
where 1 = 1; -- 모든행 true로 만들어서 다 삭제 시킴

select * from tbl_menu;

rollback;

/*
    replace : 중복된 데이터를 덮어쓸 수 있음
    - insert 진행 시 pk, unique 설정 컬럼 값이 같으면 에러 발생
    - replace는 에러를 무시하고 덮어씌움
*/

-- 덮어쓰기 replace(oracle에서 merger기능과 동일)
-- 에러코드 duplicate = 중복
insert into tbl_menu
values (17, '참기름소주', 5000, 10, 'Y');

replace into tbl_menu
values (17, '참기름소주', 5000, 10, 'Y');

select * from tbl_menu;

rollback;

update tbl_menu
SET menu_code = 2
  , menu_name = '우럭쥬스'
  , menu_price = 2000
  , category_code = 9
  , orderable_status = 'N'; -- 오류

-- where절 없이도 pk(menu_code)값이 일치하는 행을 찾아서 replace 진행
Replace tbl_menu
SET menu_code = 2
  , menu_name = '우럭쥬스'
  , menu_price = 2000
  , category_code = 9
  , orderable_status = 'N'; -- 같은 기본키 쓰는곳만 찾아가서 덮어씌움

/*
    set operators
    - 두 개 이상의 select 결과(result set)를 결합
    - union : 합집합
    - intersect : 교집합(maria db x)
    - unionall : 합집합 + 교집합(union + intersect)
    - minus : 차집합(maria db x)
    (중요) 집합 연산의 대상이 되는 두 result set은 컬럼 개수 동일해야함, 컬럼 자료형이 같아야함(억지로 맞출 수 있긴함)
*/

-- 1. union(합집합)
-- 두 집합의 결과를 결합하는 것
-- 단, 중복 x

select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where category_code = 10
union
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where menu_price < 9000;

-- 2. union all
-- 두 집합의 결과를 결합하는데 중복 포함
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where category_code = 10
union all
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where menu_price < 9000;

-- 3. intersect
-- 두 select 문의 결과 중 공통되는 레코드만을 반환하는 sql 연산자이다.
-- mysql을 클론해서 만든게 mariadb이므로 mysql에서 사용가능한 문법은 다 가능

-- inner join 방법
select
    a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
from tbl_menu a
inner join ( select
                 menu_code,
                 menu_name,
                 menu_price,
                 category_code,
                 orderable_status
             from tbl_menu
             where menu_price < 9000) b on (a.menu_code = b.menu_code)
where a.category_code = 10;

-- in 연산자 이용
select a.menu_code,
       a.menu_name,
       a.menu_price,
       a.category_code,
       a.orderable_status
from tbl_menu a
where category_code = 10
and menu_code in(select menu_code
                 from tbl_menu
                 where menu_price < 9000);

-- minus > left outer join
-- 첫 번째 select문의 결과에서 두번째 select문의 결과가 포함하는 레코드를 제외한 레코드를 반환하는 sql연산자
-- (첫 번째 result set에서 교집합 부분 제외)
select
    a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
from tbl_menu a
left join (select menu_code, menu_name, menu_price, category_code, orderable_status
            from tbl_menu b
            where menu_price < 9000) b on (a.menu_code = b.menu_code)
where a.category_code = 10
and b.menu_code is null;
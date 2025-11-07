select
    avg(menu_price)
from
    tbl_menu;

select
    cast(avg(menu_price) as signed integer) '메뉴 평균 가격'
from
    tbl_menu;

select
    convert(avg(menu_price), signed integer) '메뉴 평균 가격'
from
    tbl_menu;

select cast('2023$5$30' as date);
select cast('2023/5/30' as date);
select cast('2023%5%30' as date);
select cast('2023@5@30' as date);
select cast('2023.5.30' as date);
select cast('2023_5_30' as date);
select cast('2023-5-30' as date);
select cast('2023 5 30' as date);
select cast('2023,5,30' as date);

select cast('2023.5.30' as datetime);

select
    concat(cast(menu_price as char(5)), '원') '문자열 가격'
from
    tbl_menu;

select '1' + '2';
select 3>'MAY';
select 5 > '6MAY';
select 5 > 'M6AY';
select '2023-5-30';
select 4.4 > '4.5AY';

create table if not exists tb1(
    pk int primary key,
    fk int,
    col1 varchar(255),
    check(col1 in ('Y', 'N'))
);

select * from tb1;

describe tb1;
desc tb1;

insert into tb1
values(1, 10, 'Y');

create table if not exists tb2(
    pk int auto_increment primary key,
    fk int,
    col1 varchar(255),
    check(col1 in ('Y', 'N'))
);

insert into tb2
values(null, 10, 'Y');
insert into tb2
values(null, 20, 'Y');
insert into tb2
values(null, 30, 'Y');

select * from tb2;

insert into tb2
values(null, 40, 'Y');

desc tb2;

alter table tb2
add col2 int not null;

alter table tb2
drop col2;

desc tb2;

alter table tb2
change column fk change_fk decimal not null;

alter table tb2
drop primary key;
# auto increment 포함한 특성이라 삭제 불가

alter table tb2
modify pk int;

alter table tb2
drop primary key;

alter table tb2
add primary key(pk);

alter table tb2
add col3 date       not null,
add col4 tinyint    null,
add col5 char(11)   not null;

desc tb2;
select * from tb2;

create table if not exists tb3(
    pk int auto_increment primary key,
    fk int,
    col1 varchar(255),
    check(col1 in ('Y', 'N'))
) ENGINE=INNODB;

drop table if exists tb3;

-- tb6 테이블 생성
CREATE TABLE IF NOT EXISTS tb6 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- 4개 행 데이터 INSERT
INSERT INTO tb6 VALUES (null, 10, 'Y');
INSERT INTO tb6 VALUES (null, 20, 'Y');
INSERT INTO tb6 VALUES (null, 30, 'Y');
INSERT INTO tb6 VALUES (null, 40, 'Y');

-- 제대로 INSERT 되었는지 확인
SELECT * FROM tb6;

set autocommit = off;

start transaction;

delete from tb6;
select * from tb6;

rollback;
select * from tb6;

start transaction;

-- 테이블 초기화 하기
-- TRUNCATE TABLE tb6;
TRUNCATE tb6;    -- TABLE 키워드 생략 가능
select * from tb6;

rollback;
select * from tb6;
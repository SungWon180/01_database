/*
CONSTRAINTS (제약조건)
    - 테이블의 데이터(컬럼 값)가 입력 또는 수정될 때의 규칙
         EX) 특정 형태의 데이터만 삽입 가능, 꼭 값이 있어야 됨.
    - 데이터베이스 무결성 보장
*/

/*
1. NOT NULL : NULL(빈칸)을 허용하지 않는다 == 무조건 해당 컬럼에는 값이 있어야 한다.
    - NOT NULL 제약조건은 컬럼 레벨만 가능하다.
*/

DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
    user_no     INT          NOT NULL, -- 컬럼 레벨 제약 조건
    user_id     VARCHAR(255) NOT NULL,
    user_pwd    VARCHAR(255) NOT NULL,
    user_name   VARCHAR(255) NOT NULL,
    gender      VARCHAR(3),
    phone       VARCHAR(255) NOT NULL,
    email       VARCHAR(255)
) ENGINE=INNODB;

INSERT
    INTO user_notnull
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull;

-- INSERT 테스트(NOT NULL 제약 조건 위배)
INSERT
    INTO user_notnull
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', null, '이순신', '남', '010-222-2222', 'lee222@gmail.com');

/*
UNIQUE
    - UNIQUE 제약 조건이 설정된 컬럼 내에 동일한 값(중복 값)을 허용하지 않는 제약 조건
    - NULL 중복 O
*/

DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
    user_no     INT          NOT NULL,
    user_id     VARCHAR(255) NOT NULL,
    user_pwd    VARCHAR(255) NOT NULL,
    user_name   VARCHAR(255) NOT NULL,
    gender      VARCHAR(3),
    phone       VARCHAR(255) NOT NULL, -- UNIQUE, -- 컬럼 레벨 제약 조건
    email       VARCHAR(255),
    UNIQUE (phone) -- 테이블 레벨 제약 조건
) ENGINE=INNODB;
DESC user_unique;

-- 정상 데이터 INSERT
INSERT
    INTO user_unique
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;

-- INSERT 테스트 (UNIQUE 제약 조건 위배)
INSERT
    INTO user_unique
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');
-- [23000][1062] (conn=31) Duplicate entry '010-777-7777' for key 'phone'

/*
PRIMARY KEY
    - 테이블의 각 행을 구분하는 식별자 역할의 제약 조건
    - 테이블당 1개만 존재 가능 (여러 컬럼을 묶어서 하나의 PK로 설정이 가능하다)
    - UNIQUE(중복 X) + NOT NULL(빈칸 X)
        -> PK와 효과는 비슷하지만 PK가 되진 않는다.
*/
DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
    user_no     INT ,
    user_id     VARCHAR(255) NOT NULL,
    user_pwd    VARCHAR(255) NOT NULL,
    user_name   VARCHAR(255) NOT NULL,
    gender      VARCHAR(3),
    phone       VARCHAR(255) NOT NULL,
    email       VARCHAR(255),
    PRIMARY KEY (user_no) -- 테이블 레벨 제약 조건
) ENGINE=INNODB;

INSERT
    INTO user_primarykey
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_primarykey;

INSERT
    INTO user_primarykey
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3,'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');
-- [21S01][1136] (conn=31) Column count doesn't match value count at row 1
-- [23000][1062] (conn=31) Duplicate entry '2' for key 'PRIMARY'

/*
FOREIGN KEY (외래 키)
    - 참조 제약 조건
    - 참조 무결성을 위배하지 않기 위해 사용 (참조하는 곳에 존재하는 데이터인지 검사)
    - 참조(REFERENCES)된 테이블에서 제공되는 값만 사용 가능하다.
    - FK 제약 조건이 설정되면 두 테이블 간의 관계(Relationship)가 형성됨 -> RDBMS에서 제일 중요한 개념
    - 다른 테이블에서 제공되는 값 외에 NULL 사용 가능(단, FK, NOT NULL 같이 적용 시 NULL 허용 X)
*/
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade (
    grade_code INT UNIQUE,
    grade_name VARCHAR(255) NOT NULL
) ENGINE=INNODB;

INSERT
  INTO user_grade
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');
DESC user_grade;
SELECT * FROM user_grade;

-- user_grade 테이블의 grade_code값을 참조
DROP TABLE IF EXISTS user_foreignkey1;
CREATE TABLE IF NOT EXISTS user_foreignkey1 (
    user_no     INT PRIMARY KEY,
    user_id     VARCHAR(255) NOT NULL,
    user_pwd    VARCHAR(255) NOT NULL,
    user_name   VARCHAR(255) NOT NULL,
    gender      VARCHAR(3),
    phone       VARCHAR(255) NOT NULL,
    email       VARCHAR(255),
    grade_code  INT,
    -- 테이블 레벨 제약조건,
    FOREIGN KEY (grade_code) REFERENCES user_grade (grade_code)
) ENGINE=INNODB;

INSERT
    INTO user_foreignkey1
    (user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey1;

INSERT
    INTO user_foreignkey1
    (user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', 50);
/*
[23000][1452] (conn=31) Cannot add or update a child row: a foreign key constraint fails
(`menudb`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`)
REFERENCES `user_grade` (`grade_code`)
*/

-- 삭제룰이 설정되지 않은 경우(RESTRICT)
DELETE
FROM user_grade
WHERE grade_code = 10;
/*
[23000][1451] (conn=31) Cannot delete or update a parent row: a foreign key
constraint fails (`menudb`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1`
FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`))
*/

/*
두 테이블 간의 관계 형성 시(FK 설정)
    - 부모 테이블 : 참조를 당하는 테이블(참조할 값을 제공)
    - 자식 테이블 : 참조를 하는 테이블(제공 받은 값을 이용)
*/

DROP TABLE IF EXISTS user_foreignkey2;
CREATE TABLE IF NOT EXISTS user_foreignkey2 (
    user_no     INT PRIMARY KEY,
    user_id     VARCHAR(255) NOT NULL,
    user_pwd    VARCHAR(255) NOT NULL,
    user_name   VARCHAR(255) NOT NULL,
    gender      VARCHAR(3),
    phone       VARCHAR(255) NOT NULL,
    email       VARCHAR(255),
    grade_code  INT,
    FOREIGN KEY (grade_code) REFERENCES user_grade (grade_code)
    ON UPDATE SET NULL -- 부모 값이 바뀌면 참조하는 자식의 값을 NULL로 변경
    ON DELETE SET NULL -- 부모 값이 삭제되면 참조하는 자식의 값을 NULL로 변경
) ENGINE=INNODB;

INSERT
  INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey2;

-- SET NULL 삭제 옵션 테스트
-- (중요) user_foreignkey1 테이블 삭제 후 테스트 수행
-- 왜? 삭제 안하면 user_grade 수정, 삭제 시 user_foreignkey1 테이블과의 관계로 인해 에러 발생.
DROP TABLE IF EXISTS user_foreignkey1;

UPDATE user_grade
   SET grade_code = null
 WHERE grade_code = 10;

-- 자식 테이블의 grade_code가 10이 었던 회원의 grade_code값이 NULL이 된 것을 확인
SELECT * FROM user_foreignkey2;

-- user_grade(부모 테이블)에서 grade_code = 20인 행을 삭제했을 때 ON DELETE SET NULL 옵션 동작 확인.
DELETE
FROM user_grade
WHERE grade_code = 20;

/*
CHECK 제약 조건
    - 해당 컬럼에 조건에 맞는 값만 삽입/수정될 수 있도록 확인하는 제약조건.
    - SELECT의 WHERE절에 사용했던 조건식을 똑같이 사용
        EX) =, !=, >=, <=, >, <, IN, NOT IN, LIKE, NOT LIKE,......
*/

DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
    user_no     INT AUTO_INCREMENT PRIMARY KEY,
    user_name   VARCHAR(255) NOT NULL,
    gender      VARCHAR(3) CHECK(gender IN ('남','여')),
    age         INT CHECK(age >= 19)
) ENGINE=INNODB;

INSERT
    INTO user_check
    VALUES
(null, '홍길동', '남', 25),
(null, '이순신', '남', 33);

SELECT * FROM user_check;

-- gender 컬럼의 CHECK 제약 조건 위배('남성' 이라고 INSERT)
INSERT
    INTO user_check
    VALUES (null, '안중근', '남성', 27);
INSERT
    INTO user_check
    VALUES (null, '유관순', '여', 17);
/*
[23000][4025] (conn=31) CONSTRAINT `user_check.gender` failed for `menudb`.`user_check`
*/

/*
DEFAULT (기본 값)
    - INSERT/UPDATE 수행 시 컬럼에 NULL을 삽입/수정하면 대신 들어갈 기본 값을 설정.
*/
DROP TABLE IF EXISTS tbl_country;
CREATE TABLE IF NOT EXISTS tbl_country (
    country_code    INT AUTO_INCREMENT PRIMARY KEY,
    country_name    VARCHAR(255) DEFAULT '한국',
    population      VARCHAR(255) DEFAULT '0명',
    add_day         DATE DEFAULT (current_date),
    add_time        DATETIME DEFAULT (current_time)
) ENGINE=INNODB;

SELECT * FROM tbl_country;

INSERT INTO tbl_country
VALUES (null,DEFAULT,DEFAULT,DEFAULT,DEFAULT);

UPDATE tbl_country
SET country_name = DEFAULT, population = DEFAULT, add_day = DEFAULT, add_time = DEFAULT
WHERE country_code = 1;
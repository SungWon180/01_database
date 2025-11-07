
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
) ENGINE=INNODB;

INSERT
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull;

INSERT
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', null, '이순신', '남', '010-222-2222', 'lee222@gmail.com');
# notnull 에러 발생

DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255)
    , UNIQUE (phone)
) ENGINE=INNODB;

desc user_unique;

INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;

INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');



DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
--     user_no INT PRIMARY KEY,
    user_no INT,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    PRIMARY KEY (user_no)
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
(null, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');
# error. primary key cannot be null

INSERT
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(2, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');
# error. primary key cannot be duplicated



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

SELECT * FROM user_grade;

DROP TABLE IF EXISTS user_foreignkey1;

CREATE TABLE IF NOT EXISTS user_foreignkey1 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code)
		REFERENCES user_grade (grade_code)
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
# error. 참조 컬럼에 없는 값 사용

INSERT
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', NULL);

DELETE
FROM user_grade
WHERE grade_code = 10;
-- [23000][1451] (conn=26) Cannot delete or update a parent row: a foreign key constraint fails (`menudb`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`))

DROP TABLE IF EXISTS user_foreignkey2;
CREATE TABLE IF NOT EXISTS user_foreignkey2 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code)
		REFERENCES user_grade (grade_code)
        ON UPDATE SET NULL
        ON DELETE SET NULL
) ENGINE=INNODB;

INSERT
  INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey2;

DROP TABLE IF EXISTS user_foreignkey1;

UPDATE user_grade
   SET grade_code = null
 WHERE grade_code = 10;

-- 자식 테이블의 grade_code가 10이 었던 회원의 grade_code값이 NULL이 된 것을 확인
SELECT * FROM user_foreignkey2;

DELETE
  FROM user_grade
 WHERE grade_code = 20;

-- 자식 테이블의 grade_code가 20이 었던 회원의 grade_code값이 NULL이 된 것을 확인
SELECT * FROM user_foreignkey2;



DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK(gender IN ('남','여')),
    age INT CHECK(age >= 19)
) ENGINE=INNODB;

INSERT
  INTO user_check
VALUES
(null, '홍길동', '남', 25),
(null, '이순신', '남', 33);

SELECT * FROM user_check;

INSERT
  INTO user_check
VALUES (null, '안중근', '남성', 27);
# error. gender column check.

INSERT
  INTO user_check
VALUES (null, '유관순', '여', 17);
# error. age column check.



DROP TABLE IF EXISTS tbl_country;
CREATE TABLE IF NOT EXISTS tbl_country (
    country_code INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) DEFAULT '한국',
    population VARCHAR(255) DEFAULT '0명',
    add_day DATE DEFAULT (current_date),
    add_time DATETIME DEFAULT (current_time)
) ENGINE=INNODB;

SELECT * FROM tbl_country;

INSERT
  INTO tbl_country
VALUES (null, default, default, default, default);

-- values(null, null ,null, null, null)
-- null값만 들어감
SELECT * FROM tbl_country;
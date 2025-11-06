/* 11.Transcation
   - 데이터베이스에서 한번에 수행되는 작업(DML)의 단위

   - 기본적으로 MariaDB(MySQL)은 Auto-commit이 활성화된 상태
    -> 비활성화 후 작업
 */

SET AUTOCOMMIT = 1; -- AUTO-COMMIT 활성화
SET AUTOCOMMIT = ON; -- AUTO-COMMIT 활성화

SET AUTOCOMMIT = 0; -- AUTO-COMMIT 활성화
SET AUTOCOMMIT = OFF; -- AUTO-COMMIT 활성화

-- 트랜잭션 관리 시작 -> 이후에 실행되는 DML이 트랜잭션에 쌓임
START TRANSACTION;

SELECT * FROM tbl_menu;
INSERT INTO tbl_menu VALUES (null, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

-- TCL 명령어 입력시 트랜잭션 반영(COmmit) 또는 삭제(RollBack)
-- COMMIT;
ROLLBACK;

select * from tbl_menu;


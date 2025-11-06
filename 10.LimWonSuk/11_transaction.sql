/* # 11. TRANSACTION
   - 데이터베이스에서 한 번에 수행되는 작업(DML)의 단위

    - 기본적으로 Maria DB(MySQL)는 Auto-Comit 활성화된 상태
   -> 비활성화 후 작업
 */

  SET AUTOCOMMIT = 1; -- AUTO-Commit 활성화
  SET AUTOCOMMIT = ON; -- AUTO-Commit 활성화

  SET AUTOCOMMIT = 0; -- AUTO-Commit 비활성화
  SET AUTOCOMMIT = OFF; -- AUTO-Commit 비활성화

-- TRANSACTION 관리 시작 -> 이후에 실행되는 DML이 TRANSACTION에 쌓임
  START TRANSACTION;

SELECT * FROM
             tbl_menu;
INSERT INTO
    tbl_menu
VALUES (
        null,
        '바나나해장국',
        8500,
        4,
        'Y'
       );

UPDATE
    tbl_menu
SET
    menu_name = '수정된 메뉴'
WHERE
    menu_code = 5;
DELETE FROM
           tbl_menu
       WHERE
           menu_code = 7;

SELECT * FROM tbl_menu;

-- TCL 명령어 입력 시 TRANSACTION 반영(COMMIT)
또는 삭제(ROLLBACK)
     ROLLBACK;

SELECT * FROM tbl_menu;


SELECT ASCII('A'), CHAR(65);

SELECT BIT_LENGTH('pie'), CHAR_LENGTH('pie'), LENGTH('pie');
SELECT menu_name, BIT_LENGTH(menu_name), CHAR_LENGTH(menu_name), LENGTH(menu_name) from tbl_menu;

SELECT CONCAT('호랑이', '기린', '토끼');
SELECT CONCAT_WS(',', '호랑이', '기린', '토끼');
SELECT CONCAT_WS('-', '2023', '05', '31');

SELECT
       ELT(2, '사과', '딸기', '바나나')
     , FIELD('딸기', '사과', '딸기', '바나나')
     , FIND_IN_SET('바나나', '사과,딸기,바나나')
     , INSTR('사과딸기바나나', '딸기')
     , LOCATE('딸기', '사과딸기바나나');

SELECT FORMAT(123142512521.5635326, 3);

SELECT LPAD('왼쪽', 6, '@'), RPAD('오른쪽', 6 ,'@');

SELECT LTRIM('    왼쪽'), RTRIM('오른쪽    ');

SELECT TRIM('    MySQL    '), TRIM(BOTH '@' FROM '@@@@MySQL@@@@');
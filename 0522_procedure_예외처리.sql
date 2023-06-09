-- 예외 발생
use shopdb;
select * from usertbl;
select * from notable;
select * from buytbl;

delimiter $$
create procedure Exception_Test02()
begin
	declare continue handler for 1146 select '해당 테이블이 없당께' as 'error_msg';
	declare continue handler for 1136 
    select 'insert시 value의 column이 다릅니다..' as 'error_msg';
    select * from usertbl;
	select * from notable;
	select * from buytbl;
    insert into usertbl values(1);
    select 'result' as '끝';
end $$
delimiter ;

call Exception_Test02();

-- 03 모든예외 받기
delimiter $$
create procedure Exception_Test03()
begin
	declare continue handler for SQLEXCEPTION select '예외' as 'error_msg';
    
    select * from usertbl;
	select * from notable;
	select * from buytbl;
    insert into usertbl values(1);
    select 'result' as '끝';
end $$
delimiter ;
CALL Exception_Test03();
-- 04 예외 코드 확인
delimiter $$
create procedure Exception_Test04()
begin
	declare continue handler for SQLEXCEPTION 
    begin
		show errors;
    end;
    
    select * from usertbl;
	select * from notable;
	select * from buytbl;
    insert into usertbl values(1);
    select 'result' as '끝';
end $$
delimiter ;	

call Exception_Test04();
-- 시험 문제로 나올ㄹ거임
-- 05 error_log 기록하는 테이블처리
create table tbl_std(id varchar(20) primary key, name char(10), age int);
drop table tbl_std_errlog;
create table tbl_std_errlog(error_date datetime, error_code int, error_msg text);
show errors;

drop procedure tbl_std_proc;
delimiter $$
create procedure tbl_std_proc(in id varchar(20), in name char(10),in age varchar(10))
begin
	declare error_code varchar(5);
    declare error_message varchar(255);
	-- pk 중복 예외 처리
	declare continue handler for 1062
    begin
		show errors;
        get diagnostics condition 1
			error_code=mysql_errno,
            error_message=message_text;
		-- select error_code,error_message;
        insert into tbl_std_errlog values(now(),error_code,error_message);
    end;
    -- exception code 1265
    declare continue handler for 1265
    begin
		show errors;
        get diagnostics condition 1
			error_code=mysql_errno,
            error_message=message_text;
		-- select error_code,error_message;
        insert into tbl_std_errlog values(now(),error_code,error_message);
        set age=0;
        insert into tbl_std values(id,name,age);
    end;
	insert into tbl_std values(id,name,age);
    select * from tbl_std;
end $$
delimiter ;
call tbl_std_proc('aa','홍길동',10);
call tbl_std_proc('ab','남길동',20);
call tbl_std_proc('af','남길동','5-');
select * from tbl_std_errlog;
select * from tbl_std;
show errors;

-- 프로시저(예외처리 + 트랜젝션)
delete from tbl_std;
select * from tbl_std;
drop procedure tbl_std_proc_tx;
delimiter $$
create procedure tbl_std_proc_tx()
begin
	declare exit handler for sqlexception
    begin
		show errors;
		rollback; -- 문제가 발생했을때 rollback처리
    end;
    start transaction;
		insert into tbl_std values('f','hoho',11);
		insert into tbl_std values('g','hoho',12);
		insert into tbl_std values('f','hoho',13);
		insert into tbl_std values('i','hoho',14);
        commit; -- 문제가 발생하지 않았을때 정상 처리
		select * from tbl_std;
end $$
delimiter ;
call tbl_std_proc_tx();
select * from tbl_std;


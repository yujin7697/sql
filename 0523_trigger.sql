-- 01 After Trigger
use shopdb;
drop table c_usertbl;
select * from usertbl;
create table c_usertbl select * from usertbl; -- tbl 복사(내용까지)
select * from c_usertbl;
create table c_usertbl_bak like c_usertbl; -- tbl 구조 복사
select * from c_usertbl_bak;
alter table c_usertbl_bak add column type char(5);
alter table c_usertbl_bak add column U_D_date char(5);
alter table c_usertbl_bak change column U_D_date U_D_date datetime;
select * from c_usertbl_bak;

delimiter $$
create trigger trg_c_usertbl_update
after update -- update시 사용되는 trigger
on c_usertbl
for each row
begin 
	insert into c_usertbl_bak values(
    old.userid,old.name,old.birthyear,old.addr,old.mobile1,old.mobile2,old.height,old.mdate,
    '수정',now()
    );
end $$
delimiter ;

show triggers;
show create trigger trg_c_usertbl_update;
select * from c_usertbl;
select * from c_usertbl_bak;
update c_usertbl set name='바비' where userid='BBK';
update c_usertbl set addr='경남' where userid='EJW';
select * from c_usertbl;
select * from c_usertbl_bak;

-- 02 trigger 삭제
delimiter $$
create trigger trg_c_usertbl_delete
after delete -- delete시 사용되는 trigger
on c_usertbl
for each row
begin 
	insert into c_usertbl_bak values(
    old.userid,old.name,old.birthyear,old.addr,old.mobile1,old.mobile2,old.height,old.mdate,
    '삭제',now()
    );
end $$
delimiter ;

delete from c_usertbl where userid='KKH';
select * from c_usertbl_bak;

-- buytbl의 c_buytbl의 구조+값복사alter
-- c_buytbl의 주고만 복사한 c_buytbl_bak 만들기
-- c_buytbl_bak에 typ char(5)와 mdate datetime을 열로 추가
-- c_buytbl의 update시 c_buytbl_bak에 내용 저장되는 trg_c_buytbl_update 트리거 만들기
-- c_buytbl의 delete시 c_buytbl_bak에 내용 저장되는 trg_c_buytbl_delete 트리거 만들기
create table c_buytbl select * from buytbl;
select * from c_buytbl;
create table c_buytbl_bak like buytbl;
select * from c_buytbl_bak;
alter table c_buytbl_bak add column type char(5);
alter table c_buytbl_bak add column U_D_date char(5);
select * from c_buytbl_bak;
delimiter $$
create trigger trg_c_buytbl_update
after update -- update시 사용되는 trigger
on c_buytbl
for each row
begin 
	insert into c_buytbl_bak values(
    old.num,old.userid,old.prodname,old.groupname,old.price,old.amount,
    '수정',now()
    );
end $$
delimiter $$
create trigger trg_c_buytbl_delete
after delete -- update시 사용되는 trigger
on c_buytbl
for each row
begin 
	insert into c_buytbl_bak values(
    old.num,old.userid,old.prodname,old.groupname,old.price,old.amount,
    '삭제',now()
    );
end $$
select * from c_buytbl;
-- show create trigger trg_c_buytbl_update;
update c_buytbl set groupname='전자전기찌릿찌릿' where userid='KBS';
update c_buytbl set userid='봑진영' where prodname='책';
select * from c_buytbl;
select * from c_buytbl_bak;









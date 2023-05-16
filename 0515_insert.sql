use shopdb;

create table tbl_copy_buytbl(select * from buytbl);
select * from tbl_copy_buytbl;
desc tbl_copy_buytbl;
delete from tbl_copy_buytbl where num>=6;
-- 01 insert value 값 여러개 넣기
insert into tbl_copy_buytbl(num,userid,prodname,groupname,price,amount)
values
(9,'aaa','운동화','의류',1000,2),
(10,'aaa','운동화','의류',1000,2),
(11,'aaa','운동화','의류',1000,2),
(12,'aaa','운동화','의류',1000,2);

select * from tbl_copy_buytbl;
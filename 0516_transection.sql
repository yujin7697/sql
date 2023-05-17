create table if not exists tbl_test(
no int primary key,
name varchar(20),
age int,
gender varchar(1)
);
select * from tbl_test;
desc tbl_test;
-- desc tbl_test;

delete from tbl_test;
insert into tbl_test values(1,'aa',66,'w'); -- commit
insert into tbl_test values(2,'aa',66,'w'); -- commit
insert into tbl_test values(3,'aa',66,'w'); -- commit
select * from tbl_test;
commit;

start transaction;
	insert into tbl_test values(4,'aa',66,'w');
    insert into tbl_test values(5,'aa',66,'w');
    insert into tbl_test values(6,'aa',66,'w');
rollback;

start transaction;
	savepoint s1;
	insert into tbl_test values(4,'aa',66,'w');
    insert into tbl_test values(5,'aa',66,'w');
    insert into tbl_test values(6,'aa',66,'w');
    rollback to s1;
    savepoint s2;
    insert into tbl_test values(7,'aa',66,'w');
    insert into tbl_test values(8,'aa',66,'w');
    rollback to s2;
    savepoint s3;
    insert into tbl_test values(9,'aa',66,'w');
	insert into tbl_test values(10,'aa',66,'w');
	rollback to s3;
    select * from tbl_test;
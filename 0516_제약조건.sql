use shopdb;

-- pk 제약 조건

-- 01 테이블 생성시 pk 설정
create table tbl_Test01
(
	id char(10) primary key,
    name char(10) not null
);
desc tbl_Test01;

create table tbl_Test02
(
	id char(10) ,
    name char(10) not null,
    primary key(id)
);
desc tbl_Test02;

create table tbl_Test03
(
	id char(10) ,
    name char(10) not null,
    primary key(id,name)
);
desc tbl_Test03;

-- 확인
select * from INFORMATION_SCHEMA.COLUMNS
where table_schema='shopdb' 
and table_name='tbl_test03'
and column_key='PRI';

-- 02 PK 설정(테이블 생성 이후)
create table tbl_Test04
(
	id char(10) ,
    name char(10) not null
);
desc tbl_Test04;

-- alter을 사용하여 제약조건 설정
alter table tbl_Test04 add constraint PK_tbl_Test04 primary key(id,name);
desc tbl_Test04;

-- 03 PK 제거
desc tbl_Test01;
alter table tbl_Test01 drop primary key;
desc tbl_Test01;

-- 문제
-- buytbl을 구조+데이터 복사하고 num를 primary key로 설정
create table tbl_buytbl_copy(select * from buytbl);
desc tbl_buytbl_copy;
alter table tbl_buytbl_copy add constraint PK_tbl_buytbl_copy primary key(num);
select * from tbl_buytbl_copy;

-- FK 제약 조건(자료형 일치)
desc tbl_test01;
create table tbl_test01_FK
(
	no int  primary key,
    id char(10)	not null,
    constraint FK_test01_FK_test01 foreign key(id) references tbl_Test01(id)
);
desc tbl_test01_FK;

-- on update, ont delete 옵션
-- cascade		: pk열의 값이 변경시 fk열의 값도 함께 변경
-- no action	: pk열의 값이 변경시 fk열의 값은 변경 X
-- restrict		: pk열의 값이 변경시 fk열의 값의 변경 차단
-- set null		: pk열의 값이 변경시 fk열의 값을 null로 설정
-- set default	: pk열의 값이 변경시 fk열의 값은 default로 설정된 기본값을 적용
 
create table tbl_test02_FK
(
	no int  primary key,
    id char(10)	not null,
    constraint FK_test02_FK_test02 foreign key(id) references tbl_Test01(id)
    on update cascade 
    on delete cascade
);
desc tbl_test02_FK;

create table tbl_test03_FK
(
	no int  primary key,
    id char(10),
    constraint FK_test03_FK_test03 foreign key(id) references tbl_Test01(id)
    on update cascade 
    on delete set null
);
desc tbl_test03_FK;

-- mysql 에서는 fk 설정시 자동으로 해당열이 index열로 지정됨\
create table tbl_test04_FK
(
	no int  primary key,
    id char(10)
);
desc tbl_test04_FK;
alter table tbl_test04_FK add 
constraint FK_tbl_test01_test04_FK foreign key(id) references tbl_test01(id)
on update cascade
on delete cascade;


-- 문제
-- buytbl 을 copy_buytbl로 구조 + 테이블 복사 이후
-- num을 pk 설정
-- userid를 fk 설정(on delete Restrict on update cascade)
create table copy_buytbl(select * from buytbl);
alter table copy_buytbl add constraint PK_copy_buytbl primary key(num);
alter table copy_buytbl add constraint FK_copy_buytbl foreign key(userid) references usertbl(userid)
on update cascade
on delete restrict;
select * from copy_buytbl;

-- update / delete 시 옵션 적용 확인

-- fk열이 포함되어져 있는 테이블의 데이터 삭제시 x
drop table tbl_test01_fk; -- fk열이 있는 테이블은 삭제 가능
drop table tbl_test01; -- pk가 fk가 있는 테이블과 연결되어 있을때는 삭제가 x
desc tbl_test;
drop table tbl_test;

-- fk가 걸려있는 pk 테이블 강제 삭제
set foreign_key_checks=0;
drop table tbl_test01;
set foreign_key_checks=1;

-- -----------------------------------
-- UNIQUE 제약 조건(중복 허용x, null)
-- -----------------------------------
create table tbl_test05
(
	id int primary key,
    name varchar(25),
    email varchar(50) unique
);
create table tbl_test06
(
	id int primary key,
    name varchar(25),
    email varchar(50),
    constraint uk_email unique(email)
);
create table tbl_test07
(
	id int primary key,
    name varchar(25),
    email varchar(50)
);
alter table tbl_test07 add constraint uk_tbl_test07_email
unique(email);
desc tbl_test07;

-- 삭제
alter table tbl_test07 drop constraint uk_tbl_test07_email;

-- 확인
show create table tbl_test07;

-- -----------------------------------
-- check 제약조건
-- -----------------------------------
create table tbl_test08
(
	id varchar(20) primary key,
    name varchar(20) not null,
    age int check(age>=10 and age<=50),		-- age는 10 - 50세 까지만 입력가능
    addr varchar(5), -- addr은 서울,대구,인천만 가능하도록 설정
    constraint ck_addr check(addr in('서울','대구','인천'))
);
desc tbl_test08;
show create table tbl_test08;
select * from information_schema.check_constraints;

alter table tbl_test08 drop check ck_addr;

-- -----------------------------------
-- default 설정
-- -----------------------------------
create table tbl_test09
(
	id varchar(20) primary key,
    name varchar(20) default '이름없음',
    age int check(age>=10 and age<=50) default 20,		-- age는 10 - 50세 까지만 입력가능
    addr varchar(5) default '집없음', -- addr은 서울,대구,인천만 가능하도록 설정
    constraint ck_addr check(addr in('서울','대구','인천'))
);
desc tbl_test09;
alter table tbl_test09 alter column name set default'홍길동';
desc tbl_test09;

alter table tbl_test09 alter column age drop default;
desc tbl_test09;













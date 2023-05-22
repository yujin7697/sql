-- 01
use test_0519;
create table tbl_member(
	member_id int not null, 
    member_name varchar(10) not null,
    member_identity varchar(10),
    member_grade char(3) not null,
    member_addr varchar(100) not null,
    member_phone varchar(20)
    );
create table tbl_book(
	book_code int not null,
    classification_id int not null,
    book_author varchar(45),
    book_name varchar(45),
    poblisher varchar(45),
    isrental char(1) not null
);
create table tbl_rental(
	rental_id int not null,
    book_code int not null,
    member_id int not null
);
-- 02
alter table tbl_member add constraint pk_member_id primary key(member_id);
alter table tbl_member modify column member_id int auto_increment;
-- 03
alter table tbl_book add constraint pk_book_code primary key(book_code);
alter table tbl_book modify column book_code int auto_increment;
-- 04
alter table tbl_rental add constraint pk_rental_id primary key(rental_id);
alter table tbl_rental modify column rental_id int auto_increment;
-- 05
alter table tbl_rental add constraint fk_book_code 
foreign key(book_code) references tbl_book(book_code)
on update restrict
on delete cascade;
-- 06
alter table tbl_rental add constraint fk_member_id
foreign key(member_id) references tbl_member(member_id)
on update cascade
on delete cascade;
-- 07
insert into 
tbl_member(member_id,member_name,member_identity,member_grade,member_addr,member_phone)
values 
(111,'aaa','111','일반','대구','010-111-2222'),
(222,'bbb','222','VIP','울산','010-111-2222'),
(333,'ccc','333','VIP','인천','010-111-2222'),
(444,'ddd','444','일반','부산','010-111-2222'),
(555,'eee','555','VIP','서울','010-111-2222'),
(666,'fff','666','일반','경기','010-111-2222');
select * from tbl_member;

insert into
tbl_book(book_code,classification_id,book_author,book_name,poblisher,isrental)
values
(1010,1,'윤성우','열혈C','오렌지미디어','1'),
(1011,1,'남궁성','JAVA의 정석','oo미디어','1'),
(1012,1,'남길동','이것이리눅스다','한빛미디어','1'),
(2010,2,'데일카네기','인간관계론','oo미디어어','1'),
(2011,2,'홍길동','미움받을용기','oo미디어','1');
select * from tbl_book;

insert into
tbl_rental(rental_id,book_code,member_id)
values
(1,1010,111),
(2,1011,222),
(3,1012,333);
select * from tbl_rental;


-- 08
show create table tbl_member;
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where TABLE_SCHEMA='test_0519';

-- 09
create INDEX idx_member_addr
on tbl_member(member_addr);
show index from tbl_member;

create INDEX idx_book
on tbl_book(book_author,book_name,poblisher);
show index from tbl_book;

-- 10
create or replace view View_ShowRental
as 
select R.rental_id,M.member_name,B.book_name
from tbl_Rental R
inner join tbl_member M
on R.member_id=M.member_id
inner join tbl_book B
on R.book_code=B.book_code;
select * from View_ShowRental;






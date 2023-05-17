use shopdb;
create table test_01
(
	col1 int primary key,
    col2 int
);
show index from test_01;

-- ---------------
-- index
-- ---------------
-- 데이터 베이스 테이블의 검색 기능을 향상시키기 위해 이용 사용되는 데이터구조
-- where 이하 조건절열에  index로 지정된 열을 사용
-- index 로 지정된 열은 기본적으로 정렬처리가 됨
-- unique index(pk,unique 제약 조건시 기본설정됨)와 non_unique index로 나눠짐

-- my sql index 종류
-- b-tree : 기본값, 대부분의 데디터 index에 잘 적용되어 사용
-- hash :  해시 함수를 이용한 index, 정확한 일치 검색 내용
-- full-text : 전체 텍스트 검색에 사용되는 index, 텍스트 검색 기능 향상
-- spatial : 공간데이터(위도/경도)을 처리하기 위한 index 가장 정보 검색에 유리

create table test_02
(
	col1 int primary key,
    col2 int unique,
    col3 int
);
show index from test_02;

-- pk 열을 기준으로 b-tree 검색시 용이하도록 오름차순 정렬이 된다
-- unique 열은 자동 정렬되는 열은 아니다
create table test_03
(
	col1 int primary key,
    col2 int ,
    col3 int,
    index col2_3_index(col2,col3)
);
show index from test_03;
drop table test_03;
create table test_04
(
	col1 int primary key,
    col2 int ,
    col3 int,
    unique index col2_3_index(col2,col3)
);
show index from test_04;
create table test_05
(
	col1 int,
    col2 int,
    col3 int
    
);
show index from test_05;
create index col1_idx on test_05(col1);
create unique index col1_unique_idx on test_05(col2);
show index from test_05;
create table test_06
(
	num int primary key,
    userid char(8) not null,
    constraint fk_usertbl_test_06 foreign key(userid) references usertbl(userid)
    on update cascade
    on delete cascade
);
show index from test_06;
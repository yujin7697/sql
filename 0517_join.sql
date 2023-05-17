use shopdb;

-- Inner Join
-- on이하의 조건절이 만족되는 열만 출력

-- 01 inner join 기본
select * from usertbl;
select * from buytbl;
select * 
from usertbl
inner join buytbl
on usertbl.userid = buytbl.userid; -- 구매한 고객 내역만 보여줌
-- 02 inner join 이름 충돌 에러
select usertbl.userid,name,prodname,groupname, price, amount 
from usertbl
inner join buytbl
on usertbl.userid = buytbl.userid; 

-- 03 inner join 테이블 별칭 지정
select U.userid,name,prodname,groupname, price, amount 
from usertbl U
inner join buytbl B
on U.userid = B.userid; 

-- 03 inner join + where
select U.userid,name,prodname,groupname, price, amount 
from usertbl U
inner join buytbl B
on U.userid = B.userid
where amount>=5; 

-- 중간문제
-- 01.
select B.userid,birthyear,prodname,groupname 
from buytbl B
inner join usertbl U
on U.userid=B.userid
where U.name = '바비킴';

-- 02.
select name,addr,prodname,concat(mobile1,'-',mobile2) as phone
from usertbl U
inner join buytbl B
on U.userid=B.userid
where amount*price >= 100;

-- 03.
select U.userid,name,birthyear,prodname
from usertbl U
inner join buytbl B
on U.userid=B.userid
where groupname='전자';

use classicmodels;
select * from products;
select * from orderdetails;
select * 
from products P
inner join orderdetails O
on products.productCode=orderdetails.productCode;

-- ------------------------------
-- outer join
-- ------------------------------

-- left outer(on이하의 조건을 만족하지 않는 left테이블의 행도 출력)
select * 
from usertbl
left outer join buytbl
on usertbl.userid=buytbl.userid;

-- right outer join
select * 
from buytbl
right outer join usertbl
on usertbl.userid = buytbl.userid;

-- full outer join(on 조건을 만족하지 않는 left,right 테이블의 행도 출력)
-- mysql 에서는 full outer join을 지원하지 않는다
-- 대신 union을 사용하여 left,right outer join을 연결한다
select * from usertbl left join buytbl on usertbl.userid=buytbl.userid
union
select * from usertbl right join buytbl on usertbl.userid=buytbl.userid;


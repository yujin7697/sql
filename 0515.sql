-- 01 group by (집계함수와 함께 사용)
use shopdb;
select userid,sum(amount) from buytbl group by userId;
select userid,sum(amount*price) from buytbl group by userId; -- 구매 총 액수
select userid,sum(amount*price) as '구매총액' from buytbl group by userId; 
select userid,avg(amount) as '구매평균' from buytbl group by userId; 
-- truncate(,) 실수 자릿수 표시
select userid,truncate(avg(amount),2) as '구매평균' from buytbl group by userId; 
-- max(),min()
-- tlqkf tlqkf tlqkf 
select max(height) from usertbl;
select min(height) from usertbl;
-- 가장 큰 키와 가장 작은 키를 가지는 유저의 모든 열 값을 출력해보세요.
select * from usertbl;
select * from usertbl 
where height=(select min(height) from usertbl) 
or height=(select max(height) from usertbl);
-- count()
select count(*)  from usertbl;
select count(mobile1) from usertbl;

-- 중간 문제
-- 01
use shopdb;
select userid,sum(amount) from buytbl group by userid;
-- 02
select truncate(avg(height),2) from usertbl;
-- 03 
-- group by 와 where 을 같이 쓸 수 없음
select userid,amount from buytbl 
where amount=(select min(amount) from buytbl)
or amount=(select max(amount) from buytbl);
-- 04 
select count(groupname) from buytbl;
select * from buytbl where groupname is not null;
select * from buytbl where groupname is null;

-- classicmodels의 db문제
-- 01
use classicmodels;
select city,truncate(avg(creditLimit),2) from customers group by city;

-- 02
select * from orderdetails;
select ordernumber,sum(quantityOrdered) from orderdetails group by ordernumber;

-- 03
select productVendor,sum(quantityInStock) from products group by productVendor;



-- 02 group by + having (where 조건절은 사용할 수 없음)

-- buytbl에서 userid 별로 aomunt 총합
use shopdb;
select userid,sum(amount) as '총량' from buytbl 
group by userid
having sum(amount)>=5;

select * from buytbl;
select groupname,sum(amount) from buytbl 
group by groupname
having sum(amount)>5;

select * from usertbl;
select avg(height),addr from usertbl 
group by addr
having avg(height)>=170;

-- 03 rollup
select num,groupname,sum(price*amount) 
from buytbl
group by groupname,num
with rollup;

select * from usertbl;
select userid,addr,avg(height) from usertbl 
group by addr,userid
with rollup;

select groupname,sum(price*amount) 
from buytbl
group by groupname
with rollup;

select addr,avg(height) from usertbl 
group by addr
with rollup;

-- 01
select userid,prodname,sum(price*amount) from buytbl
group by prodname,userid;
-- 02 
select userid,prodname,sum(price*amount) from buytbl
group by prodname,userid
having sum(price*amount)>=1000;
-- 03
select distinct userid,prodname,price from buytbl 
where price=(select min(price) from buytbl)
or price=(select max(price) from buytbl);
-- 04
select * from buytbl 
where groupname is not null;
-- 05
select prodname,sum(price*amount) from buytbl
group by prodname
with rollup;
select num,prodname,sum(price*amount) from buytbl
group by prodname,num
with rollup;
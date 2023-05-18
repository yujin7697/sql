use shopdb;
select * from buytbl;
select userid,
sum(if(prodname='모니터',amount,0)) as '모니터',
sum(if(prodname='책',amount,0)) as '책',
sum(if(prodname='청바지',amount,0)) as '청바지',
sum(if(prodname='메모리',amount,0)) as '메모리',
sum(amount) as '합계'
from buytbl
group by userid with rollup;

-- 문제1
select * from usertbl;
select 
sum(if(addr='서울',1,0) ) as '서울',
sum(if(addr='경기',1,0) ) as '경기',
sum(if(addr='경남',1,0) ) as '경남',
sum(if(addr='경북',1,0) ) as '경북',
sum(if(addr='전남',1,0) ) as '전남',
count(addr) as '총계'
from usertbl;

-- 문제2
select userid,
sum(if(groupname='전자',1,0)) as '전자',
sum(if(groupname='의류',1,0)) as '의류',
sum(if(groupname='서적',1,0)) as '서적',
sum(if(groupname is null ,1,0)) as '없음',
count(*) as '유저별 합'
from buytbl 
group by userid with rollup;

select * from usertbl;
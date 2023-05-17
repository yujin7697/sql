use sqldb;
-- [학생Tbl]
CREATE TABLE stdTbl(
	stdName CHAR(10) NOT NULL PRIMARY KEY,
	addr CHAR(4) NOT NULL
);
-- [동아리Tbl]
CREATE TABLE clubTbl(
	clubName CHAR(10) NOT NULL PRIMARY KEY,
	roomNo CHAR(4) NOT NULL
);
-- [학생동아리Tbl]
CREATE TABLE stdclubTbl(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	stdName CHAR(10) NOT NULL,
	clubName CHAR(10) NOT NULL,
    FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
	FOREIGN KEY(clubName)REFERENCES clubTbl(clubname)
);

INSERT INTO stdTbl VALUES
('김범수','경남'),('성시경','서울'),('조용필','경기'),('은지원','경북'),('바비킴','서울');

INSERT INTO clubTbl VALUES
('수영','101호'),('바둑','102호'),('축구','103호'),('봉사','104호');

INSERT INTO stdclubTbl VALUES
(null,'김범수','바둑'),(null,'김범수','축구'),(null,'조용필','축구'),(null,'은지원','축구'),(null,'은지원','봉사'),(null,'바비킴','봉사');

use sqldb;
select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

-- inner join
select num,S.stdname,addr,C.clubname,roomno
from stdtbl S
inner join stdclubtbl SC
on S.stdname = SC.stdname
inner join clubtbl C
on SC.clubname = C.clubName;

-- left outer join
select num,S.stdname,addr,C.clubname,roomno
from stdtbl S
left outer join stdclubtbl SC
on S.stdname = SC.stdname
left outer join clubtbl C
on SC.clubname = C.clubName;

-- right outer join
select num,S.stdname,addr,C.clubname,roomno
from stdtbl S
right outer join stdclubtbl SC
on S.stdname = SC.stdname
right outer join clubtbl C
on SC.clubname = C.clubName;

select *
from stdtbl S
left outer join stdclubtbl SC
on S.stdname = SC.stdname
union
select *
from stdclubtbl SC
right outer join clubtbl C
on SC.clubname = C.clubName;

-- 문제
use classicmodels;
select * from products P
inner join orderdetails OD on P.productcode = OD.productcode
inner join orders O on O.orderNumber=OD.ordernumber
inner join customers C on O.customerNumber = C.customerNumber;








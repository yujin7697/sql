-- 프로시저 반환값 지정(return값받아옴)

use shopdb;
select * from usertbl;

select userid from usertbl where height=174;
drop procedure proc_output_test;
delimiter $$
create procedure proc_output_test(in param int, out returnval char(100))
begin
	select userid into returnval from usertbl where height=param; -- userid뒤에 into를 사용하여 userid값을 변수에 저장할 수 있음
    
end $$
delimiter ;
set @rvalue = ''; -- 변수 선언
call proc_output_test(174,@rvalue);
select @rvalue;

select * from buytbl;
drop procedure proc_getMaxValue;
delimiter $$
create procedure proc_getMaxValue(in col char(100),out maxval char(100))
begin
    select 
    case col
		when 'amount' then max(amount)
        when 'price' then max(price)
	end
    from buytbl;
end $$
delimiter ;
set @maxv ='';
call proc_getMaxValue('amount',@maxv);
select @maxv;
call proc_getMaxValue('price',@maxv);
select @maxv;

-- usertbl 에서 특정 열 이름을 in으로 받아 min과 avg를 out하는 프로시저를 만드시오
select * from usertbl;
delimiter $$
create procedure proc_getMinValue(in col char(100),out minval char(100),out avrval char(100))
begin
	select
    case col
		when 'userid' then min(userid)
        when 'birthYear' then min(birthYear)
        when 'height' then min(height)
	end into minval
    from usertbl;
    select
    case col
		when 'userid' then avg(userid)
        when 'birthYear' then avg(birthYear)
        when 'height' then avg(height)
	end into avrval
    from usertbl;
end $$
delimiter ;

set @minv= '';
set @avgv= '';
call proc_getMinValue('height',@minv,@avgv);
select @avgv,@minv;
call proc_getMinValue('birthYear',@minv,@avgv);
select @avgv,@minv;





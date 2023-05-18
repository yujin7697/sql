use shopdb;
-- json_object : key와 value 형태로 데이터 저장
select json_object('name','홍길동','height',182) as 'JSON Data';
set @var=10; -- 10이라는 값을 var 변수에 넣어줌
select @var; -- 권장하지 않음
set @Json_Data = json_object('name','홍길동','height',182);
select @Json_Data;

set @Json_Data2='{"name":"홍길동","height":182}';
select @Json_Data2;

set @Json_Data3='{
	"userInfo" : 
    [
		{"name":"홍길동","age":55,"addr":"대구"},
        {"name":"남길동","age":22,"addr":"울산"},
        {"name":"동길동","age":33,"addr":"인천"}
    ]

}';

select @Json_Data3;

select json_search(@Json_Data3,'one','남길동');
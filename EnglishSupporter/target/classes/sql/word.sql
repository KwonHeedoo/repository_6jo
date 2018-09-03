drop table exceptionword purge;


-- 예외 단어 Table
create table exceptionword(
word varchar2(30) not null	-- 예외 단어
, status number default 0 not null constraint exword_status_ck check(status in(0, 1))	-- 예외 여부
);


select * from exceptionword;
select word from exceptionword where status = 1;
drop table exceptionword purge;


-- ���� �ܾ� Table
create table exceptionword(
word varchar2(30) not null	-- ���� �ܾ�
, status number default 0 not null constraint exword_status_ck check(status in(0, 1))	-- ���� ����
);


select * from exceptionword;
select word from exceptionword where status = 1;
drop table visitor purge;

-- ¹æ¹®ÀÚ
create table visitor(
userid varchar2(20) not null
, regdate date default sysdate
);

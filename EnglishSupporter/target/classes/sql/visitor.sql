drop table visitor purge;

-- �湮��
create table visitor(
userid varchar2(20) not null
, regdate date default sysdate
);

drop table report purge;
drop sequence report_seq;
drop table sanction purge;

-- 신고 Table
create table report(
reportnum number primary key        -- 신고 번호
, reporter varchar2(20) not null    -- 신고자
, reportee varchar2(20) not null    -- 신고 당한 대상자
, report varchar2(2000) not null    -- 신고 내용
, reason varchar2(2000) not null    -- 신고 이유
, regdate date default sysdate      -- 신고 날짜
, reporturl varchar2(300) not null  -- 신고URL
);

-- 신고 번호 Sequence
create sequence report_seq
increment by 1
start with 1;

-- 재제 Table
create table sanction(
userid varchar2(20) primary key     -- 재제 대상자
, attention number default 0        -- 경고
, starttime date default sysdate    -- 재제 시작일
, endtime date default sysdate + 7  -- 재제 종료일
);
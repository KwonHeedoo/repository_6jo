drop table report purge;
drop sequence report_seq;
drop table sanction purge;
drop sequence sanction_seq;

-- 신고 Table
create table report(
reportnum number primary key        -- 신고 번호
, reporter varchar2(20) not null    -- 신고자
, reportee varchar2(20) not null    -- 신고 당한 대상자
, report varchar2(2000) not null    -- 신고 내용
, reason varchar2(2000) not null    -- 신고 이유
, regdate date default sysdate      -- 신고 날짜
, reporturl varchar2(300) not null  -- 신고URL
, status number default 0 not null constraint report_status_ck check(status in(0, 1))	-- 신고 인정 여부(인정되지 않은 상태 0, 신고 인정된 상태 1)
);

-- 신고 번호 Sequence
create sequence report_seq
increment by 1
start with 1;

-- 재제 Table
create table sanction(
sanctionnum number primary key	-- 재제 번호
, userid varchar2(20) not null		-- 재제 대상자
, starttime date default sysdate	-- 재제 시작일
, endtime date default sysdate + 6 	-- 재제 종료일
);

-- 재제 번호 Sequence
create sequence sanction_seq
increment by 1
start with 1;
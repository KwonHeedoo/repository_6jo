drop table message purge;
drop sequence message_seq;

-- 쪽지 Table
create table message(
messagenum number primary key       -- 쪽지 번호
, userid varchar2(20) not null      -- 보내는 이 ID
, nickname varchar2(50) not null    -- 보내는 이 닉네임
, receiveid varchar2(20) not null   -- 받는 이 ID
, message varchar2(1000) not null   -- 메세지 내용
, regdate date default sysdate      -- 보낸 날짜
, status number default 0 not null constraint msg_status_ck check(status in(0, 1))  -- 읽음 여부
);

--  쪽지 Sequence
create sequence message_seq
increment by 1
start with 1;
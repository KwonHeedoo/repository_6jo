drop table message purge;
drop sequence message_seq;

-- ���� Table
create table message(
messagenum number primary key       -- ���� ��ȣ
, userid varchar2(20) not null      -- ������ �� ID
, nickname varchar2(50) not null    -- ������ �� �г���
, receiveid varchar2(20) not null   -- �޴� �� ID
, message varchar2(1000) not null   -- �޼��� ����
, regdate date default sysdate      -- ���� ��¥
, status number default 0 not null constraint msg_status_ck check(status in(0, 1))  -- ���� ����
);

--  ���� Sequence
create sequence message_seq
increment by 1
start with 1;
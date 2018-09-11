drop table report purge;
drop sequence report_seq;
drop table sanction purge;
drop sequence sanction_seq;

-- �Ű� Table
create table report(
reportnum number primary key        -- �Ű� ��ȣ
, reporter varchar2(20) not null    -- �Ű���
, reportee varchar2(20) not null    -- �Ű� ���� �����
, report varchar2(2000) not null    -- �Ű� ����
, reason varchar2(2000) not null    -- �Ű� ����
, regdate date default sysdate      -- �Ű� ��¥
, reporturl varchar2(300) not null  -- �Ű�URL
, status number default 0 not null constraint report_status_ck check(status in(0, 1))	-- �Ű� ���� ����(�������� ���� ���� 0, �Ű� ������ ���� 1)
);

-- �Ű� ��ȣ Sequence
create sequence report_seq
increment by 1
start with 1;

-- ���� Table
create table sanction(
sanctionnum number primary key	-- ���� ��ȣ
, userid varchar2(20) not null		-- ���� �����
, starttime date default sysdate	-- ���� ������
, endtime date default sysdate + 6 	-- ���� ������
);

-- ���� ��ȣ Sequence
create sequence sanction_seq
increment by 1
start with 1;
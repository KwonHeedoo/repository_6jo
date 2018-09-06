drop table report purge;
drop sequence report_seq;
drop table sanction purge;

-- �Ű� Table
create table report(
reportnum number primary key        -- �Ű� ��ȣ
, reporter varchar2(20) not null    -- �Ű���
, reportee varchar2(20) not null    -- �Ű� ���� �����
, report varchar2(2000) not null    -- �Ű� ����
, reason varchar2(2000) not null    -- �Ű� ����
, regdate date default sysdate      -- �Ű� ��¥
, reporturl varchar2(300) not null  -- �Ű�URL
);

-- �Ű� ��ȣ Sequence
create sequence report_seq
increment by 1
start with 1;

-- ���� Table
create table sanction(
userid varchar2(20) primary key     -- ���� �����
, attention number default 0        -- ���
, starttime date default sysdate    -- ���� ������
, endtime date default sysdate + 6  -- ���� ������
);
drop table notice_board purge;
drop sequence notice_board_seq;

-- ����/���� �Խ��� Table
create table notice_board(
boardnum number primary key	        -- �Խù� ��ȣ
, userid varchar2(20) not null		-- �Խù� �ۼ���
, title varchar2(30) not null		-- ����
, contents varchar2(2000) not null	-- ����
, hitcount number default 0		    -- ��ȸ��
, regdate date default sysdate	    -- ���� ������
, status number default 1 not null constraint nb_status_ck check(status in(0, 1))	-- ���� ����
);

-- ����/���� �Խ��� Squence
create sequence notice_board_seq
increment by 1
start with 1;

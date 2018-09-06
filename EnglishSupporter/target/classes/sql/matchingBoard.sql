drop table matching_board purge;
drop sequence matching_board_seq;
drop table matching_comment purge;
drop sequence mc_commentnum_seq;
drop sequence mc_groupnum_seq;


-- 1:1 ȭ�� ä�� ��Ī �Խù� Table
create table matching_board(
boardnum number primary key	-- �Խù� ��ȣ
, userid varchar2(20) not null		-- �Խù� �ۼ���
, title varchar2(30) not null		-- ����
, contents varchar2(2000) not null	-- ����
, hitcount number default 0		-- ��ȸ��
, regdate date default sysdate	-- ���� ������
, status number default 0 not null constraint mb_status_ck check(status in(0, 1))	-- ���� ����(1�̸� ���� / 0�̸� �ϹݰԽù�)
, matchingid varchar2(20)		-- ��Ī ID
, appointedtime timestamp not null	-- ��Ī �ð�
, roomnum varchar2(20) unique	-- ä�÷� ��ȣ
);

-- 1:1 ȭ�� ä�� ��Ī �Խù� ��ȣ Sequence
create sequence matching_board_seq
increment by 1
start with 1;

-- 1:1 ȭ�� ä�� ��Ī �Խù� �ڸ�Ʈ Table 
create table matching_comment(
commentnum number primary key	-- �ڸ�Ʈ ��ȣ
, userid varchar2(20) not null 	-- �ڸ�Ʈ �ۼ���
, nickname varchar2(50) not null	-- �ڸ�Ʈ �ۼ��� �г���
, boardnum number not null	-- �ڸ�Ʈ�� �ִ� �Խù� ��ȣ
, comments varchar2(500) not null	-- �ڸ�Ʈ ����
, regdate date default sysdate	-- ���� ������
, parentid varchar2(20)		-- �θ� �ڸ�Ʈ�� �ۼ��� ID
, parentnick varchar2(50)		-- �θ� �ڸ�Ʈ�� �ۼ��� �г���
, groupnum number not null	-- �ڸ�Ʈ �׷� ��ȣ
, matchingid varchar2(20)		-- ��Ī ID
);

-- 1:1 ȭ�� ä�� ��Ī �Խù� �ڸ�Ʈ ��ȣ Sequence(commentNum)
create sequence mc_commentnum_seq
increment by 1
start with 1;

-- 1:1 ȭ�� ä�� ��Ī �Խù� �ڸ�Ʈ �׷� Sequence(groupNum)
create sequence mc_groupnum_seq
increment by 1
start with 1;


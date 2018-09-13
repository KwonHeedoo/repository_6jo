drop table appraise_board purge;
drop sequence appraise_board_seq;
drop table appraise_comment purge;
drop sequence ac_commentnum_seq;
drop sequence ac_groupnum_seq;


-- ���� �� �Խ��� Table
create table appraise_board(
boardnum number primary key	-- �Խù� ��ȣ
, userid varchar2(20) not null		-- �Խù� �ۼ���
, nickname varchar2(50) not null	-- �Խù� �ۼ��� �г���
, title varchar2(100) not null		-- ����
, contents varchar2(2000) not null	-- ����
, hitcount number default 0		-- ��ȸ��
, regdate date default sysdate	-- ���� ������
, status number default 1 not null constraint ab_status_ck check(status in(0, 1))	-- ���� ����
, datanum number not null   -- ���� ���� ���� ��ȣ
);

-- ���� �� �Խù� ��ȣ Sequence
create sequence appraise_board_seq
increment by 1
start with 1;

-- ���� �Խù� �ڸ�Ʈ Table 
create table appraise_comment(
commentnum number primary key	-- �ڸ�Ʈ ��ȣ
, userid varchar2(20) not null 	-- �ڸ�Ʈ �ۼ���
, nickname varchar2(50) not null	-- �ڸ�Ʈ �ۼ��� �г���
, boardnum number not null	-- �ڸ�Ʈ�� �ִ� �Խù� ��ȣ
, comments varchar2(500) not null	-- �ڸ�Ʈ ����
, regdate date default sysdate	-- ���� ������
, parentid varchar2(20)		-- �θ� �ڸ�Ʈ�� �ۼ��� ID
, parentnick varchar2(50)		-- �θ� �ڸ�Ʈ�� �ۼ��� �г���
, groupnum number not null	-- �ڸ�Ʈ �׷� ��ȣ
, pronunciation number default 0	-- ���� ����
, posture number default 0		-- �ڼ� ����
, contents number default 0		-- ���� ����
);

-- ���� �Խù� �ڸ�Ʈ ��ȣ Sequence(commentNum)
create sequence ac_commentnum_seq
increment by 1
start with 1;

-- ���� �Խù� �ڸ�Ʈ �׷� Sequence(groupNum)
create sequence ac_groupnum_seq
increment by 1
start with 1;
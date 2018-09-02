drop table notice_board purge;
drop sequence notice_board_seq;
drop table notice_comment purge;
drop sequence nc_commentnum_seq;
drop sequence nc_groupnum_seq;

-- 공지 게시판 Table
create table notice_board(
boardnum number primary key	-- 게시물 번호
, userid varchar2(20) not null		-- 게시물 작성자
, title varchar2(30) not null		-- 제목
, contents varchar2(2000) not null	-- 내용
, hitcount number default 0		-- 조회수
, regdate date default sysdate	-- 최종 수정일
, status number default 1 not null constraint nb_status_ck check(status in(0, 1))	-- 공지 여부
);

-- 공지 게시판 Squence
create sequence notice_board_seq
increment by 1
start with 1;

-- 공지 게시물 코멘트 Table 
create table notice_comment(
commentnum number primary key	-- 코멘트 번호
, userid varchar2(20) not null 	-- 코멘트 작성자
, nickname varchar2(50) not null	-- 코멘트 작성자 닉네임
, boardnum number not null	-- 코멘트가 있는 게시물 번호
, comments varchar2(500) not null	-- 코멘트 내용
, regdate date default sysdate	-- 최종 수정일
, parentid varchar2(20)		-- 부모 코멘트의 작성자 ID
, parentnick varchar2(50)		-- 부모 코멘트의 작성자 닉네임
, groupnum number not null	-- 코멘트 그룹 번호
);

-- 공지 게시물 코멘트 번호 Sequence(commentNum)
create sequence nc_commentnum_seq
increment by 1
start with 1;

-- 공지 게시물 코멘트 그룹 Sequence(groupNum)
create sequence nc_groupnum_seq
increment by 1
start with 1;

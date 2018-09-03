drop table matching_board purge;
drop sequence matching_board_seq;
drop table matching_comment purge;
drop sequence mc_commentnum_seq;
drop sequence mc_groupnum_seq;


-- 1:1 화상 채팅 매칭 게시물 Table
create table matching_board(
boardnum number primary key	-- 게시물 번호
, userid varchar2(20) not null		-- 게시물 작성자
, title varchar2(30) not null		-- 제목
, contents varchar2(2000) not null	-- 내용
, hitcount number default 0		-- 조회수
, regdate date default sysdate	-- 최종 수정일
, status number default 0 not null constraint mb_status_ck check(status in(0, 1))	-- 공지 여부(1이면 공지 / 0이면 일반게시물)
, matchingid varchar2(20)		-- 매칭 ID
);

-- 1:1 화상 채팅 매칭 게시물 번호 Sequence
create sequence matching_board_seq
increment by 1
start with 1;

-- 1:1 화상 채팅 매칭 게시물 코멘트 Table 
create table matching_comment(
commentnum number primary key	-- 코멘트 번호
, userid varchar2(20) not null 	-- 코멘트 작성자
, nickname varchar2(50) not null	-- 코멘트 작성자 닉네임
, boardnum number not null	-- 코멘트가 있는 게시물 번호
, comments varchar2(500) not null	-- 코멘트 내용
, regdate date default sysdate	-- 최종 수정일
, parentid varchar2(20)		-- 부모 코멘트의 작성자 ID
, parentnick varchar2(50)		-- 부모 코멘트의 작성자 닉네임
, groupnum number not null	-- 코멘트 그룹 번호
, matchingid varchar2(20)		-- 매칭 ID
);

-- 1:1 화상 채팅 매칭 게시물 코멘트 번호 Sequence(commentNum)
create sequence mc_commentnum_seq
increment by 1
start with 1;

-- 1:1 화상 채팅 매칭 게시물 코멘트 그룹 Sequence(groupNum)
create sequence mc_groupnum_seq
increment by 1
start with 1;


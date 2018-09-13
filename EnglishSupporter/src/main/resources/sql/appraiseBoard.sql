drop table appraise_board purge;
drop sequence appraise_board_seq;
drop table appraise_comment purge;
drop sequence ac_commentnum_seq;
drop sequence ac_groupnum_seq;


-- 영상 평가 게시판 Table
create table appraise_board(
boardnum number primary key	-- 게시물 번호
, userid varchar2(20) not null		-- 게시물 작성자
, nickname varchar2(50) not null	-- 게시물 작성자 닉네임
, title varchar2(100) not null		-- 제목
, contents varchar2(2000) not null	-- 내용
, hitcount number default 0		-- 조회수
, regdate date default sysdate	-- 최종 수정일
, status number default 1 not null constraint ab_status_ck check(status in(0, 1))	-- 공지 여부
, datanum number not null   -- 모의 면접 영상 번호
);

-- 영상 평가 게시물 번호 Sequence
create sequence appraise_board_seq
increment by 1
start with 1;

-- 공지 게시물 코멘트 Table 
create table appraise_comment(
commentnum number primary key	-- 코멘트 번호
, userid varchar2(20) not null 	-- 코멘트 작성자
, nickname varchar2(50) not null	-- 코멘트 작성자 닉네임
, boardnum number not null	-- 코멘트가 있는 게시물 번호
, comments varchar2(500) not null	-- 코멘트 내용
, regdate date default sysdate	-- 최종 수정일
, parentid varchar2(20)		-- 부모 코멘트의 작성자 ID
, parentnick varchar2(50)		-- 부모 코멘트의 작성자 닉네임
, groupnum number not null	-- 코멘트 그룹 번호
, pronunciation number default 0	-- 발음 점수
, posture number default 0		-- 자세 점수
, contents number default 0		-- 내용 점수
);

-- 공지 게시물 코멘트 번호 Sequence(commentNum)
create sequence ac_commentnum_seq
increment by 1
start with 1;

-- 공지 게시물 코멘트 그룹 Sequence(groupNum)
create sequence ac_groupnum_seq
increment by 1
start with 1;
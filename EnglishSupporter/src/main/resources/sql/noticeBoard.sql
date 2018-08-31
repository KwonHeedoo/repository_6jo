drop table notice_board purge;
drop sequence notice_board_seq;

-- 공지/건의 게시판 Table
create table notice_board(
boardnum number primary key	        -- 게시물 번호
, userid varchar2(20) not null		-- 게시물 작성자
, title varchar2(30) not null		-- 제목
, contents varchar2(2000) not null	-- 내용
, hitcount number default 0		    -- 조회수
, regdate date default sysdate	    -- 최종 수정일
, status number default 1 not null constraint nb_status_ck check(status in(0, 1))	-- 공지 여부
);

-- 공지/건의 게시판 Squence
create sequence notice_board_seq
increment by 1
start with 1;

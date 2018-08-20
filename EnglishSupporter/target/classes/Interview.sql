
--====== 인터뷰 데이터 저장 테이블 ========
create table interview_data
(
	dataNum		number 			primary key,
	userid		varchar2(20) 	not null,
	questionNum	number	 		not null,
	answer		varchar2(300) 	not null,
	regdate		date	 		not null,
	saveFile	varchar2(40)	not null
);
--====== 인터뷰 데이터 시퀀스 ========
create sequence data_seq;

--====== 인터뷰 질문 테이블 ========
create table interview_question
(
	questionnum	number			primary key,
	question	varchar(200)	not null
);

--====== 인터뷰 질문 시퀀스 ========
create sequence inter_question_seq;


--====== 인터뷰 질문 db ========
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'Please introduce yourself.');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What are your strengths?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What are your disadvantages?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'Why do you want this job?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What career do you want to build over the next five years?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'Where is the ideal company?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What do you like about this company?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'Why should I hire you?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What part of your job you did not like most recently?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What was the most satisfying thing in your job?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What else can you do for the company that other applicants can not do?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What was your responsibility in your previous job?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'Why do you want to quit your current job?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What do you know about this industry?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'What do you know about this company?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'Are you willing to relocate?');
insert into interview_question(questionnum, question) values(inter_question_seq.nextval,'Do you have any questions?');

commit;
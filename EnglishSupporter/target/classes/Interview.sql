create table interview_data
(
	dataNum		number 			primary key,
	userid		varchar2(20) 	not null,
	questionNum	number	 		not null,
	answer		varchar2(300) 	not null,
	regdate		date	 		not null,
	saveFile	varchar2(40)	not null

);

create sequence data_seq;
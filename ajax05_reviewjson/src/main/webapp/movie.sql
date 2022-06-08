drop table comments;
drop table movie;
create table movie
(
mnum number(5) primary key,
title varchar2(255),
content varchar2(4000),
director varchar2(50)
);
create table comments
(
num number(5) primary key, -- 댓글번호
mnum number(5) references movie(mnum), -- 영화번호
id varchar2(255),
comments varchar2(255)
);
create sequence movie_seq;
create sequence comments_seq;

insert into movie values(movie_seq.nextval,'닥터스트레인지2','멀티버스여행','감독1');
insert into movie values(movie_seq.nextval,'범죄도시2','진실의방으로','감독2');
commit;

insert into comments values(comments_seq.nextval,1,'admin','꿀잼!');
insert into comments values(comments_seq.nextval,1,'user','난해해요!');
insert into comments values(comments_seq.nextval,2,'viewer','통쾌한 액션!');
commit;
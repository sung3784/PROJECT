
create table customer(
customernumber number primary key,
name varchar2(20),
phone varchar2(30) not null,
address varchar2(1500) not null,
address2 varchar2(1500) not null,
id varchar2(50) unique,
password varchar2(50) not null
);

create sequence customerseq;

create table cleaner(
cleanernumber number primary key,
name varchar2(20) not null,
phone varchar2(30) not null,
id varchar2(50) unique,
password varchar2(50) not null,
address varchar2(150) not null,
address2 varchar2(150) not null
);

create sequence cleanerseq;
create sequence seqwc;

create table wantedcustomer(
seqwc number primary key,
customernumber number,
name varchar2(20) not null,
phone varchar2(30) not null,
address varchar2(1500) not null,
address2 varchar2(1500) not null,
wantedtime date not null,
specifictime number not null,
details varchar2(1500)

);
drop table cleaner;
drop table customer;
drop table wantedcustomer;
commit;

select * from customer;
select * from cleaner;
select * from wantedcustomer;
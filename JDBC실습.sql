-----------------------------------------
--JDBC실습용문서
-----------------------------------------

--Java에서 첫번째 JDBC프로그래밍 해보기
--클래스명 : HRSelected.java
--HR계정에서 실행
select * from employees where department_id = 50
order by employee_id desc;

--CRUD 작업을 위한 테이블 생성
--클래스명 : Myconnection.java
--study계정에서 실행
create table member (
    id varchar2(30),
    pass varchar2(40),
    name varchar2(50),
    regidate date default sysdate,
    primary key (id)
);
desc member;
select * from member;
select * from user_cons_columns;

--레코드 입력하기
insert into member values('test1', '1234', '태수터1', sysdate);
insert into member (id, pass, name) values
    ('test4', '1234', '태수터4');
commit;
--레코드 수정하기
update member set pass = '9876', name = '나수정'
where id = 'dddd';
commit;
--레코드 삭제하기
delete from member where id = 'test2';
commit;

--레코드 조회하기1
select 
    id, pass, name, regidate,
    to_char(regidate, 'yyy.mm.dd hh24:mi') d1
from member;
select * from member;
commit;

--레코드 조회하기2(검색)
select * from member where name like '%태수터%';














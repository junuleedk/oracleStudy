-----------------------------------------
--JDBC�ǽ��빮��
-----------------------------------------

--Java���� ù��° JDBC���α׷��� �غ���
--Ŭ������ : HRSelected.java
--HR�������� ����
select * from employees where department_id = 50
order by employee_id desc;

--CRUD �۾��� ���� ���̺� ����
--Ŭ������ : Myconnection.java
--study�������� ����
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

--���ڵ� �Է��ϱ�
insert into member values('test1', '1234', '�¼���1', sysdate);
insert into member (id, pass, name) values
    ('test4', '1234', '�¼���4');
commit;
--���ڵ� �����ϱ�
update member set pass = '9876', name = '������'
where id = 'dddd';
commit;
--���ڵ� �����ϱ�
delete from member where id = 'test2';
commit;

--���ڵ� ��ȸ�ϱ�1
select 
    id, pass, name, regidate,
    to_char(regidate, 'yyy.mm.dd hh24:mi') d1
from member;
select * from member;
commit;

--���ڵ� ��ȸ�ϱ�2(�˻�)
select * from member where name like '%�¼���%';














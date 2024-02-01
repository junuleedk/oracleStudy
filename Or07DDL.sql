/*********
���ϸ� : Or07DDL.sql
DDL : Data Definition Language(������ ���Ǿ�)
���� : ���̺�, ��� ���� ��ü�� ���� �� �����ϴ� �������� ���Ѵ�.
**********/
--system �������� ������ �� �Ʒ� ����� �����Ѵ�.
--���ο� ����� ������ ������ �� ���ӱ��� �� ���̺� ���������� �ο��Ѵ�. 

--Oracle12c �̻���ʹ� ���� ���� �� �ش� ����� �����ؾ� �Ѵ�.
--���� �������� �ʴ´ٸ� ������ �տ� C##�� �߰��ؾ��Ѵ�.
alter session set "_ORACLE_SCRIPT"=true;
--study������ �����ϰ� �н����带 1234�� �ο��Ѵ�.
create user study identified by 1234;
--������ ������ ��� ������ �ο��Ѵ�.
grant connect, resource to study;

--------------------------------------------------------------------------------
--study������ Developer�� ����� �� �����Ѵ�.
--DDL�� �ǽ��� study�������� �����մϴ�.

--��� ������ �����ϴ� ���� ���̺�, �Ÿ� �׽�Ʈ�� �ַ� ���ȴ�.
select * from dual;
/*�ش� ������ ������ ���̺��� ����� ������ �ý��� ���̺�� �̿Ͱ��� ������ ��������
������ ���̺��� "�����ͻ���"�̶�� ǥ���Ѵ�.*/
select * from tab;

/*
���̺� �����ϱ�
����]create table ���̺�� (
        �÷���1 �ڷ���,
        �÷���2 �ڷ���,
        ...
        primary key(�÷���) ���� �������� �߰�
    };    
*/  
create table tb_member (
    idx number(10),
    userid varchar2(30),
    passwd varchar2(50),
    username varchar2(30),
    mileage number(7,2)
);
--������ ������ ������ ���̺��� ����� Ȯ���Ѵ�.
select * from tab;
--���̺��� ����(��Ű��)Ȯ��, �÷���, �ڷ���, ũ�⸦ Ȯ���� �� �ִ�. 
desc tb_member;

/*
���� ������ ���̺� ���ο� �÷� �߰�����
    -> tb_member ���̺� email �÷��� �߰��Ͻÿ�
����] alter table ���̺�� add �߰����÷��� �ڷ���(ũ��) ��������;
*/
alter table tb_member add email varchar2(100);
desc tb_member;

/*
���� ������ ���̺��� �÷� ����(����)�ϱ�
    -> tb_member ���̺��� email �÷��� ����� 200���� Ȯ���Ͻÿ�
        ���� �̸��� ����Ǵ� username�� 60���� Ȯ���Ͻÿ�
����]alter table ���̺�� modify �������÷��� �ڷ���(ũ��);
*/
alter table tb_member modify email varchar2(200);
alter table tb_member modify username varchar2(60);
desc tb_member;

/*
���� ������ ���̺��� �÷� �����ϱ�
    -> tb_member ���̺��� mileage �÷��� �����Ͻÿ�.
����]alter table ���̺�� drop colum �������÷���;
*/

alter table tb_member drop column mileage;
desc tb_member;
/*
���̺� ���Ǽ��� �ۼ��� employees���̺��� �ش� study������ �״�� �����Ͻÿ�. �� ����
������ ������� �ʽ��ϴ�.
*/
create table employees (
    employee_id number(6),
    first_name varchar2(20),
    last_name varchar2(25),
    email varchar2(25),
    phone_number varchar2(20),
    hire_date date,
    job_id varchar2(10),
    salary number(8, 2),
    commission_pct number(2, 2),
    manager_id number(6),
    department_id number(4)
);
desc employees;

/*
���̺� �����ϱ�
    -> employees ���̺��� �� �̻� ������� �����Ƿ� �����Ͻÿ�.
����] drop table ������ ���̺��;    
*/
drop table employees;
desc employees;
select * from tab;

--���̺��� ����(drop)�ϸ� ������ (recyclebin)�� �ӽ� �����ȴ�.
--������ Ȯ���ϱ�
show recyclebin;
--������ ����
purge recyclebin;
--�����뿡 ������ ���̺� �����ϱ�. ���⼭�� employees�� �����Ѵ�.
flashback table employees to before drop;

/*
tb_member ���̺� ���ο� ���ڵ带 �����Ѵ�. (DML���� �н�����)
������ ���̺� �����̽��� ������ ������ �� ���� �����̴�.
*/
insert into tb_member values (1, 'tjoeun' ,'1234', '������', 'tj@baver.com');
/*
����Ŭ11g ������ ���ο� ������ ������ �� connect, resource ��(Role)�� �ο��ϸ� ���̺� ����
�� ���Ա��� ������. �� ���� �������ʹ� ���̺� �����̽� ���� ������ �߻��Ѵ�. ���� �Ʒ��� ����
���̺� �����̽��� ���� ���ѵ� �Բ� �ο��ؾ��Ѵ�.
*/
--�� �������� system ���������� �����ؾ��Ѵ�.
grant unlimited tablespace to study;

--���ڵ� ������ ���� study�������� ��ȯ �� �����ؾ��Ѵ�. 
insert into tb_member values (2, 'hong' ,'1234', 'ȫ�浿', 'hong@google.com');
insert into tb_member values (3, 'lee' ,'1234', '�̼���', 'lee@daum.net');
--���Ե� ���ڵ带 Ȯ���Ѵ�.
select * from tb_member;
--���� �����̹Ƿ� ��� ���ڵ带 ������� �����Ѵ�.
select * from tb_member where 1 = 1;
--������ �����̹Ƿ� ���ڵ带 �������� �ʴ´�.
select * from tb_member where 1 = 0;

--���̺���1 : ��Ű��(����)�� �����ϱ�
drop table tb_member_copy;
create table tb_member_copy
as
select * from tb_member where 1 = 0;
--���̺��� �״�� ����Ǿ����� Ȯ��
desc tb_member_copy;
--���̺��� ������ ����Ǿ����Ƿ� ���ڵ�� ������� �ʴ´�.
select * from tb_member_copy;

--���̺���2 : ��Ű��(����)�� ���ڵ���� ��� �����ϱ�
create table tb_member_clone
as
select * from tb_member where 1 = 1;
--���� �������� ���ڵ���� ���������Ƿ� ����ȴ�.
desc tb_member_clone;
select * from tb_member_clone;

/*
���̺� �����̽���?
    ��ũ ������ �Һ��ϴ� ���̺�� ��, �׸��� �� ���� �ٸ� �����ͺ��̽� ��ü���� ����Ǵ� ����̴�. 
    ���� ��� ����Ŭ�� ���ʷ� ��ġ�ϸ� hr������ �����͸� �����ϴ� user��� ���̺� �����̽��� �ڵ�����
    �����ȴ�.
*/
--���̺����̽��� ��ȸ�� �� �ִ� ������ ����
--desc ��Ű�� ���� ���� ���� ��ɾ�
desc dba_tablespaces;
--���� ����Ŭ �ý��ۿ��� �� 5���� ���̺� �����̽��� �����Ǿ��ִ�.
select tablespace_name, status, contents from dba_tablespaces;
--�츮�� ������ ����� ������ � ���̺����̽��� ����ϴ��� ��ȸ
select username, default_tablespace from dba_users
where username in upper('test_user2');
--����ڿ��� ���̺� �����̽��� �Ҵ��Ѵ�. (2m 2mb�� ���Ѵ�)
alter user test_user2 quota 2m on users;

/*
�� test_user2 ����ڰ� users��� ���̺����̽��� 2MB�� ������ ����� �� �ֵ��� ������
�ο��ϴ� ���̴�. CMD���� insert �غ��� ���������� �Էµȴ�. 
*/

    


























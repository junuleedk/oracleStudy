/**************************
���ϸ� : Qr10Subquery.sql
��������
���� : �������ȿ� �� �ٸ� �������� ���� ������ select��
***************************/

/*
������ ��������
    ����]
        select * from ���̺�� where �÷� = (
            select �÷� from ���̺�� where ����
        );
    �� ��ȣ���� ���������� �ݵ�� �ϳ��� ����� �����ؾ� �Ѵ�.
*/
    
/*
�ó�����] ������̺��� ��ü����� ��ձ޿����� ���� �޿��� �޴� ������� 
�����Ͽ� ����Ͻÿ�.
    ����׸� : �����ȣ, �̸�, �̸���, ����ó, �޿�
*/
/*�ó������� ���ƻ� �´� ������ó�� �������� 
�׷��Լ��� ���� �÷��� ������ �߸��� ������ �̹Ƿ� ������ �߻��Ѵ�..*/
select * from employees where salary < avg(salary);--����
--1.��ձ޿� ���ϱ� : 6462
select round(avg(salary)) from employees;
--2. �տ��� ���� ���� �������� ��� �޿����� ���� ������ �����Ѵ�.
select * from employees where salary < 6462;
--3. 1���� 2���� ���ļ� �ϳ��� �������������� �ۼ��� �� �ִ�. 
select * from employees where salary < (
    select round(avg(salary)) from employees
);

/*
�ó�����] ��ü ����� �޿��� �������� ����� �̸��� �޿��� ����ϴ� 
������������ �ۼ��Ͻÿ�.
����׸� : �̸�1, �̸�2, �̸���, �޿�
*/

--�ּұ޿��� Ȯ��
select min(salary) from employees;
--2100�� �޴� ������ Ȯ���Ѵ�.
select * from employees where salary = 2100;
--2���� �������� ���ļ� ���������� �����.
select * from employees where salary = (
    select min(salary) from employees
);
/*
�ó�����] ��ձ޿����� ���� �޿��� �޴� ������� ����� ��ȸ�Ҽ� �ִ� 
������������ �ۼ��Ͻÿ�.
��³��� : �̸�1, �̸�2, ��������, �޿�
�� ���������� jobs ���̺� �����Ƿ� join�ؾ� �Ѵ�. 
*/
--��ձ޿� ���
select avg(salary) from employees;
--���̺��� �����ؼ� ���ǿ� �´� ���ڵ� ����
select
    first_name, last_name, job_title, salary
from employees inner join jobs using(job_id)
where salary > 6461.83;
--2���� ���ļ� �������������� �ϼ�
select
    first_name, last_name, job_title, salary
from employees inner join jobs using(job_id)
where salary > (select avg(salary) from employees
);

/*
������ ��������
����] select * from  ���̺�� where �÷� in (
        select �÷� from ���̺�� where ����
     )
   �� ��ȣ ���� ���������� 2�� �̻��� ����� �����ؾ��Ѵ�. 
*/
/*
�ó�����] ���������� ���� ���� �޿��� �޴� ����� ����� ��ȸ�Ͻÿ�.
    ��¸�� : ������̵�, �̸�, ���������̵�, �޿�
*/
--���������� ���� ���� �޿��� Ȯ���Ѵ�. job_id�� �׷����� �����ش�.
select job_id, max(salary) 
from employees group by job_id;
/*
�տ��� ���� ����� �������� �ܼ��� or �������� ������ �ۼ��غ���. 
19���� ����� ����Ǿ����� �ʹ� �����Ƿ� 4�������� ����� Ȯ���غ���.
*/
select * from employees where
    (job_id = 'AD_PRES' and salary = 24000) or
    (job_id = 'AD_VP' and salary = 17000) or
    (job_id = 'IT_PROG' and salary = 9000) or
    (job_id = 'FI_MGR' and salary = 12008);
/*2���� ������ �ϳ��� �������������� �����ش�. 2���� �÷��� �̿��ؾ� �ϹǷ� 
��ȣ�� ���� �� ������ ������ 1:1�� ��Ī�����ش�. */
select * from employees where
    (job_id, salary) in (
    select job_id, max(salary) 
    from employees group by job_id
    );

/*
������ ������ : any
    ���������� �������� ���������� �˻������ �ϳ� �̻�
    ��ġ�ϸ� ���̵Ǵ� ������. �� �� �� �ϳ��� �����ϸ� �ش� ���ڵ带
    �����Ѵ�.
*/
/*
�ó�����] ��ü ����߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿���
    �޴� �������� �����ϴ� ������������ �ۼ��Ͻÿ�. �� ���� �ϳ���
    �����ϴ��� �����Ͻÿ�. 
*/
--20�� �μ��� �޿��� Ȯ���Ѵ�
select first_name, salary from employees where department_id = 20;
--����� �ܼ��� or���� �ۼ��Ѵ�.
select first_name, salary from employees 
    where salary > 13000 or salary > 6000;
/*�� �� �ϳ��� �����ϸ� �ǹǷ� ������ ������ any�� �̿��ؼ� ���������� �����ȴ�. 
�� 6000 Ȥ�� 13000���� ū �������� �������� ����ȴ�.*/
select first_name, salary from employees 
    where salary > any (
    select salary from employees where department_id = 20
    );

/*
�����࿬����3 : all
    ���� ������ �������� ���������� �˻������ ��� ��ġ�ؾ� ���ڵ带 �����Ѵ�.
*/
/*
�ó�����] ��ü ����߿��� �μ���ȣ�� 20�� ������� �޿��� �� ���� �޿���
    �޴� �������� �����ϴ� ������������ �ۼ��Ͻÿ�. �� �� �� �����ϴ� ���ڵ常
    �����Ͻÿ�. 
*/
select first_name, salary from employees 
    where salary > 13000 and salary > 6000;
    
select first_name, salary from employees 
    where salary > all (
    select salary from employees where department_id = 20
    );
/*
6000�̻��̰� ���ÿ� 13000���ٵ� Ŀ���ϹǷ�, ��������� 13000�̻��� ���ڵ常 �����ϰ� �ȴ�.
����� 5�� ����.
*/

/*
rownum : ���̺��� ���ڵ带 ��ȸ�� ������� ������ �ο��Ǵ� ������ 
    �÷��� ���Ѵ�. �ش� �÷��� ��� ���̺� �������� �����Ѵ�. 
*/
--��� ������ �������� �����ϴ� ���̺�
select * from dual;
/*���ڵ��� ���ľ��� ��� ���ڵ带 �����ͼ� rownum�� �ο��Ѵ�.
�� ��� rownum�� ������� ��µȴ�. (������ �� ������ ����Ŭ�� ���ϰ� �ǹǷ� �����ڴ� �� �� ����.)*/
select first_name, rownum from employees;
/*������ �̸��� �������� �������� ���� rownum�� �������� �̻��ϰ� ������ �ȴ�.*/
select first_name, rownum from employees order by first_name;
select first_name, rownum from employees order by first_name desc;
--�����ȣ�� �����ϸ� ������� ���´�.
select first_name, rownum from employees order by employee_id;

/*roumun�� �츮�� ������ ������� ��ο��ϱ� ���� ���������� ����Ѵ�. 
from������ ���̺��� ���;� ������. �Ʒ��� �������������� ������̺��� ��ü ���ڵ带 �������
�ϵ� �̸��� ������������ ���ĵ� ���·� ���ڵ带 �������� �ǹǷ� ���̺��� ��ü�� �� �ְ� �ȴ�. 
*/
select first_name, rownum from
    (select * from employees order by first_name);
/*
�̸��� �������� �������� ���ĵ� ���ڵ忡 rownum�� �ο��Ͽ����Ƿ� where���� �Ʒ��� ���� ������
���� ������ ���ؼ� select�� �� �ִ�. �񱳿����� ��� between���� ����ص� �ȴ�. 
*/
select * from
(select tb.*, rownum rNum from
    (select * from employees order by first_name) tb)
--where rNum >= 1and rNum <= 10;    
--where rNum >= 11 and rNum <=20;
where rNum >= 21 and rNum <=30;

--JSP �������� �Խ��� paging�� �ٽ� ���ƿ´�. --

--���� scott�������� �����մϴ�.

/*
01.�����ȣ�� 7782�� ����� ��� ������ ���� ����� ǥ��(����̸��� ��� ����)�Ͻÿ�.
*/
select * from emp;
select * from dept;
select ename, deptno, empno from emp where empno = 7782;--MANAGER
select dname, deptno from dept where deptno = 10;

select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp 
    inner join dept using(deptno) 
where job = (
    select job from emp where empno = 7782
);

/*
02.�����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ��(����̸��� ��� ����)�Ͻÿ�.
*/
select ename, sal from emp where empno = 7499;
select ename, sal from emp where sal > 1600;

select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp
    inner join dept using(deptno)
where sal > (select sal from emp where empno = 7499
);

/*
03.�ּ� �޿��� �޴� ����� �̸�, ��� ���� �� �޿��� ǥ���Ͻÿ�(�׷��Լ� ���).
*/
select min(sal) from emp;--800
select ename, sal from emp where sal = 800;

select empno, ename, job, sal from emp 
    inner join dept using(deptno)
where sal = (
    select min(sal) from emp
);

/*
04.��� �޿��� ���� ���� ����(job)�� ��� �޿��� ǥ���Ͻÿ�.
*/
select job, avg(sal) from emp group by job;
select min(avg(sal)) from emp group by job;

/*
05.���μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
*/

select deptno, min(sal) from emp group by deptno;

select ename, sal , deptno from emp where
    (deptno, sal) in (
    select deptno, min(sal) from emp group by deptno
);

/*
06.��� ������ �м���(ANALYST)�� ������� �޿��� �����鼭 
������ �м���(ANALYST)�� �ƴ� ������� ǥ��(�����ȣ, �̸�, ������, �޿�)�Ͻÿ�.
*/
select * from emp;
select * from emp where job ='ANALYST';

select empno, ename, job, sal from emp 
where sal < (
    select sal from emp where job = 'ANALYST'
);

/*
07.�̸��� K�� ���Ե� ����� ���� �μ����� ���ϴ� 
����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�
*/

select ename, deptno from emp where ename like '%K%';

select * from emp where deptno in (
    select deptno from emp where ename like '%K%'
);

/*
08.�μ� ��ġ�� DALLAS�� ����� �̸��� �μ���ȣ �� ��� ������ ǥ���Ͻÿ�.
*/

select * from dept;

select ename, deptno, job from emp
    inner join dept using(deptno)
where loc = 'DALLAS';

/*
09.��� �޿� ���� ���� �޿��� �ް� �̸��� K�� ���Ե� ����� ���� �μ����� 
�ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�.
*/
select deptno, avg(sal) from emp group by deptno;

select empno, ename, sal from emp 
where deptno in (
    select deptno from emp where ename like '%K%'
) 
and sal > (
        select avg(sal) from emp   
);

/*
10.��� ������ MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�.
*/

select * from emp where deptno in (
    select deptno from emp where job = 'MANAGER'
);
/*
11.BLAKE�� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��. BLAKE�� ����)
*/
select deptno from emp where ename = 'BLAKE';--30

select ename, hiredate from emp 
where deptno = (
    select deptno from emp where ename = 'BLAKE'
)
and ename != 'BLAKE';





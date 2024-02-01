/*************************
���ϸ� : Or14View.sql
View(��)
���� : View�� ���̺�κ��� ������ ������ ���̺�� ���������δ� �������� �ʰ� �������� �����ϴ� ���̺��̴�.
**************************/

--hr������ �ǽ��մϴ�.

/*
���� ����
����]create [or replace] view �����̸� [(�÷�1, �÷�2,...)]
    as
    select * from ���̺�� where ����
    Ȥ�� join�� �ִ� select��
    group by�� �߰��� select�� ��...
*/

/*
�ó�����] hr������ ������̺��� �������� ST_CLERK�� ����� ������
        ��ȸ�� �� �ִ� View�� �����Ͻÿ�.
        ����׸� : ������̵�, �̸�, �������̵�, �Ի���, �μ����̵�
*/

--1.�ó����� ���Ǵ�� select���� �����Ѵ�.

select
    employee_id, first_name, job_id, hire_date, department_id
from employees where job_id = 'ST_CLERK';

--2.�� �����ϱ�
create view view_employees
as
    select
        employee_id, first_name, job_id, hire_date, department_id
    from employees where job_id = 'ST_CLERK';
    
--3.�� �����ϱ�
select * from view_employees;
--4.������ �������� Ȯ���ϱ�(������ ����� �������� �״�� ����ȴ�)
select * from user_views;

/*
�� �����ϱ�
    : �� ���� ���忡 or replace�� �߰��ϸ� �ȴ�.
    �ش� �䰡 �����ϸ� �����ǰ�, ���� �������� ������ ���Ӱ� �����ȴ�.
    ���� ���ʷ� �並 ������ ������ ����ص� �����ϴ�.
*/

/*
�ó�����] �տ��� ������ �並 ������ ���� �����Ͻÿ�.
    ���� �÷��� employee_id, first_name, job_id, hire_date, department_id��
    id, fname, jobid, hdate, deptid �� �����Ͽ� �並 �����Ͻÿ�.
*/
create or replace view view_employees
    (id, fname, jobid, hdate, deptid)
as
    select
        employee_id, first_name, job_id, hire_date, department_id
    from employees where job_id = 'ST_CLERK';

select * from view_employees;
/*
������� �������̺��� �÷����� �����ؼ� ����ϰ� �ʹٸ� ���Ͱ��� ������ �÷����� ���̸� �ڿ�
�Ұ�ȣ�� ������ָ� �ȴ�. 
*/

/*
����] ������ ���̵� ST_MAN�� ����� �����ȣ, �̸�, �̸���, �Ŵ������̵�
    ��ȸ�� �� �ֵ��� �����Ͻÿ�.
    ���� �÷����� e_id, name, email, m_id�� �����Ѵ�. ��, �̸��� 
    first_name�� last_name�� ����� ���·� ����Ͻÿ�.
	��� : emp_st_man_view
*/
-----------------------------��ǰ------------------------------------
--������ ���Ǵ�� select�� �ۼ�
select
    employee_id, concat(first_name|| ' ', last_name, email, manager_id
from employees where job_id = 'ST_MAN';
--�� ������ �÷��� ���� ��Ī ����
create view emp_st_man_view
(e_id, name, email, m_id)
as
    select
        employee_id, concat(first_name|| ' ', last_name, email, manager_id
    from employees where job_id = 'ST_MAN';
-----------------------------����ǰ-----------------------------------
select
    employee_id, first_name, email, manager_id
from employees where job_id = 'ST_MAN';

create view emp_st_man_view
as
    select
        employee_id, first_name, email, manager_id
    from employees where job_id = 'ST_MAN';

select * from emp_st_man_view;

create or replace view emp_st_man_view
(e_id, name, email, m_id)
as
    select
        employee_id, first_name || ' ' || last_name, email, manager_id
    from employees where job_id = 'ST_MAN';
----------------------------------��ǰ----------------------------
--��Ȯ��
select * from emp_st_man_view;

/*
����] �����ȣ, �̸�, ������ ����Ͽ� ����ϴ� �並 �����Ͻÿ�.
�÷��� �̸��� emp_id, l_name, annual_sal�� �����Ͻÿ�.
�������� -> (�޿�+(�޿�*���ʽ���))*12
���̸� : v_emp_salary
��, ������ ���ڸ����� �ĸ��� ���ԵǾ�� �Ѵ�. 
*/
--select�� ����
/*������ ������� �߰��Ǿ� �������� �÷��� �߰��Ǵ� ��쿡�� �ݵ�� ��Ī���� �÷����� ����ؾ��Ѵ�.
�׷��� ������ ������ �߻��Ѵ�.*/
select
    employee_id, last_name,
    trim(to_char((salary + (salary * nvl(commission_pct, 0))) * 12, '9999,000'))
    /*�̷��� �������� ������� ���� ������ ��Ī�� �Բ� �������Ѵ�.(�������� �־����� �ʴ���)*/
from employees;
--��� ����
create or replace view v_emp_salary
(emp_id, l_name, annual_sal)
as
    select 
        employee_id, last_name, 
        trim(to_char((salary + (salary * nvl(commission_pct, 0))) * 12, '9999,000'))
    from employees;
------------------------------����ǰ-----------------------------------
select 
    employee_id, last_name, 
    trim(to_char((salary + (salary * nvl(commission_pct, 0))) * 12, '9999,000'))
from employees;

create or replace view v_emp_salary
(emp_id, l_name, annual_sal)
as
    select 
        employee_id, last_name, 
        trim(to_char((salary + (salary * nvl(commission_pct, 0))) * 12, '9999,000'))
    from employees;
    
select * from  v_emp_salary order by annual_sal;

/*
-������ ���� View ����
�ó�����] ������̺�� �μ����̺�, �������̺��� �����Ͽ� ���� ���ǿ� �´� 
�並 �����Ͻÿ�.
����׸� : �����ȣ, ��ü�̸�, �μ���ȣ, �μ���, �Ի�����, ������
���Ǹ�Ī : v_emp_join
�����÷� : empid, fullname, deptid, deptname, hdate, locname
�÷��� ������� : 
	fullname => first_name+last_name 
	hdate => 0000��00��00��
    locname => XXX���� YYY (ex : Texas���� Southlake)	
*/
--1.select���� �ۼ��Ѵ�.
select
    employee_id, first_name||' '||last_name, department_id, department_name,
    to_char(hire_date, 'yyyy"��"mm"��"dd"��"'), state_province||'�� ��' || city
from employees 
inner join departments using(department_id)
inner join locations using(location_id);
--2.View �����ϱ�
create or replace view v_emp_join (empid, fullname, deptid, deptname, hdate, locname)
as
    select
     employee_id, first_name||' '||last_name, department_id, department_name,
     to_char(hire_date, 'yyyy"��"mm"��"dd"��"'), state_province||'�� ��' || city
    from employees 
    inner join departments using(department_id)
    inner join locations using(location_id);
--3.������ �������� view�� ���� ������ ��ȸ�� �� �ִ�. 
select * from v_emp_join;




















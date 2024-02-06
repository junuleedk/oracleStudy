/*************
���ϸ� : Or16SubProgram.sql
�������α׷�
���� : �������ν���, �Լ� �׸��� ���Κ��� ������ Ʈ���Ÿ� �н�
***************/

/*
�������α׷�(Sub Program)
-PL/SQL������ ���ν����� �Լ���� �ΰ��� ������ �Ӽ������α׷��� �ִ�.
-select�� �����ؼ� �ٸ� DML���� �̿��Ͽ� ���α׷������� ��Ҹ� ���� ��밡���ϴ�.
-Ʈ���Ŵ� ���ν����� �������� Ư�� ���̺� ���ڵ��� ��ȭ�� ���� ��� �ڵ����� ����ȴ�.
-�Լ��� �������� �Ϻκ����� ����ϱ� ���� �����ȴ�. ��, �ܺ� ���α׷����� ȣ���ϴ� ���� ���� ����.
-���ν����� �ܺ� ���α׷����� ȣ���ϱ� ���� �����Ѵ�. 
 ���� Java, JSP��� ������ ȣ��� ������ ������ ������ �� �ִ�. 
*/

/*
1. �������ν���(Stored Procedure)
-���ν����� return���� ���� ��� out�Ķ���͸� ���� ���� ��ȯ�Ѵ�.
-���ȼ��� ���� �� �ְ�, ��Ʈ��ũ�� ���ϸ� ���� �� �ִ�.
����] create [or replace] procedure ���ν����� [(�Ű����� in �ڷ���, �Ű����� out �ڷ���)]
    is[��������]
    begin
        ���๮��
    end;
    /
���Ķ���� ������ �ڷ����� ����ϰ�, ũ��� ������� �ʴ´�.
*/

/*
����1] ����� �޿��� �����ͼ� ����ϴ� ���ν��� ����
�ó�����] 100�� ����� �޿��� select�Ͽ� ����ϴ� �������ν����� �����Ͻÿ�.
*/
--���ν��� ������ or replace�߰��ϴ� ���� ����. 


create or replace procedure pcd_emp_salary
is
    /*PL/SQL������ declare���� ������ ����������, ���ν��������� is���� �ش���
    ���� ������ �ʿ����ٸ� ������ �� �ִ� */
    --������̺��� �޿� �÷��� �����ϴ� ���������� ����
    v_salary employees.salary%type;
begin
    --100�� ����� �޿��� into�� ���� ������ �����Ѵ�.
    select salary into v_salary from employees
        where employee_id = 100;
    
    dbms_output.put_line('�����ȣ100�� �޿���: '||v_salary||'�Դϴ�');
end;
/
--�����ͻ������� Ȯ���Ѵ�. ������ �빮�ڷ� �ǹǷ� ��ȯ�Լ��� �̿���
select * from user_source where name like upper('%pcd_emp_salary%');
--���ν����� ������ ȣ��Ʈȯ�濡�� execute����� �̿��Ѵ�.
execute pcd_emp_salary;

/*
����2] IN�Ķ���� ����Ͽ� ���ν��� ����
�ó�����] ����� �̸��� �Ű������� �޾Ƽ� ������̺��� ���ڵ带 ��ȸ����
�ش����� �޿��� ����ϴ� ���ν����� ���� �� �����Ͻÿ�.
�ش� ������ in�Ķ���͸� ������ ó���Ѵ�.
����̸�(first_name) : Bruce, Neena
*/
--���ν��� ������ in�Ķ���͸� �����Ѵ�. first_name�� �����ϴ� ���������� �����Ѵ�.
create or replace procedure pcd_in_param_salary
    (param_name in employees.first_name%type)
is
    /*������ is������ �����ϰ�, �ʿ���� ��� ������ �� �ִ�. */
    valSalary number(10);
begin
    /*���Ķ���ͷ� ���޵� ������� �������� �޿��� ���� �� ������ �Ҵ��Ѵ�.
    �ϳ��� ����� ��µǹǷ� into�� select������ ����Ѵ�.*/
    select salary into valSalary
    from employees where first_name = param_name;
    --����� �̸��� �޿��� �Բ� ����Ѵ�.
    dbms_output.put_line(param_name||'�� �޿��� '|| valSalary ||' �Դϴ�');
end;
/
--������ �������� �ۼ��� ����Ȯ��
select * from user_source
    where name like upper('%pcd_in_param_salary%');
--����� �̸��� �Ķ���ͷ� �����ؼ� ���ν����� ȣ���Ѵ�.
execute pcd_in_param_salary('Bruce');
execute pcd_in_param_salary('Neena');

/*
����3] OUT�Ķ���� ����Ͽ� ���ν��� ����
�ó�����] �� ������ �����ϰ� ������� �Ű������� ���޹޾Ƽ� �޿��� ��ȸ�ϴ�
���ν����� �����Ͻÿ�. ��, �޿��� out�Ķ���͸� ����Ͽ� ��ȯ�� ����Ͻÿ�
*/
/*
�ΰ��� ������ �Ķ���͸� �����Ѵ�. �Ϲݺ���, ���������� ���� ����ؼ� �����Ͽ���.
�Ķ���ʹ� �뵵�� ���� in, out�� ���� ����Ѵ�. �Ķ���� ���ǽÿ��� ũ��� ������ ������� �ʴ´�.
*/
create or replace procedure pcd_out_param_salary
    (
        param_name in varchar2,
        param_salary out employees.salary%type
    )
is
    /*select�� ����� out�Ķ���Ϳ� ������ ���̹Ƿ� ������ ������ �ʿ����� �ʾ�
    is ���� ����д�. �̿Ͱ��� ���������� ������ �� �ִ�. */
begin
    /*in�Ķ���ʹ� whrere���� �������� ����ϰ�, select�� ������� into������ out�Ķ���Ϳ� �����Ѵ�.
    ����� ���� ���ν��� �ܺη� ��ȯ�ȴ�.*/
    select salary into param_salary
    from employees where first_name = param_name;
end;
/
--ȣ��Ʈ ȯ�濡�� ���ε� ������ �����Ѵ�. variable�ε� ������ �� �ִ�. 
var v_salary varchar2(30);
/*���ν��� ȣ��� ������ �Ķ���͸� ����Ѵ�. Ư�� ���ε庯���� :�� �ٿ����Ѵ�. out�Ķ������
pram_salary�� ����� ���� v_salary�� ���޵ȴ�.*/
execute pcd_out_param_salary('Matthew', :v_salary);
--���ν��� ���� �� out�Ķ���͸� ���� ���޵� ���� ����Ѵ�.
print v_salary;

/*
update ����� �ִ� ���ν��� ȣ���� ���� employees���̺��� ���ڵ���� ������ �� �н��� �����Ѵ�.
*/
create table zcopy_employees
as
select * from employees where 1 = 1;
/*select���� where�� �����ϰų� 1 = 1�� ������ �ָ� ���� �ǹǷ� ���
���ڵ带 �Բ� �����Ѵ�. ���� ��Ű��(����)�� �����ϰ� �ʹٸ� 1 = 0�� ����
������ ������ ����ϸ�ȴ�.
*/
desc zcopy_employees;
select * from zcopy_employees;
select employee_id, first_name, salary from zcopy_employees;

/* ������Ʈ ���� ����
100	Steven	    24000
101	Neena   	17000
102	Lex	        17000
103	Alexander	9000
104	Bruce	    6000
*/

/*
�ó�����] �����ȣ�� �޿��� �Ű������� ���޹޾� �ش����� �޿��� �����ϰ�, 
���� ������ ���� ������ ��ȯ�޾Ƽ� ����ϴ� ���ν����� �ۼ��Ͻÿ�.
*/

/*in�Ķ���ʹ� �����ȣ ������ �޿��� �Է¹޴´�. out�Ķ���ʹ� update�� �����
���� ������ ��ȯ�Ѵ�.*/
create or replace procedure pcd_update_salary (
    p_empid in number,
    p_salary in number,
    rCount out number
)
is--�߰����� ���� ������ �ʿ�����Ƿ� �����Ѵ�.
begin
    --���� ������Ʈ�� ó���ϴ� ���������� in�Ķ���͸� ���� ���� �����Ѵ�.
    update zcopy_employees
        set salary = p_salary
        where employee_id = p_empid;
    /*
    SQL%notfound : ���� ���� �� ����� ���� ���� ��� true�� ��ȯ�Ѵ�.
        found�� �ݴ��� ��츦 ��ȯ�Ѵ�.
    sql%rowcount : ���� ���� �� ���� ����� ���� ������ ��ȯ�Ѵ�.
    */    
    if SQL%notfound then
        dbms_output.put_line(p_empid||'��(��) ���� ����Ӵ�');
        rCount := 0; 
    else
        dbms_output.put_line(SQL%rowcount||'���� �ڷᰡ �����Ǿ�');
        
        --���� ����� ���� ������ out�Ķ���͸� ���� ��ȯ�Ѵ�.
        rCount := sql%rowcount;
    end if;
    /*���� ��ȭ�� �ִ� ������ ������ ��� �ݵ�� commit�� �ؾ� ����
    ���̺� ����Ǿ� Oracle �ܺο��� Ȯ���� �� �ִ�. */
    commit;
end;
/
--ù����ÿ��� �������� ���� �ݵ�� �����ؾ��Ѵ�.
set serveroutput on;

--���ε庯�� ���� �� ���ν����� ��ȯ��(out�Ķ����)�� ���� �� ����Ѵ�.
variable r_count number;
execute pcd_update_salary(100, 9999, :r_count);
print r_count; --1�� �����
--100�� ����� �޿��� Ȯ���Ѵ�.(��� : 9999�� �����)
select * from zcopy_employees where employee_id = 100;
--
variable r_count number;
execute pcd_update_salary(777, 7777, :r_count);
print r_count;--���� ����̹Ƿ� 0�� �����
--------------------------------------------------------------------------------
/*
2.�Լ�
-����ڰ� PL/SQL���� ����Ͽ� ����Ŭ���� �����ϴ� �����Լ��� ���� ����� ������ ���̴�.
-�Լ��� in�Ķ���͸� ����� �� �ְ�, �ݵ�� ��ȯ���� �ڷ����� ����ؾ��Ѵ�.
-���ν����� �������� ������� ���� �� ������, �Լ��� �ݵ�� �ϳ��� ���� ��ȯ�ؾ��Ѵ�.
-�Լ��� �������� �Ϻκ����� ���ȴ�.
�� �Ķ������ ��ȯŸ���� ����� �� ũ��� ������� �ʴ´�.
*/

/*
�ó�����] 2���� ������ ���޹޾Ƽ� �� ���������� ������ ���ؼ� ����� ��ȯ�ϴ� �Լ��� �����Ͻÿ�.
���࿹) 2, 7 -> 2+3+4+5+6+7 = ??
*/
--�Լ��� in�Ķ���͸� �����Ƿ� in�� �ַ� �����Ѵ�.
create or replace function calSumBetween (
    num1 in number,
    num2 number
)
return 
    --�Լ��� �ݵ�� ��ȯ���� �����Ƿ� ��ȯŸ���� ����ؾ��Ѵ�.(�ʼ�)
    number
is
    --��ȯ������ ����� ���� ����(���û����̹Ƿ� �ʿ���ٸ� ��������)
    sumNum number;
begin
    sumNum := 0;
    --for���������� ���ڻ����� ���� ����Ѵ�.
    for i in num1 .. num2 loop
        sumNum := sumNum + i;
    end loop;
    --������� ��ȯ�Ѵ�.
    return sumNum;
end;
/
--������1 : �������� �Ϻη� ����Ѵ�(�ַ� ����ϴ� ���)
select calSumBetween(1, 10) from dual;
--������2 : ���ε庯���� ���� ���������� �ַ� ���������� ����
var hapText varchar2(30);
execute :hapText := calSumBetween(1, 100);
print hapText;

--������ �������� Ȯ���ϱ�
select * from user_source where name = upper('calSumBetween');
/*
-------------------------------------------------------------------------------
��������] ----> ����ȵ�. Ȯ���ϱ�
����] �ֹι�ȣ�� ���޹޾Ƽ� ������ �Ǵ��ϴ� �Լ��� �����Ͻÿ�.
999999-1000000 -> '����' ��ȯ
999999-2000000 -> '����' ��ȯ
��, 2000�� ���� ����ڴ� 3�� ����, 4�� ������.
�Լ��� : findGender()
*/
--substr() �Լ��� ���� ������ �ش��ϴ� ���� �ϳ��� �߶󳽴�.
select substr('999999-1000000',8,1) from dual;
select substr('999999-2000000',8,1) from dual;

/*�� �Լ��� �ֹι�ȣ�� �������·� �޾Ƽ� ������ �Ǵ��Ѵ�.
�Լ��� in�Ķ���͸� ����� �� �����Ƿ� in�� ������ �� �ִ�.*/
create or replace function findGender(juminNum varchar2)
--������ �Ǵ��� �� '����' Ȥ�� '����'�� ��ȯ�ϹǷ� ��ȯŸ���� ���������� �����Ѵ�.
return varchar2
is
    --�ֹι�ȣ���� ������ �ش��ϴ� ���ڸ� �߶� ������ ����
    genderTxt varchar2(1);
    --���ϰ��� ������ ����
    returnVal varchar2(20);
begin
    --�ֹι�ȣ���� ������ �ش��ϴ� �κ��� �߶󳽴�.
    genderTxt := substr(juminNum,8,1);
    --�߶� ���ڸ� ���� ������ �Ǵ��Ѵ�.
     if genderTxt = '1' then
        returnVal := '����';
    elsif genderTxt = '2' then
        returnVal := '����';
    elsif genderTxt = '3' then
        returnVal := '����';
    elsif genderTxt = '4' then
        returnVal := '����';
    else
        returnVal := '�Էº���';
    end if;
    --�Լ��� �ݵ�� ��ȯ���� �־���Ѵ�.
    return returnVal;
end;
/
select findGender('999999-1000000') from dual; 
select findGender('999999-2000000') from dual;
select findGender('999999-3000000') from dual; 
select findGender('999999-4000000') from dual;
select findGender('999999-5000000') from dual; 
--------------------------------------------------------------------------------
/*
�ó�����] ������̸�(first_name)�� �Ű������� ���޹޾Ƽ� 
�μ���(department_name)�� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
�Լ��� : func_deptName
*/

--1�ܰ�(���������� �̿��� ������ �ۼ�)
select 
    first_name, last_name, department_id, department_name
from employees inner join departments using(department_id)
where first_name = 'Nancy';

--2�ܰ� : �Լ� �ۼ�
create or replace function func_deptName (
    param_name varchar2 /*����� �̸��� in�Ķ���ͷ� ����*/
)
return
    --�μ����� ��ȯ�ؾ� �ϹǷ� ���������� ��ȯŸ�� ����
    varchar2
is  
    /*��ȯ���� ������ ������ �μ����̺��� �μ��� �÷��� �����ϴ� ������
    ����*/
    return_deptname departments.department_name%type;
begin 
    /*�ռ� �ۼ��� Join���������� �μ��� ������ �� �ֵ��� ������ �� into������ ��ȯ�� 
    ������ �����Ѵ�.*/
    select
        department_name into return_deptname
    from employees inner join departments using(department_id)
    where first_name = param_name;
    --�μ����� ��ȯ�Ѵ�.
    return return_deptname;
end;
/
select func_deptname('Nancy') from dual;--Finance ��ȯ
select func_deptname('Diana') from dual;--IT ��ȯ
--------------------------------------------------------------------------------
/*
Ʈ����(Trigger)
    :�ڵ����� ����Ǵ� ���ν����� ���� ������ �Ұ����ϴ�.
    �ַ� ���̺� �Էµ� ���ڵ��� ��ȭ�� ���� �� �ڵ����� ����ȴ�.
*/
/*
Ʈ���� �ǽ��� ���� HR������ �Ӻμ� ���̺��� �Ʒ��� ���� 2�� �����Ѵ�.
Original���̺��� ���ڵ���� ��� �����ϰ�, backup���̺��� ��Ű���� �����Ѵ�.
*/
create table trigger_dept_original
as
select * from departments;
create table trigger_dept_backup
as
select * from departments where 1 = 0;
--���� �� ���ڵ� Ȯ���ϱ�
select * from trigger_dept_original;--27
select * from trigger_dept_backup;--0

/*
����1] trig_dept_backup
�ó�����] ���̺� ���ο� �����Ͱ� �ԷµǸ� �ش� �����͸� ������̺� �����ϴ�
Ʈ���Ÿ� �ۼ��غ���.
*/

create or replace trigger trig_dept_backup
    --Ÿ�̹� : after: �̺�Ʈ �߻� ���� �ĸ� ǥ���Ѵ�. 
    after
    --�̺�Ʈ : insert, update, delete�� ���� ���� ����� �߻��ȴ�.
    INSERT
    --Ʈ���Ÿ� ������ ���̺��
    on trigger_dept_original
    /*����� Ʈ���Ÿ� �����Ѵ�. �� �ϳ��� ���� ��ȭ�� ������ Ʈ���Ű� ����ȴ�. 
    ���� ����(���̺�)���� Ʈ���ŷ� �����ϰ� �ʹٸ�, �ش� ������ �����ϸ� �ȴ�. �� ��쿡��
    ������ �ѹ� �����ϸ� Ʈ���ŵ� �� �ѹ��� ����ȴ�.*/
    for each row
begin
    if Inserting then
        dbms_output.put_line('insert Ʈ���� �߻���');
        /*���ο� ���ڵ尡 �ԷµǾ����Ƿ� �ӽ����̺� : new�� ����ǰ� �ش緹�ڵ带 ����
        backup���̺� �Է��� �� �ִ�. �̿� ���� �ӽ����̺��� ����� Ʈ���ſ����� ����� �� �ִ�.*/
        insert into trigger_dept_backup
        values (
            :new.department_id,
            :new.department_name,
            :new.manager_id,
            :new.location_id
        );
   end if;
end;
/
--original���̺� 3���� ���ڵ� ����
insert into trigger_dept_original values (101, '������', 10, 100);
insert into trigger_dept_original values (201, '������', 20, 200);
insert into trigger_dept_original values (301, '������', 30, 300);
--�� ���̺��� ���ڵ� Ȯ��
select * from trigger_dept_original;--30
--order by department_id desc;--30
select * from trigger_dept_backup;--3

/*
����2] trig_dept_delete
�ó�����] �������̺��� ���ڵ尡 �����Ǹ� ������̺��� ���ڵ嵵 ����
�����Ǵ� Ʈ���Ÿ� �ۼ��غ���.
*/ 
create or replace trigger trig_dept_delete
    /*original ���̺��� ���ڵ尡 ������ �� ������� Ʈ���Ÿ� �����Ѵ�.*/
    after
    delete
    on trigger_dept_original
    for each row
begin
     dbms_output.put_line('delete Ʈ���� �߻���');
     /*���ڵ尡 ������ ���� �̺�Ʈ�� �߻��Ǿ� Ʈ���Ű� ȣ��ǹǷ� 
     :old �ӽ����̺��� ����Ѵ�.*/
     if deleting then
        delete from trigger_dept_backup
            where department_id = :old.department_id;
     end if;
end;
/
--301�� �μ� ����
delete from trigger_dept_original where department_id=301;
--�� ���̺��� �Բ� ������ ���� Ȯ���� �� �ִ�. 
select * from trigger_dept_original;
select * from trigger_dept_backup;


/*
For each row �ɼǿ� ���� Ʈ���� ����Ƚ�� �׽�Ʈ
����1
    : �������� ���̺� ������Ʈ ���� ������� �߻��Ǵ� Ʈ���� ����
*/

/*
����3] trigger_update_test - ����1
*/
create or replace trigger trigger_update_test
    after update on trigger_dept_original
    for each row
begin
    /*������Ʈ �̺�Ʈ�� �����Ǹ� backup���̺��� ���ڵ带 �Է��Ѵ�.*/
    if updating then
        dbms_output.put_line('update Ʈ���� �߻���');
        /*������ �����Ͱ� ������Ʈ �� ���� :old�� ��������Ƿ�
        ���� �����Ͱ� ��� ���̺� �Էµȴ�.*/
        insert into trigger_dept_backup
        values (
            :old.department_id,
            :old.department_name,
            :old.manager_id,
            :old.location_id
        );
    end if;
end;
/
--5���� ���ڵ带 ������ �� �ִ� ������ �����.
select * from trigger_dept_original
    where department_id between 10 and 50;
--�� ������ �״�� �����Ͽ� update�Ѵ�(5���� ���ڵ尡 ������Ʈ�ȴ�)
update trigger_dept_original set department_name = '�μ��ϰ�����'
    where department_id between 10 and 50;
--�������̺��� 5���� ���ڵ尡 ������Ʈ�� ���� Ȯ���Ѵ�
select * from trigger_dept_original;
--������̺��� ������Ʈ �Ǳ� ���� �����Ͱ� 5�� �Էµȴ�.
select * from trigger_dept_backup;
/*
    ��, ����� Ʈ���ſ����� ����� ���� ������ŭ Ʈ���Ű� ����ȴ�.
*/

/*
����2 : �������� ���̺� ������Ʈ ���� ���̺�(����) ������ �߻��ϴ� Ʈ���Ż���
*/
create or replace trigger trigger_update_test
    after update on trigger_dept_original
    /*original ���̺��� ���ڵ带 ������Ʈ �� �� ���̺� ������ 
    Ʈ���Ű� ����ǹǷ� ������ �� ���� Ʈ���Ű� ����ȴ�. �� ���̺� ������
    Ʈ���Ÿ� ����� �ʹٸ� �Ʒ� �ɼ��� �����ϸ� �ȴ�.*/
    /*for each row*/
begin
    if updating then
        dbms_output.put_line('update Ʈ���� �߻���');
        insert into trigger_dept_backup
        values (
        /*���̺� ���� Ʈ���ſ����� :new, Ȥ�� :old�� ���� �ӽ����̺��� 
        ����� �� ����. ���� �Ʒ��� ���� ������ ���� �Է��ؾ��Ѵ�.*/
          999, to_char(sysdate, 'yy-mm-dd hh24:mi:ss'), 10, 100
        );
    end if;
end;
/

update trigger_dept_original set department_name = '�μ�����2'
    where department_id between 60 and 100;
--�������̺��� 5���� ���ڵ尡 ������Ʈ�� ���� Ȯ���Ѵ�
select * from trigger_dept_original;
--������̺��� �� 1���� ���ڵ常 �Էµȴ�.
select * from trigger_dept_backup;
/*
    ��, ���̺� ���� Ʈ���ſ����� ����� ���� ������ ������� 
    Ʈ���Ŵ� �ѹ��� ����ȴ�.
*/

























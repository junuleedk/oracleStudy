/**************
���ϸ� : Or02String.sql
���ڿ� ó���Լ�
���� : ���ڿ��� ���� ��ҹ��ڸ� ��ȯ�ϰų� ���ڿ��� ���̸� ��ȯ�ϴ� ��
    ���ڿ��� �����ϴ� �Լ�
**************/

/*
concat(���ڿ�1,���ڿ�2)
: ���ڿ� 1�� 2�� ���� �����ؼ� ����ϴ� �Լ�. ���ڿ� �κ��� �÷����� ����� �� �ִ�.
���1 : concat(���ڿ�1, ���ڿ�2)
���2 : ���ڿ� || ���ڿ�2
*/
select concat('Good ', 'morning') as "��ħ�λ�" from dual;
select 'Good ' || 'morning' from dual;

select 'Oracle ' || '21c ' || 'Good..!!' from dual;
-- => ��sql���� concat()���� �����غ���. (���������� ���� �����ϴ�)
select concat(concat('Oracle ', '21c '),'Good..!!')
from dual;

/*
�ó�����] ������̺��� ����� �̸��� �����ؼ� �Ʒ��� ���� ����Ͻÿ�
    ��³��� : first+last name, �޿�, �μ���ȣ 
*/
--step1 : �̸��� ���������� ���Ⱑ �ȵǼ� �������� ������
select
    concat(first_name, last_name), salary, department_id
from employees;

/*
step2 : �̸� ���̿� �����̸� �ϳ� �߰��Ѵ�. concat() ���ٴ� �������� ���ϴ�.
���� �÷����� as�� �̿��ؼ� ��Ī�� �ο��Ѵ�.
*/
select
    first_name || ' ' || last_name as full_name,
    salary, department_id
from employees;

/*
initcap(���ڿ�) : ���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�.
lower() : �ҹ��ڷ� ��������.
upper() : �빮�ڷ� ��������.
*/
select initcap('good'), lower('MORning'), upper('sIR') from dual;
/*
�ó�����] ��� ���̺��� first_name�� john�� ����� ã�� ����Ͻÿ�.
*/
--�̿Ͱ��� �����ϸ� ����� ������� �ʴ´�. (�����ʹ� ��ҹ��ڸ� �����Ѵ�)
select * from employees where first_name = 'john';
--�Է°��� ù���ڸ� �빮�ڷ� ������ �� �����Ѵ�.
select * from employees where first_name = initcap('john');
--���ڵ� ��ü�� �ҹ��ڷ� ������ �� �����Ѵ�.
select * from employees where lower(first_name) = 'john';
--���ڵ�� �Է°� ��ü�� �빮�ڷ� ������ �� �����Ѵ�.
select * from employees where upper(first_name) = upper('john');

/*
lpad(), rpad()
:���ڿ��� ����, �������� Ư���� ��ȣ�� ä�� �� ����Ѵ�.
����] lpad('���ڿ�', '��ü�ڸ���', 'ä�﹮�ڿ�')
    => ��ü�ڸ������� ���ڿ��� ���̸�ŭ�� ������ ������ ��(��)�� �κ��� �־��� ���ڷ� ä���ִ� �Լ�
*/
--3��° ���ڰ� ������ ���ڸ��� ����(�����̽�)�� ä��Եȴ�. 
select
    'good', lpad('good', 7, '#'), rpad('good', 7, '#'), lpad('good', 7)
from dual;

--����� �̸��� 10�ڸ��� �����Ͽ� ������ �κ��� *�� ä���.
select rpad(first_name, 10, '*') from employees;

/*
trim() : ������ ������ �� ����Ѵ�.
����] trim([leading | trailing | both] ������ ���� from �÷�)
    -leading : ����
    -trailing : ����
    -both : ���ʿ��� ������(default��)
    [����1] ���ʳ��� ���ڸ� �����ϰ�, �߰��� ���ڴ� ���ŵ��� ����
    [����2] '����'�� ������ �� �ְ�, '���ڿ�'�� ������ �� ����.
        ���ڿ��� �����ϴ� ��� ������ �߻��Ѵ�.
*/

select
    ' ���������׽�Ʈ ',
        trim(' ���������׽�Ʈ ') as trim1, /*������ ���� ����*/
        trim('��' from '�ٶ��㰡 ������ ž�ϴ�') trim2, /*������ '��' ����*/
        trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�') trim3,/*both�� ����Ʈ���̹Ƿ� trim2�� ��� ����*/
        trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�') trim4,/*������ ���� ����*/
        trim(trailing '��' from '�ٶ��㰡 ������ ž�ϴ�') trim5,/*������ ���� ����*/
        trim('��' from '�ٶ��㰡 �ٸ����� ������ ž�ϴ�') trim6/*�߰��� ���ڴ� ������ �� ����. */
from dual;
--trim()�� ���ڿ��� ������ �� ���� ������ �߻��Ѵ�.
select
    trim('�ٶ���' from '�ٶ��㰡 �ٸ����� ������ ž�ϴ�') trimError 
from dual;

/*
ltrim(), rtrim()
:����, ������ '����' Ȥ�� '���ڿ�'�� ������ �� ����Ѵ�.
*/
select
    /*������ ���鸸 ���ŵȴ�.*/
    ltrim(' ������������ ') ltrim1,
    /*������ ������ ���ԵǾ� �־� ���ڿ��� �������� �ʴ´�.*/
    ltrim(' ������������ ', '����') ltrim2,
    /*�� ��� �Լ��� ��ø����� ���� ���ϴ� ����� ������ �� �ִ�.*/
    ltrim(trim(' ������������ '), '����') ltrim3,
    /*���ڿ��� �߰� �κ��� ������ �� ����. */
    rtrim(trim(' ������������ '), '����') ltrim4

    
from dual;

/*
substr() : ���ڿ����� �����ε������� ���̸�ŭ �߶� ���ڿ��� ����Ѵ�.
    ����] substr(�÷�, �����ε���, ����)
    
    ����1) ����Ŭ�� �ε����� 1���� �����Ѵ�.(0���� �ƴ�)
    ����2) '����'�� �ش��ϴ� ���ڰ� ������ ���ڿ��� �������� �ǹ��Ѵ�.
    ����3) �����ε����� ������ ���������� �·� �ε����� �����Ѵ�.
*/
select substr('good morning john', 8, 4) from dual;--rning
select substr('good morning john', 8) from dual;--r���� ������ ���
--���ڿ��� ���̸� ��ȯ�Ѵ�.
select length('good morning') from dual;

/*
�ó�����]������̺��� first_name�� ù���ڸ� ������ ������ �κ��� *�� ����ŷ ó���ϴ� �������� �ۼ��Ͻÿ�
*/
--�̸��� ù���ڸ� ����ϱ�(�ε��� 1���� 1���ڸ� �߶󳽴�)
select first_name, substr(first_name, 1, 1) from employees;
--�̸��� 10���ڷ� �����Ͽ� ������ ������ *�� ä������
select rpad(first_name, 10, '*')from employees;
--�̸��� ù���ڸ� ��������, �̸��� ����(length)�� ���´�. 
--�̸� ���� *�� ����ϸ� �Ʊ��ڸ� ������ ���� ���̸�ŭ ����ŷó���� �� �ִ�.
select first_name,
    rpad(substr(first_name, 1, 2), length(first_name), '*')"����ŷ"
from employees;
/*
replace() : ���ڿ��� �ٸ� ���ڿ��� ��ü�� �� ����Ѵ�. ���� �������� ���ڿ��� ��ü�Ѵٸ� ���ڿ���
�����Ǵ� ����� �ȴ�.
    ����]replace(�÷��� or ���ڿ�, '������ ����� ����', '������ ����')
    
    ��trim(), ltrim(), rtrim()�� ����� replace() �ϳ��� ��ü�� �� �����Ƿ� trim()�� ����
    replace()�� �ξ� �� ���󵵰� ����.
*/
--���ڿ��� �����Ѵ�.
select replace('good morning john', 'morning', 'evening') from dual;
--���ڿ��� �����Ѵ�.
select replace('good morning john', 'john', '') from dual;
--trim()�� ���� ������ �����Ѵ�. �� ���ڿ� �߰��� ���鵵 ���ŵȴ�. 
select replace('good morning john', ' ', '') from dual;
/*
instr() : ���ڿ����� Ư�����ڰ� ��ġ�� �ε������� ��ȯ�Ѵ�.
    ����1]instr(�÷���, 'ã������')
        : ���ڿ��� ó������ ���ڸ� ã�´�.
    ����2]instr(�÷���, 'ã������', 'Ž���� ������ �ε���', '���° ����')
        : Ž���� �ε������� ���ڸ� ã�´�. ��, ã�� ������ ���°�� �ִ� �������� ������ �� �ִ�.
        ��Ž���� ������ �ε����� ������ ��� �������� �������� ã�Եȴ�.
*/
--n�� �߰ߵ� ù��° �ε��� ��ȯ
select instr('good morning john', 'n') from dual;
--�ε��� 1���� Ž���� �����ؼ� n�� ������ �ι�° �ε��� ��ȯ
select instr('good morning john', 'n', 1, 2) from dual;
--�ε��� 10���� Ž���� �����ؼ� n�� ������ �ι�° �ε��� ��ȯ
select instr('good morning john', 'n', 10, 2) from dual;


























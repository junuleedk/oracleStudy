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
--------------------------------------------------------------------------------
--JDBC > CallableStatement �������̽� ����ϱ�
--study�������� �н��մϴ�.
/*
����1-1] �Լ� : fillAsterik()
�ó�����]�Ű������� ȸ�����̵�(���ڿ�)�� ������ ù���ڸ� ������ 
������ �κ��� *�� ��ȯ�ϴ� �Լ��� �����Ͻÿ�
���࿹) oracle21c -> o********
*/
--substr(���ڿ� Ȥ�� �÷���, �����ε���, ����) : �����ε������� ���̸�ŭ �߶󳽴�.
select substr('hongildong', 1, 1) from dual;
--rpad(���ڿ� Ȥ�� �÷���, ��ü����, ä�﹮��) : ���ڿ��� ���� ���̸� ������ ���ڷ� ä���ش�.
select rpad('h', 10, '*')from dual;
--���ڿ��� ù���ڸ� ������ ������ �κ��� *�� ä�� �������� �ϼ��Ѵ�.
select rpad(substr('hongildong', 1, 1), length('hongildong'), '*')
    from dual;

--�Ű������� ���������� ����
create or replace function fillAsterik (
    idStr varchar2
)
--��ȯŸ�Ե� ���������� ����
return varchar2
--����ŷ ó���� ���̵� ������ ����
is retStr varchar2(50);
begin
    --���̵� ����ŷ ó�� �� ��ȯ
    retStr := rpad(substr(idStr,1 , 1), length(idStr), '*');
    return retStr;
end;
/
--���̵� ����ŷ ó���Ǵ��� Ȯ��
select fillAsterik('hongildong') from dual;
select fillAsterik('oracle21c') from dual;
select fillAsterik('hello') from dual;

/*
����2-1] ���ν��� : MyMemberInsert()
�ó�����] member ���̺� ���ο� ȸ�������� �Է��ϴ� ���ν����� �����Ͻÿ�
    �Ķ���� : In => ���̵�, �н�����, �̸�
                    Out => returnVal(����:1, ����:0)
*/
/*Java���� �Է��� ������ ���� ���Ķ���� ���� �� ���� ���� ���θ� ��ȯ�ϱ� ���� 
�ƿ��Ķ���� ����*/
create or replace procedure MyMemberInsert(
    p_id in varchar2,
    p_pass in varchar2,
    p_name in varchar2,
    returnVal out number
)
is
begin
    --���Ķ���͸� ���� insert�������� �ۼ�
    insert into member (id, pass, name)
        values(p_id, p_pass, p_name);
    
    if sql%found then
        --�Է��� ����ó�� �Ǿ��ٸ� �Էµ� ���� ������ ���´�.
        returnVal := sql%rowcount;
        --���� ��ȭ�� �������Ƿ� �ݵ�� Ŀ���ؾ��Ѵ�.
        commit;
    else
        --�Է¿� �����ϸ� 0�� ��ȯ�Ѵ�.
        returnVal := 0;
    end if;
    /*���ν����� ������ return���� �ƿ��Ķ���Ϳ� ���� �Ҵ��ϱ⸸ �ϸ� �ڵ����� ��ȯ�ȴ�.*/
end;
/
--���ε� ������ ������ �� ���ν����� �����Ѵ�.
var i_result varchar2(10);
execute MyMemberInsert('pro02', '1234', '���ν���1', :i_result);
execute MyMemberInsert('pro03', '5678', '���ν���2', :i_result);

--�ƿ��Ķ���͸� ���� ��ȯ���� �� �������� Ȯ���Ѵ�.
print i_result;

select * from member;

/*
����3-1] ���ν��� : MyMemberDelete()
�ó�����] member���̺��� ���ڵ带 �����ϴ� ���ν����� �����Ͻÿ�
    �Ķ���� : In => member_id(���̵�)
                    Out => returnVal(SUCCESS/FAIL ��ȯ)   
*/
--in�Ķ���ʹ� ������ ���̵�, out�Ķ���ʹ� ���� ����� ����
create or replace procedure MyMemberDelete (
    member_id in varchar2,
    returnVal out varchar2
)
is
begin
    --ȸ�����ڵ带 ���� �� delete������ �ۼ�
    delete from member where id = member_id;
    
    --������ ���� Ȥ�� ���и� �Ǵ��� �� ����� ��ȯ
    if SQL%Found then
        returnVal := 'SUCCESS';
        commit;
    else
        returnVal := 'FAIL';
    end if;
end;
/
--���ε� ���� ���� �� ���� �׽�Ʈ
var delete_var varchar2(10);
execute MymemberDelete('test2', :delete_var);
print delete_var;
execute MymemberDelete('pro01', :delete_var);
print delete_var;

/*
����4-1] ���ν��� : MyMemberAuth()
�ó�����] ���̵�� �н����带 �Ű������� ���޹޾Ƽ� ȸ������ ���θ� �Ǵ��ϴ� ���ν����� �ۼ��Ͻÿ�. 
    �Ű����� : 
        In -> user_id, user_pass
        Out -> returnVal
    ��ȯ�� : 
        0 -> ȸ����������(�Ѵ�Ʋ��)
        1 -> ���̵�� ��ġ�ϳ� �н����尡 Ʋ�����
        2 -> ���̵�/�н����� ��� ��ġ�Ͽ� ȸ������ ����
    ���ν����� : MyMemberAuth
*/

create or replace procedure MyMemberAuth (
    /*in�Ķ���� : Java���� �Է¹��� ���̵�, �н�����*/
    user_id in varchar2,
    user_pass in varchar2,
    /*out�Ķ���� : ȸ������ ���� ���*/
    returnVal out number
)
is  
    --count(*)�� ���� ��ȯ�Ǵ� ���� ����
    member_count number(1) := 0;
    --��ȸ�� �н����带 ����
    member_pw varchar2(50);
begin
    --�ش� ���̵� �����ϴ��� �Ǵ��ϴ� select�� �ۼ�
    select count(*) into member_count
    from member where id = user_id;
    --ȸ�����̵� �����Ѵٸ�..
    if member_count = 1 then
        --�н����� Ȯ���� ���� �ι�° �������� ����
        select pass into member_pw
            from member where id = user_id;
        --���Ķ���ͷ� ���޵� ���� DB�� �н����带 ���Ѵ�.    
        if member_pw = user_pass then
            --��� ��ġ�ϴ� ���
            returnVal := 2;
        else
            --����� Ʋ�� ���
            returnVal := 1;
        end if;
    else
        --���̵� Ʋ�� ���
        returnVal := 0;
    end if;
end;
/
--���ε� ���� ���� �� �׽�Ʈ�غ���.
variable member_auth number;

select * from member;
--�Ѵ� �´� ��� :2
execute MyMemberAuth('test4', '1234', :member_auth);
print member_auth;
--����� Ʋ�� ���:1
execute MyMemberAuth('test4', '1234��ȣƲ��', :member_auth);
print member_auth;
--���̵� Ʋ�� ���:0
execute MyMemberAuth('test4���̵�Ʋ��', '1234', :member_auth);
print member_auth;


    

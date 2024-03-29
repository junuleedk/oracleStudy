/*******
파일명 : Or15PLSQL.sql
PL/SQL
설명 : 오라클에서 제공하는 프로그래밍 언어
***************/

/*
PL/SQL(Procedural Language)
    :일반 프로그래밍 언어에서 가지고 있는 요소를 모두 가지고 있으며 DB업무를 처리하기 위해
    최적화된 언어이다
*/
--HR계정에서 실습합니다.

--예제1]PL/SQL 맛보기
--화면상에 내용을 출력하고 싶을 때 on으로 설정한다.
--off일때는 출력되지 않는다.
set serveroutput on;
declare--선언부 : 주로 변수를 선언한다.
    cnt number; -- 숫자타입으로 변수를 선언한다.
begin--실행부 : begin~end절 사이에 실행을 위한 로직
    cnt := 10;--변수에 10을 대입한다. 대입연산자는 :=를 사용한다.
    cnt := cnt + 1;
    dbms_output.put_line(cnt);----java의 Println
end;
/
/*
PL/SQL문장의 끝에는 반드시 / 를 붙여야하는데 만약 없으면 호스트환경으로 빠져나오지 못한다.
즉, PL/SQL문을 탈출하기 휘해 필요하다.
호스트 환경이랑 쿼리문을 입력하기 위한 SQL>프롬프트가 있는 상태를 말한다.
*/

--예제2] 일반변수 및 into
/*
시나리오] 사원테이블에서 사원번호가 120인 사원의 이름과 연락처를 출력하는 
PL/SQL문을 작성하시오.
*/
select * from employees where employee_id = 120;
--시나리오 조건에 맞는 select문을 작성한다.
select concat(first_name||' ', last_name), phone_number
from employees where employee_id = 120;

declare
    /*선언부에서 변수를 선언할 때는 테이블 생성시와 동일하게 선언한다.
    => 변수명 자료형(크기)
    단, 기존에 생성된 컬럼의 타입과 크기를 참조하여 선언하는게 좋다.
    아래 '이름'의 경우 2개의 컬럼이 합쳐진 상태이므로 조금 더 넉넉한
    크기로 설정해주는 것이 좋다.*/
    empName varchar2(50);
    empPhone varchar2(20);
begin
    /*실행부 : select 절에서 가져온 결과를 선언부에서 선언한 변수에 1:1
        로 대입하여 값을 저장한다. 이때 into를 사용한다. */
    select 
        concat(concat(first_name,' '), last_name),
        phone_number
    into
        empName, empPhone
    from employees
    where employee_id = 120;
    
    dbms_output.put_line(empName ||' '||empPhone);
end;
/

--예제3] 참조변수1(하나의 컬럼 참조) 
/*
참조변수 : 특정 테이블의 컬럼을 참조하는 변수로써 동일한 자료형과 
    크기로 선언하고 싶을 때 사용한다.
    형식]테이블명.컬럼명%type
        => 테이블의 '하나'의 컬럼만을 참조한다.
*/
/*
시나리오] 부서번호 10인 사원의 사원번호, 급여, 부서번호를 가져와서 
아래 변수에 대입후 화면상에 출력하는 PL/SQL문을 작성하시오. 
단, 변수는 기존테이블의 자료형을 참조하는 '참조변수'로 선언하시오.
*/
--시나리오의 조건에 맞는 select문을 작성한다.
select employee_id, salary, department_id 
from employees where department_id = 10;
    
declare
    --사원테이블의 특정 컬럼의 타입과 크기를 참조하는 변수로 선언한다.
    empNo employees.employee_id%type;--Number(6, 0)
    empSal employees.salary%type;--Number(8, 2)
    deptId employees.department_id%type;--Number(4, 0)와 동일하게 선언
    
begin
    --select절의 into를 통해 변수에 값을 할당한다. 
    select employee_id, salary, department_id
        into empNo, empSal, deptId
    from employees
    where department_id = 10;
    
    dbms_output.put_line(empNo|| ' ' || empSal || ' ' || deptId);
end;
/
--예제4] 참조변수2(전체컬럼을 참조)
/*
시나리오] 사원번호가 100인 사원의 레코드를 가져와서 emp_row변수에 전체컬럼을 저장한 후 화면에 다음 정보를 출력하시오.
단, emp_row는 사원테이블이 전체컬럼을 저장할 수 있는 참조변수로 선언해야한다. 
출력정보 : 사원번호, 이름, 이메일, 급여
*/
declare
    /*사원테이블의 전체컬럼을 참조하는 참조변수로 선언한다. 이때 테이블명 뒤에
    %rowtype을 붙여 선언한다.*/
    emp_row employees%rowtype;
begin
    /*와일드카드 *를 통해 얻어 온 전체컬럼을 변수 emp_row에 한꺼번에 저장할 수 있다. */
    select * 
        into emp_row
    from employees where employee_id = 100;
    /* emp_row애는 전체컬럼의 정보가 저장되므로 출력시 변수명.컬럼명 형태로 기술해야 한다.*/
    dbms_output.put_line(emp_row.employee_id||' '||
                        emp_row.first_name||' '||
                        emp_row.email||' '||
                        emp_row.salary);
end;
/

set serveroutput on;
/*
class를 정의하듯 필요한 자료형을 묶어 하나의 자료형을 만든 후 생성하는 변수를 말한다.
형식]type 복합변수자료형 is recorde (
        컬럼명1 자료형(크기),
        컬럼명2 테이블명.컬럼명%type
    );
    앞에서 선언한 자료형을 기반으로 변수를 생성한다.
    복합변수 자료형을 만들 때는 일반변수와 참조변수 2가지를 복합해서 사용할 수 있다.
*/
/*
예제5]복합변수
시나리오] 사원번호, 이름(first_name+last_name), 담당업무명을 저장할 수 있는 
복합변수를 선언한 후, 100번 사원의 정보를 출력하는 PL/SQL을 작성하시오.
*/
--조건에 맞는 쿼리문 생성
select employee_id , first_name||' '||last_name, job_id 
from employees where employee_id = 100;

declare
    --3개의 값을 저장할 수 있는 복합변수 자료형을 선언한다.
    type emp_3type is record(
         /*사원테이블의 컬럼을 참조하는 참조변수로 선언*/
        emp_id employees.employee_id%type,
        /*일반변수로 선언*/
        emp_name varchar2(50),
        emp_job employees.job_id%type
    );
    /*앞에서 선언한 복합변수 자료형을 통해 변수를 선언한다. 해당 복합변수를 통해 3개의 값을 
    저장할 수 있다. */
    record3 emp_3type;
begin
    --select절에서 인출한 3개의 값을 복합변수에 저장한다.
    select employee_id, first_name||' '||last_name, job_id
        into record3
    from employees where employee_id = 100;
    --결과를 출력한다.
    dbms_output.put_line(record3.emp_id||' '||
                        record3.emp_name||' '||
                        record3.emp_job);
end;
/
/*
연습문제]
아래 절차에 따라 PL/SQL문을 작성하시오.
1.복합변수생성
- 참조테이블 : employees
- 복합변수자료형의 이름 : empTypes
        멤버1 : emp_id -> 사원번호
        멤버2 : emp_name -> 사원의전체이름(이름+성)
        멤버3 : emp_salary -> 급여
        멤버4 : emp_percent -> 보너스율
위에서 생성한 자료형을 이용하여 복합변수 rec2를 생성후 사원번호 108번의 정보를 할당한다.

2.1의 내용을 출력한다.
3.위 내용을 완료한후 '치환연산자'를 사용하여 사원번호를 사용자로부터 입력받은 후 
해당 사원의 정보를 출력할수있도록 수정하시오.[보류]
*/
select employee_id, first_name||' '||last_name, salary, nvl(commission_pct, 0)
from employees
where employee_id = 108;

declare
    --4개의 멤버를 가진 복합변수 자료형을 선언한다.
    type empTypes is record (
        emp_id employees.employee_id%type,
        emp_name varchar2(50),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
    );
    --복합변수 자료형을 통해 변수를 생성한다.
    rec2 empTypes;
begin
    select employee_id, first_name||' '||last_name, salary, nvl(commission_pct, 0)
      into rec2
    from employees where employee_id = 108;
    
    dbms_output.put_line('사원번호 / 사원명 / 급여 / 보너스율');
    dbms_output.put_line(rec2.emp_id||' '||
                        rec2.emp_name||' '||
                        rec2.emp_salary||' '||
                        rec2.emp_percent);
end;
/
/*
치환연산자 : PL/SQL에서 사용자로부터 입력받을 때 사용하는 연산자로 
        변수 앞에 &를 붙여주면 된다. 실행시 입력창이 뜬다. 
*/
--앞에서 작성했떤 연습분제에 치환연산자를 적용한다.
declare
    --4개의 멤버를 가진 복합변수 자료형을 선언한다.
    type empTypes is record (
        emp_id employees.employee_id%type,
        emp_name varchar2(50),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
    );
    --복합변수 자료형을 통해 변수를 생성한다.
    rec2 empTypes;
    --치환연산자를 통해 입력받은 값, 3글자을 할당할 변수를 선언한다.
    inputNum number(3);
begin
    select employee_id, first_name||' '||last_name, salary, nvl(commission_pct, 0)
      into rec2
    from employees where employee_id = &inputNum;
    
    dbms_output.put_line('사원번호 / 사원명 / 급여 / 보너스율');
    dbms_output.put_line(rec2.emp_id||' '||
                        rec2.emp_name||' '||
                        rec2.emp_salary||' '||
                        rec2.emp_percent);
end;
/
/*
바인드변수
    : 호스트환경에서 선언된 변수로써 비 PL/SQL 변수이다.
    호스트환경이란 PL/SQL의 블럭을 제외한 나머지 부분을 말한다.
    콘솔(CMD)에서는 SQL 명령프롬프트가 있는 상태를 말한다.
    
    형식]
        var 변수명 자료형;
        혹은
        variable 변수명 자료형;
*/

--예제6] 바인드변수
set serveroutput on;
--호스트환경에서 바인드 변수 선언
var return_var number;
--PL/SQL 작성
declare
    --선언부에는 이와같이 아무 내용이 없을 수도 있다. 
begin
    --바인드변수는 일반변수와의 구분을 위해 :(콜론)을 추가해야한다.
    :return_var :=999;
    dbms_output.put_line(:return_var);
end;
/
/*호스트환경에서 바인드변수를 출력할 때는 print를 사용한다.*/
print return_var;
/*CMD에서는 문장을 개별적으로 실행해도 문제가 없지만, 디벨로퍼에서는 바인드변수터
마지막 Print문까지 블럭으로 지정한 후 실행해야 결과가 제대로 나오게 된다.(약간의
환경적인 차이가 있다고 생각하자)*/























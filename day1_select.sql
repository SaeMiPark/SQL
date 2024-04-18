select EMP_ID, EMP_NAME from EMPLOYEE; --table내의 데이터 조회 쿼리문

--조건에 의한 조회
select emp_id, emp_name, phone, salary from employee
where dept_code='D9' and salary <=5000000;

--Quiz
--01. job테이블의 job_name컬럼만 출력
desc job;
select job_name from job;
--002
select * from department;
--003
select emp_name, email, phone, hire_date from EMPLOYEE;
--004
select emp_name, salary from employee where salary>=2500000;
--005
select emp_name, phone from employee where salary>=3500000 and job_code='J3';

--급여가 300만원 이상 400만원 이하인 직원의 이름과 급여만 between and
--기본적으로 주어진 값을 포함하는 이상, 이하를 나타낸다.
select emp_name, salary from employee where salary between 3000000 and 4000000;

--부서코드가 D5 또는 D9 또는 D1인 직원의 이름, 부서코드, 연락처를 출력하세요.
--in: or연산자가 다수 필요할 경우 편리하게 줄여 사용할 수 있는 문법
--not in도 있다 뒤에 있는 것 빼고 라는 뜻
select * from employee;
select emp_name, dept_code, phone from employee where dept_code in ('D5','D1','D9');

--select 나열 구간에 꼭 컬럼명만 명시해야하는 것은 아니다.
--컬럼과의 연산 리터럴 값, 별명 표기도 가능
select emp_name 사원명, salary*12 연봉, '오라클 쉽네' as "oracle" from employee;

--문자열 연결시 || 사용
select emp_name 사원명, salary*12||'원' 연봉 from employee;

--null 검사 is null 또는 is not null
select * from employee where phone is not null;

--bonus를 받을 수 있는 직원
select emp_name, salary, bonus, salary*bonus 보너스금액 from EMPLOYEE where bonus is not null;

--날짜 출력 방법
--sysdate는 timestamp값을 모두 반환하지만(시분초포함)
--sql developer에서는 날짜 형식으로 지정해 연월일만 출력된다.

select emp_name, sysdate from employee;
select emp_name, sysdate+365*10 from employee;
--날짜타입 끼리의 뺼셈은 두 날짜간의 일수 차이를 만들어낸다.
select emp_name, sysdate-hire_date from employee;

--quiz
--01. employee테이블에서 이름, 연봉, 총수령액, 실수령액을 출력하세요
--출력 시, 컬럼명은 문제에서 제시된 컬럼명을 사용하세요.
desc employee;
select emp_name, salary*12 연봉, 
((nvl(bonus,0)*salary*12)+salary*12) 총수령액, 
((nvl(bonus,0)*salary*12)+salary*12)-(((nvl(bonus,0)*salary*12)+salary*12)*0.03) 실수령액
from EMPLOYEE;

--02. 직원들의 이름 및 근무 일수를 출력해주세요.(뒤에는 일을 붙여주세요)
select emp_name, floor(sysdate-hire_date)||'일' 근무일수 from employee;

--03. 
select emp_name, dept_code, salary, bonus from employee
where sysdate-hire_date>=365*20;

select emp_name, dept_code, salary, bonus from employee
where hire_date < '2004/04/18';



--Like 문자열을 비교할 때 같다가 아닌 contains 또는 startwith또는 endswiths를 비교할 수 있음
--이름이 이런 것 같은 애
--%한글자 이상이 존재하는 경우
select * from employee where emp_name like '윤%';
select * from employee where emp_name like '%태_';
select * from employee where emp_name like '전_';
select * from employee where emp_name like '%전%';--전이 어디든 들어가면 찾음
select * from employee where emp_name like '-전_';--3글자 중 가운데가 전인 것만 찾음

--전화번호가 010이 아닌 
select emp_name, phone from employee 
where phone not like '010%';

select * from employee 
where email like '%s%' and 
    dept_code in ('D9','D6') and 
    hire_date between '90/01/01' and '00/12/31' and 
    salary>=2700000;
    
--정렬
select * from employee
order by dept_code nulls last;

--문제1
select emp_name, emp_no, salary, hire_date 
from employee
where sysdate-hire_date between 1825 and 3650;

--문제2
select emp_name, dept_code from employee
where ent_yn='Y';

--문제3
select emp_name 이름, salary*1.5 급여, EXTRACT(YEAR FROM sysdate)-EXTRACT(YEAR FROM hire_date) as 근속년수
from employee
where EXTRACT(YEAR FROM sysdate)-EXTRACT(YEAR FROM hire_date)>=10
order by hire_date;

--문제4
select emp_name, emp_no, email, phone, salary
from employee
where hire_date between '19/01/01' and '10/01/01'
and salary <= 2000000;

--문제5
select emp_name, emp_no, salary, nvl(dept_code, '없음') as dept_code
from employee
where salary between 2000000 and 3000000
and emp_no like '_______2%'
and emp_no like '___4%'
order by emp_no desc;

--문제 6
select emp_name 이름, floor((sysdate-hire_date)/1000)*(salary*0.1) 특별보너스
from EMPLOYEE
where bonus is null
and emp_no like '_______1%'
order by emp_name;


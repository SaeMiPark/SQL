--union
--한 개 이상의 테이블을 병합해 테이터셋을 만드는 문법

create table testA(
    data varchar(10) --세미콜론 없음
);--세미콜론 마지막

insert into testA values('A');
insert into testA values('B');
insert into testA values('C');

--drop table testA;

create table testB(
    data varchar(10)
);

insert into testB values('B');
insert into testB values('C');
insert into testB values('D');

select * from testA; --A B C
select * from testB; --B C D

--union 중복 제거
select * from testA
union
select * from testB;

--union 중복 허용
select * from testA
union all
select * from testB;

--intersect
select * from testA
intersect
select * from testB;

--minus
select * from testA
minus
select * from testB;

--Sub Query
--전지연 직원 직속상사 이름이 뭐야?
--방법1. self join
--방법2. 서브쿼리
select emp_name 
from employee
where emp_id=214;

--214를 가져오는 것을 서브쿼리로 작성할 수 있다.
select emp_name 
from employee
where emp_id = (
    select manager_id
    from employee
    where emp_name='전지연'
);

--평균 급여보다 많이 받는 사람
--1. 전직원의 평균급여를 구하는 서브쿼리
--2. 직원 중 1번에서 구한 평균 급여값보다 급여가 높은 사람 조회
select avg(salary)
from employee;

select emp_name, salary
from employee
where salary >= (
    select avg(salary)
    from employee
);

--퀴즈
--윤은해 직원과 급여가 같은 사원들의
select emp_id, emp_name, salary
from employee
where salary = (
    select salary
    from employee
    where emp_name = '윤은해'
)
and emp_name <> '윤은해';

--집계함수와 다른 열 불러오기
--where절에도 서브쿼리를 이용해 그룹함수 쓰기
select emp_id, emp_name, salary
from employee
where salary in ((select max(salary)from employee),
(select min(salary) from employee));

--다른 방법
select emp_id, emp_name, salary
from employee
where salary = (select max(salary)from employee)
or salary = (select min(salary) from employee);

--다른 방법 시도 
select emp_id, emp_name, salary
from employee
where salary in (
    SELECT MAX(salary) FROM employee
    UNION
    SELECT MIN(salary) FROM employee
);

--퀴즈
--d1, d2 부서에서 근무하는 사원중에 기본급여가 
--d5부서의 급여 평균보다 높은 사람들의 
--사원명, 부서코드, 부서명, 급여를 출력하세요
select emp_name, dept_code, dept_title, salary
from employee e join department d on e.dept_code=d.DEPT_ID
where dept_code in ('D1','D2')
    and salary > (
        select avg(salary)
        from employee
        where dept_code='D5'
    );
    
--다중행 서브쿼리
--반환값이 다중행인 경우
--송중기 또는 박나라 직원의 부서코드를 출력하세요.
select dept_code from employee where emp_name in('송종기','박나라');
--송중기 또는 박나라 속한 부서와 같은 부서 부서원 정보를 출력하세요.
select emp_name from employee 
where dept_code in (select dept_code from employee where emp_name in('송종기','박나라')); 

--차태현 직원과 전지현 직원의 급여 등급과 같은 등급을 가진
--사원명과 직급명, 급여등급 출력
select emp_name, job_name, e.SAL_LEVEL 
from EMPLOYEE e join JOB j on e.JOB_CODE=j.JOB_CODE
where e.SAL_LEVEL in (
    select sal_level from EMPLOYEE 
    where emp_name in('차태현','전지연')
); 

--직급이 대표, 부사장, 부장이 아닌 모든 직원의
--사번, 사원명, 직급명, 부서명을 입력하세요
select emp_id, emp_name, job_name, dept_title
from EMPLOYEE e 
--job에서는 서로 모든 데이터가 매칭되기 때문에 괜찮고,
join JOB j on e.JOB_CODE=j.JOB_CODE 
--e에 부서가값이 null인 애들이 있기 때문에 해줘야한다.
left join department d on e.dept_code=d.DEPT_ID 
where e.job_code not in ( --in
    select job_code
    from job
    where job_name in('대표','부사장','부장') --not in
);  

--다중열 서브쿼리
--다중 열 단일 행
--퇴사한 직원과 같은 부서이면서, 같은 직급인 (and)
--사원명과 직급코드, 부서코드, 입사일을 출력
select *
from employee e
where ent_yn='Y';

select emp_name, job_code, dept_code, hire_date
from employee e
where (dept_code,job_code) in ( --서브쿼리와 순서 맞춰야 한다.
    select dept_code, job_code
    from employee
    where ent_yn='Y'
)
and emp_name <> '이태림';

--생일이 8월 8일인 사원들과
--같은 부서코드, 직급코드를 가진
--사원들의 사원명, 생일, 부서코드, 부서명을 출력해보자.
--다중행 다중열 서브쿼리
select emp_name, substr(emp_no, 3, 4) 생일 
,dept_code, dept_title
from employee e join  department d on e.dept_code=d.DEPT_ID
where (dept_code, job_code) in (
    select dept_code, job_code
    from employee
    WHERE substr(emp_no, 3,4)='0808'
);

--퀴즈
--부서별 급여 제일 많이 받는 직원
--직원의 부서코드, 사원명, 부서명, 급여를 출력
select nvl(dept_code,'etc') 부서코드, 
    nvl(dept_title,'Intern') 부서명, 
    emp_name, salary
from employee e 
left join DEPARTMENT d on e.dept_code=d.DEPT_ID
where salary in (
    select max(salary)
    from employee
    group by dept_code
)
order by 1;

--급여 등급도 max min이 가능하다
--각 직급마다 급여 등급이 가장 높은 직원의 이름, 직급코드, 직급명, 급여, 급여등급을 출력하세요
select 
    emp_name, job_code,
    salary, sal_level
from employee
where (job_code, sal_level) in (
    --직급별 제일 sal_level인 사람 min해야 함
    select job_code, min(sal_level)
    from employee
    group by job_code
)
order by 2;

--인라인뷰 서브쿼리(from)
--from 절에서 서브쿼리를 사용해나온 결과에 대해 
--select 쿼리를 적용하는 문법

--연관쿼리, 
select emp_name, (
    select dept_title
    from department
    where e.dept_code=dept_id --메인쿼리의 테이블이 사용될 때
) 부서명
from employee e;

--사원명과 직급명을 출력하세요
select emp_name, (
    select job_name
    from job
    where e.job_code=job_code
) 직급명
from employee e;

--사원명과 매니저명을 출력하세요.
select emp_name, (
    select emp_name
    from employee
    where e1.manager_id=emp_id
) 매니저명
from employee e1;



   
--quiz
select emp_name, salary, rank() over(order by salary desc)
from employee;

select emp_name, salary, dense_rank() over(order by salary desc)
from employee;

select emp_name, salary, row_number() over(order by salary desc)
from employee;

--퀴즈
select *
from(
    select emp_id, emp_name,
    row_number() over(order by salary desc) as 랭킹
    from EMPLOYEE
)
where 랭킹 between 5 and 10;
























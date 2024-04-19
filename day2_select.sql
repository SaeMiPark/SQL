select * from employee;

--dual 테이블: 테스트 쿼리를 실행해보기 위한 더미데이터 테이블
select lengthb('a') from dual;
select * from dual;

--length: 컬럼값의 길이를 측정하는 함수
select emp_name, length(emp_name) from employee;
select emp_name, lengthb(emp_name) from employee;

--instr문자열 내에서 특정 문자의 위치값을 검색해 반환하는 함수
select instr('hello world hi hi', 'hi', 1, 1) from dual; 

--substr문자열 내에서 문자열을 추출하는 함수이다.
select 'Hello World' from dual;
select substr('Hello World', 2, 6) from dual;
select substr('한글에서도 적용됩니다.', 2, 6) from dual;

--이름 성씨만 출력, distrinct 중복제거 첫번째 컬럼에 대해서만 사용 가능
select distinct substr(emp_name,1,1) from employee;

--quiz
--남직원의 사원 번호, 사원명, 주민번호, 연봉을 출력하세요
--주민번호 뒷자리는 *표시로 출력
select * from employee;
select emp_id, emp_name, 
substr(emp_no, 1, 8)||'******' 주민번호, salary*12 연봉
from employee
where substr(emp_no, 8, 1) in (1,3);
--where emp_no like '_______1%';

select replace('Hello World','World', 'Oracle') from dual;

--숫자관련 함수
select floor(123.456) from dual;
select trunc(123.456, 2) from dual; --2째자리까지 나타낸다
select ceil(123.456) from dual;
select round(123.556, 1) from dual;--1째자리까지 나타낸다
select abs(-5) from dual;
select mod(10,3) from dual;

--날짜관련 함수
--sysdate 현재시간 반환 연,월,일 시,분,초 형식으로 반환
--localtimestamp 초 밑에까지 반환된다
SELECT sysdate from dual;
select localtimestamp from dual;

--months_between(날짜1,날짜2): 두 날짜 사이의 개월 수 차이를 반환

select emp_name, months_between(sysdate, hire_date) from EMPLOYEE;

--add_months(날짜, 정수(개월수))
select add_months(sysdate, 2) from dual;

--next_day(날짜, 요일): 날짜를 기준으로 가장 가까운 요일을 반환해주는 함수
select next_day(sysdate,'월') from dual;

--last_day(날짜): 해당 날짜가 속한 달의 마지막 날짜를 반환해주는 함수
select last_day(sysdate) from dual;

--입사일 마지막 날짜
select emp_name, hire_date, 
last_day(hire_date) 
from EMPLOYEE;

--다음달 마지막 날짜
select 
last_day(add_months(sysdate,1)) 
from EMPLOYEE;

--extract: 날짜데이터로부터 연/월/일을 추출하는 함수
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;

--직원 중 5월에 입사한 사람의 이름과 입사일을 출력
select emp_name, hire_date
from EMPLOYEE
where extract(month from hire_date)=5;


--연차=내가 향해가는 방향
select * from EMPLOYEE;
select emp_name,
    extract(year from hire_date)||'년'
    ||extract(month from hire_date)||'월'
    ||extract(day from hire_date)||'일' 입사일, 
    ceil(months_between(sysdate,hire_date)/12) 년차
from EMPLOYEE
order by "입사일";

--order by에 select에서 지은 별명 사용가능.
--날짜 더 쉽게 바꾸기 형변환 함수
--to_char: 닐짜->문자열
select to_char(sysdate, 'yyyy"년"mm"월"dd"일"(day) hh24:mi:ss') from dual;
--day금요일
--dy 금

--숫자->문자열
--대상 숫자보다 형식 문자의 길이가 더 길어야 에러가 나지 않음
select to_char(12343, 'L999,999,999.99') from dual;
--L: local 통화를 붙여서 출력해줌

--직원들 급여를 local 통화 형식
select emp_name, 
to_char(salary, 'L999,999,999,999,999') salary
from EMPLOYEE;

--문자열-> 날짜
select to_date('24년03월01일','yy"년"mm"월"dd"일"') from dual;

--quiz
--1950년 6월 25일 무슨 요일
select to_char(to_date('1950.06.25','yyyy.mm.dd'), 'yyyy.mm.dd dy')
from dual;

--그룹함수: 전체 행에 대하여 일괄 적용되는 함수 
select sum(salary) from employee;

--평균 급여
select to_char(floor(avg(salary)), '999,999,999') as 평균급여 from employee;
select '누구니',max(salary) from employee;
select min(salary) from employee;
select count(emp_no) from employee;
select count(*) from employee;

select * from employee;
--d5부서에서 급여를 제일 많이 받는 사람은 얼마?
select max(salary) 
from employee
where dept_code='D5';

--j3직급인 직원들의 급여 평균
select avg(salary)
from employee
where job_code='J3';

--아직 부서코드를 배정받지 못한 직원의 인원 수
select count(*)
from employee
where dept_code is null;


--문자->숫자
select '123'-100 from dual;

select * from EMPLOYEE;

--1.
select emp_name, length(email) from EMPLOYEE;

--2.
select emp_name, 
substr(email, 1, instr(email, '@', 1, 1)-1) id추출 
from employee;

--3.60년대생의 직원명과 년생, 보너스율을 출력하세요.
select emp_name, '19'||substr(emp_no, 1, 2) 년생,
nvl(bonus,0)*100||'%' 보너스율
from EMPLOYEE
where substr(emp_no, 1, 1)=6;

--4
select count(phone)||'명' 핸드폰번호
from EMPLOYEE
where phone not like'010%';
--where substr(phone,1,3)<>'010'

--5
select emp_name, to_char(hire_date, 'yyyy"년"mm"월"') 입사년월
from EMPLOYEE;

--6 주민번호 뒷자리 *로 바꾸기
select emp_name, substr(emp_no, 1, 8)||'*****' 주민번호
from EMPLOYEE;

--7
select emp_name, job_code, to_char((salary+(salary*nvl(bonus,0))),'fmL999,999,999,999') 연봉
from EMPLOYEE;

--8
select count(*)
from employee
where dept_code in ('D5', 'D9')
and extract(year from hire_date)=2004;
--substr(hire_date,1,2)='04'

--9
select emp_name, hire_date, floor(sysdate-hire_date) 근무일수
from employee;

--10
select max((to_char(sysdate, 'yyyy'))-(1900+substr(emp_no,1,2))) as 많은나이
from employee;

select min((to_char(sysdate, 'yyyy'))-(1900+substr(emp_no,1,2))) as 적은나이
from employee;


--분기 함수
--decode(대상값, 조건1, '결과1', 조건2, '결과2','결과3');
--가변 인자 값을 허용함

select decode(50,1,'결과1',2,'결과2','결과없음') from dual;

--quiz
select emp_id, emp_name,
decode(ent_yn, 'Y', to_char(ent_date, 'yy"년 "mm"월 "dd"일 퇴사"'), 'N', '재직중') 퇴사여부
from employee;

--quiz
select emp_id, emp_name, decode(substr(emp_no,8,1), '1', '남', '2', '여', '3', '남','4','여') 성별
from employee;

--quiz
--d5분서는 급여의 10%, d2는 급여의 20%, d9 급여의 30% , 나머지는 없음
select * from employee;
select nvl(dept_code, '인턴'), emp_name,
decode(dept_code, 'D5', '10%', 'D2', '20%', 'D9', '30%', '없음') 보너스율,
decode(dept_code, 'D5', salary*0.1, 'D2', salary*0.2, 'D9', salary*0.3, 0) 특별보너스
from employee
order by dept_code;

--case 
--decode보다 더 복잡한 분기점을 구현할 때 사용한다.
select emp_name,
    case
        when substr(emp_no,8,1) in (1,3) then '남'
        when substr(emp_no,8,1) in (2,4) then '여'
        else '외게인'
    end 성별
from employee;

select * from employee;
select emp_id, emp_name,
    case
        when substr(emp_no,1,2)>=80 then '80년대생'
        when substr(emp_no,1,2)>=70 then '70년대생'
        when substr(emp_no,1,2)>=60 then '60년대생'
    end 나이대
from employee
order by emp_no;

--quiz02
select emp_name,
ceil(months_between(sysdate,hire_date)/12) 년차,
case
        when ceil(months_between(sysdate,hire_date)/12) >=20 then 'Senior'
        when ceil(months_between(sysdate,hire_date)/12) >=10 then 'Intermediate'
        when ceil(months_between(sysdate,hire_date)/12) >=0 then 'Junior'
end 직급레벨
from employee
order by 년차;


--union
--�� �� �̻��� ���̺��� ������ �����ͼ��� ����� ����

create table testA(
    data varchar(10) --�����ݷ� ����
);--�����ݷ� ������

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

--union �ߺ� ����
select * from testA
union
select * from testB;

--union �ߺ� ���
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
--������ ���� ���ӻ�� �̸��� ����?
--���1. self join
--���2. ��������
select emp_name 
from employee
where emp_id=214;

--214�� �������� ���� ���������� �ۼ��� �� �ִ�.
select emp_name 
from employee
where emp_id = (
    select manager_id
    from employee
    where emp_name='������'
);

--��� �޿����� ���� �޴� ���
--1. �������� ��ձ޿��� ���ϴ� ��������
--2. ���� �� 1������ ���� ��� �޿������� �޿��� ���� ��� ��ȸ
select avg(salary)
from employee;

select emp_name, salary
from employee
where salary >= (
    select avg(salary)
    from employee
);

--����
--������ ������ �޿��� ���� �������
select emp_id, emp_name, salary
from employee
where salary = (
    select salary
    from employee
    where emp_name = '������'
)
and emp_name <> '������';

--�����Լ��� �ٸ� �� �ҷ�����
--where������ ���������� �̿��� �׷��Լ� ����
select emp_id, emp_name, salary
from employee
where salary in ((select max(salary)from employee),
(select min(salary) from employee));

--�ٸ� ���
select emp_id, emp_name, salary
from employee
where salary = (select max(salary)from employee)
or salary = (select min(salary) from employee);

--�ٸ� ��� �õ� 
select emp_id, emp_name, salary
from employee
where salary in (
    SELECT MAX(salary) FROM employee
    UNION
    SELECT MIN(salary) FROM employee
);

--����
--d1, d2 �μ����� �ٹ��ϴ� ����߿� �⺻�޿��� 
--d5�μ��� �޿� ��պ��� ���� ������� 
--�����, �μ��ڵ�, �μ���, �޿��� ����ϼ���
select emp_name, dept_code, dept_title, salary
from employee e join department d on e.dept_code=d.DEPT_ID
where dept_code in ('D1','D2')
    and salary > (
        select avg(salary)
        from employee
        where dept_code='D5'
    );
    
--������ ��������
--��ȯ���� �������� ���
--���߱� �Ǵ� �ڳ��� ������ �μ��ڵ带 ����ϼ���.
select dept_code from employee where emp_name in('������','�ڳ���');
--���߱� �Ǵ� �ڳ��� ���� �μ��� ���� �μ� �μ��� ������ ����ϼ���.
select emp_name from employee 
where dept_code in (select dept_code from employee where emp_name in('������','�ڳ���')); 

--������ ������ ������ ������ �޿� ��ް� ���� ����� ����
--������ ���޸�, �޿���� ���
select emp_name, job_name, e.SAL_LEVEL 
from EMPLOYEE e join JOB j on e.JOB_CODE=j.JOB_CODE
where e.SAL_LEVEL in (
    select sal_level from EMPLOYEE 
    where emp_name in('������','������')
); 

--������ ��ǥ, �λ���, ������ �ƴ� ��� ������
--���, �����, ���޸�, �μ����� �Է��ϼ���
select emp_id, emp_name, job_name, dept_title
from EMPLOYEE e 
--job������ ���� ��� �����Ͱ� ��Ī�Ǳ� ������ ������,
join JOB j on e.JOB_CODE=j.JOB_CODE 
--e�� �μ������� null�� �ֵ��� �ֱ� ������ ������Ѵ�.
left join department d on e.dept_code=d.DEPT_ID 
where e.job_code not in ( --in
    select job_code
    from job
    where job_name in('��ǥ','�λ���','����') --not in
);  

--���߿� ��������
--���� �� ���� ��
--����� ������ ���� �μ��̸鼭, ���� ������ (and)
--������ �����ڵ�, �μ��ڵ�, �Ի����� ���
select *
from employee e
where ent_yn='Y';

select emp_name, job_code, dept_code, hire_date
from employee e
where (dept_code,job_code) in ( --���������� ���� ����� �Ѵ�.
    select dept_code, job_code
    from employee
    where ent_yn='Y'
)
and emp_name <> '���¸�';

--������ 8�� 8���� ������
--���� �μ��ڵ�, �����ڵ带 ����
--������� �����, ����, �μ��ڵ�, �μ����� ����غ���.
--������ ���߿� ��������
select emp_name, substr(emp_no, 3, 4) ���� 
,dept_code, dept_title
from employee e join  department d on e.dept_code=d.DEPT_ID
where (dept_code, job_code) in (
    select dept_code, job_code
    from employee
    WHERE substr(emp_no, 3,4)='0808'
);

--����
--�μ��� �޿� ���� ���� �޴� ����
--������ �μ��ڵ�, �����, �μ���, �޿��� ���
select nvl(dept_code,'etc') �μ��ڵ�, 
    nvl(dept_title,'Intern') �μ���, 
    emp_name, salary
from employee e 
left join DEPARTMENT d on e.dept_code=d.DEPT_ID
where salary in (
    select max(salary)
    from employee
    group by dept_code
)
order by 1;

--�޿� ��޵� max min�� �����ϴ�
--�� ���޸��� �޿� ����� ���� ���� ������ �̸�, �����ڵ�, ���޸�, �޿�, �޿������ ����ϼ���
select 
    emp_name, job_code,
    salary, sal_level
from employee
where (job_code, sal_level) in (
    --���޺� ���� sal_level�� ��� min�ؾ� ��
    select job_code, min(sal_level)
    from employee
    group by job_code
)
order by 2;

--�ζ��κ� ��������(from)
--from ������ ���������� ����س��� ����� ���� 
--select ������ �����ϴ� ����

--��������, 
select emp_name, (
    select dept_title
    from department
    where e.dept_code=dept_id --���������� ���̺��� ���� ��
) �μ���
from employee e;

--������ ���޸��� ����ϼ���
select emp_name, (
    select job_name
    from job
    where e.job_code=job_code
) ���޸�
from employee e;

--������ �Ŵ������� ����ϼ���.
select emp_name, (
    select emp_name
    from employee
    where e1.manager_id=emp_id
) �Ŵ�����
from employee e1;



   
--quiz
select emp_name, salary, rank() over(order by salary desc)
from employee;

select emp_name, salary, dense_rank() over(order by salary desc)
from employee;

select emp_name, salary, row_number() over(order by salary desc)
from employee;

--����
select *
from(
    select emp_id, emp_name,
    row_number() over(order by salary desc) as ��ŷ
    from EMPLOYEE
)
where ��ŷ between 5 and 10;
























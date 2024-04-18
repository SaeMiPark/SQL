select EMP_ID, EMP_NAME from EMPLOYEE; --table���� ������ ��ȸ ������

--���ǿ� ���� ��ȸ
select emp_id, emp_name, phone, salary from employee
where dept_code='D9' and salary <=5000000;

--Quiz
--01. job���̺��� job_name�÷��� ���
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

--�޿��� 300���� �̻� 400���� ������ ������ �̸��� �޿��� between and
--�⺻������ �־��� ���� �����ϴ� �̻�, ���ϸ� ��Ÿ����.
select emp_name, salary from employee where salary between 3000000 and 4000000;

--�μ��ڵ尡 D5 �Ǵ� D9 �Ǵ� D1�� ������ �̸�, �μ��ڵ�, ����ó�� ����ϼ���.
--in: or�����ڰ� �ټ� �ʿ��� ��� ���ϰ� �ٿ� ����� �� �ִ� ����
--not in�� �ִ� �ڿ� �ִ� �� ���� ��� ��
select * from employee;
select emp_name, dept_code, phone from employee where dept_code in ('D5','D1','D9');

--select ���� ������ �� �÷��� ����ؾ��ϴ� ���� �ƴϴ�.
--�÷����� ���� ���ͷ� ��, ���� ǥ�⵵ ����
select emp_name �����, salary*12 ����, '����Ŭ ����' as "oracle" from employee;

--���ڿ� ����� || ���
select emp_name �����, salary*12||'��' ���� from employee;

--null �˻� is null �Ǵ� is not null
select * from employee where phone is not null;

--bonus�� ���� �� �ִ� ����
select emp_name, salary, bonus, salary*bonus ���ʽ��ݾ� from EMPLOYEE where bonus is not null;

--��¥ ��� ���
--sysdate�� timestamp���� ��� ��ȯ������(�ú�������)
--sql developer������ ��¥ �������� ������ �����ϸ� ��µȴ�.

select emp_name, sysdate from employee;
select emp_name, sysdate+365*10 from employee;
--��¥Ÿ�� ������ �E���� �� ��¥���� �ϼ� ���̸� ������.
select emp_name, sysdate-hire_date from employee;

--quiz
--01. employee���̺��� �̸�, ����, �Ѽ��ɾ�, �Ǽ��ɾ��� ����ϼ���
--��� ��, �÷����� �������� ���õ� �÷����� ����ϼ���.
desc employee;
select emp_name, salary*12 ����, 
((nvl(bonus,0)*salary*12)+salary*12) �Ѽ��ɾ�, 
((nvl(bonus,0)*salary*12)+salary*12)-(((nvl(bonus,0)*salary*12)+salary*12)*0.03) �Ǽ��ɾ�
from EMPLOYEE;

--02. �������� �̸� �� �ٹ� �ϼ��� ������ּ���.(�ڿ��� ���� �ٿ��ּ���)
select emp_name, floor(sysdate-hire_date)||'��' �ٹ��ϼ� from employee;

--03. 
select emp_name, dept_code, salary, bonus from employee
where sysdate-hire_date>=365*20;

select emp_name, dept_code, salary, bonus from employee
where hire_date < '2004/04/18';



--Like ���ڿ��� ���� �� ���ٰ� �ƴ� contains �Ǵ� startwith�Ǵ� endswiths�� ���� �� ����
--�̸��� �̷� �� ���� ��
--%�ѱ��� �̻��� �����ϴ� ���
select * from employee where emp_name like '��%';
select * from employee where emp_name like '%��_';
select * from employee where emp_name like '��_';
select * from employee where emp_name like '%��%';--���� ���� ���� ã��
select * from employee where emp_name like '-��_';--3���� �� ����� ���� �͸� ã��

--��ȭ��ȣ�� 010�� �ƴ� 
select emp_name, phone from employee 
where phone not like '010%';

select * from employee 
where email like '%s%' and 
    dept_code in ('D9','D6') and 
    hire_date between '90/01/01' and '00/12/31' and 
    salary>=2700000;
    
--����
select * from employee
order by dept_code nulls last;

--����1
select emp_name, emp_no, salary, hire_date 
from employee
where sysdate-hire_date between 1825 and 3650;

--����2
select emp_name, dept_code from employee
where ent_yn='Y';

--����3
select emp_name �̸�, salary*1.5 �޿�, EXTRACT(YEAR FROM sysdate)-EXTRACT(YEAR FROM hire_date) as �ټӳ��
from employee
where EXTRACT(YEAR FROM sysdate)-EXTRACT(YEAR FROM hire_date)>=10
order by hire_date;

--����4
select emp_name, emp_no, email, phone, salary
from employee
where hire_date between '19/01/01' and '10/01/01'
and salary <= 2000000;

--����5
select emp_name, emp_no, salary, nvl(dept_code, '����') as dept_code
from employee
where salary between 2000000 and 3000000
and emp_no like '_______2%'
and emp_no like '___4%'
order by emp_no desc;

--���� 6
select emp_name �̸�, floor((sysdate-hire_date)/1000)*(salary*0.1) Ư�����ʽ�
from EMPLOYEE
where bonus is null
and emp_no like '_______1%'
order by emp_name;


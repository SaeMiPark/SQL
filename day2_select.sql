select * from employee;

--dual ���̺�: �׽�Ʈ ������ �����غ��� ���� ���̵����� ���̺�
select lengthb('a') from dual;
select * from dual;

--length: �÷����� ���̸� �����ϴ� �Լ�
select emp_name, length(emp_name) from employee;
select emp_name, lengthb(emp_name) from employee;

--instr���ڿ� ������ Ư�� ������ ��ġ���� �˻��� ��ȯ�ϴ� �Լ�
select instr('hello world hi hi', 'hi', 1, 1) from dual; 

--substr���ڿ� ������ ���ڿ��� �����ϴ� �Լ��̴�.
select 'Hello World' from dual;
select substr('Hello World', 2, 6) from dual;
select substr('�ѱۿ����� ����˴ϴ�.', 2, 6) from dual;

--�̸� ������ ���, distrinct �ߺ����� ù��° �÷��� ���ؼ��� ��� ����
select distinct substr(emp_name,1,1) from employee;

--quiz
--�������� ��� ��ȣ, �����, �ֹι�ȣ, ������ ����ϼ���
--�ֹι�ȣ ���ڸ��� *ǥ�÷� ���
select * from employee;
select emp_id, emp_name, 
substr(emp_no, 1, 8)||'******' �ֹι�ȣ, salary*12 ����
from employee
where substr(emp_no, 8, 1) in (1,3);
--where emp_no like '_______1%';

select replace('Hello World','World', 'Oracle') from dual;

--���ڰ��� �Լ�
select floor(123.456) from dual;
select trunc(123.456, 2) from dual; --2°�ڸ����� ��Ÿ����
select ceil(123.456) from dual;
select round(123.556, 1) from dual;--1°�ڸ����� ��Ÿ����
select abs(-5) from dual;
select mod(10,3) from dual;

--��¥���� �Լ�
--sysdate ����ð� ��ȯ ��,��,�� ��,��,�� �������� ��ȯ
--localtimestamp �� �ؿ����� ��ȯ�ȴ�
SELECT sysdate from dual;
select localtimestamp from dual;

--months_between(��¥1,��¥2): �� ��¥ ������ ���� �� ���̸� ��ȯ

select emp_name, months_between(sysdate, hire_date) from EMPLOYEE;

--add_months(��¥, ����(������))
select add_months(sysdate, 2) from dual;

--next_day(��¥, ����): ��¥�� �������� ���� ����� ������ ��ȯ���ִ� �Լ�
select next_day(sysdate,'��') from dual;

--last_day(��¥): �ش� ��¥�� ���� ���� ������ ��¥�� ��ȯ���ִ� �Լ�
select last_day(sysdate) from dual;

--�Ի��� ������ ��¥
select emp_name, hire_date, 
last_day(hire_date) 
from EMPLOYEE;

--������ ������ ��¥
select 
last_day(add_months(sysdate,1)) 
from EMPLOYEE;

--extract: ��¥�����ͷκ��� ��/��/���� �����ϴ� �Լ�
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;

--���� �� 5���� �Ի��� ����� �̸��� �Ի����� ���
select emp_name, hire_date
from EMPLOYEE
where extract(month from hire_date)=5;


--����=���� ���ذ��� ����
select * from EMPLOYEE;
select emp_name,
    extract(year from hire_date)||'��'
    ||extract(month from hire_date)||'��'
    ||extract(day from hire_date)||'��' �Ի���, 
    ceil(months_between(sysdate,hire_date)/12) ����
from EMPLOYEE
order by "�Ի���";

--order by�� select���� ���� ���� ��밡��.
--��¥ �� ���� �ٲٱ� ����ȯ �Լ�
--to_char: ��¥->���ڿ�
select to_char(sysdate, 'yyyy"��"mm"��"dd"��"(day) hh24:mi:ss') from dual;
--day�ݿ���
--dy ��

--����->���ڿ�
--��� ���ں��� ���� ������ ���̰� �� ���� ������ ���� ����
select to_char(12343, 'L999,999,999.99') from dual;
--L: local ��ȭ�� �ٿ��� �������

--������ �޿��� local ��ȭ ����
select emp_name, 
to_char(salary, 'L999,999,999,999,999') salary
from EMPLOYEE;

--���ڿ�-> ��¥
select to_date('24��03��01��','yy"��"mm"��"dd"��"') from dual;

--quiz
--1950�� 6�� 25�� ���� ����
select to_char(to_date('1950.06.25','yyyy.mm.dd'), 'yyyy.mm.dd dy')
from dual;

--�׷��Լ�: ��ü �࿡ ���Ͽ� �ϰ� ����Ǵ� �Լ� 
select sum(salary) from employee;

--��� �޿�
select to_char(floor(avg(salary)), '999,999,999') as ��ձ޿� from employee;
select '������',max(salary) from employee;
select min(salary) from employee;
select count(emp_no) from employee;
select count(*) from employee;

select * from employee;
--d5�μ����� �޿��� ���� ���� �޴� ����� ��?
select max(salary) 
from employee
where dept_code='D5';

--j3������ �������� �޿� ���
select avg(salary)
from employee
where job_code='J3';

--���� �μ��ڵ带 �������� ���� ������ �ο� ��
select count(*)
from employee
where dept_code is null;


--����->����
select '123'-100 from dual;

select * from EMPLOYEE;

--1.
select emp_name, length(email) from EMPLOYEE;

--2.
select emp_name, 
substr(email, 1, instr(email, '@', 1, 1)-1) id���� 
from employee;

--3.60������ ������� ���, ���ʽ����� ����ϼ���.
select emp_name, '19'||substr(emp_no, 1, 2) ���,
nvl(bonus,0)*100||'%' ���ʽ���
from EMPLOYEE
where substr(emp_no, 1, 1)=6;

--4
select count(phone)||'��' �ڵ�����ȣ
from EMPLOYEE
where phone not like'010%';
--where substr(phone,1,3)<>'010'

--5
select emp_name, to_char(hire_date, 'yyyy"��"mm"��"') �Ի���
from EMPLOYEE;

--6 �ֹι�ȣ ���ڸ� *�� �ٲٱ�
select emp_name, substr(emp_no, 1, 8)||'*****' �ֹι�ȣ
from EMPLOYEE;

--7
select emp_name, job_code, to_char((salary+(salary*nvl(bonus,0))),'fmL999,999,999,999') ����
from EMPLOYEE;

--8
select count(*)
from employee
where dept_code in ('D5', 'D9')
and extract(year from hire_date)=2004;
--substr(hire_date,1,2)='04'

--9
select emp_name, hire_date, floor(sysdate-hire_date) �ٹ��ϼ�
from employee;

--10
select max((to_char(sysdate, 'yyyy'))-(1900+substr(emp_no,1,2))) as ��������
from employee;

select min((to_char(sysdate, 'yyyy'))-(1900+substr(emp_no,1,2))) as ��������
from employee;


--�б� �Լ�
--decode(���, ����1, '���1', ����2, '���2','���3');
--���� ���� ���� �����

select decode(50,1,'���1',2,'���2','�������') from dual;

--quiz
select emp_id, emp_name,
decode(ent_yn, 'Y', to_char(ent_date, 'yy"�� "mm"�� "dd"�� ���"'), 'N', '������') ��翩��
from employee;

--quiz
select emp_id, emp_name, decode(substr(emp_no,8,1), '1', '��', '2', '��', '3', '��','4','��') ����
from employee;

--quiz
--d5�м��� �޿��� 10%, d2�� �޿��� 20%, d9 �޿��� 30% , �������� ����
select * from employee;
select nvl(dept_code, '����'), emp_name,
decode(dept_code, 'D5', '10%', 'D2', '20%', 'D9', '30%', '����') ���ʽ���,
decode(dept_code, 'D5', salary*0.1, 'D2', salary*0.2, 'D9', salary*0.3, 0) Ư�����ʽ�
from employee
order by dept_code;

--case 
--decode���� �� ������ �б����� ������ �� ����Ѵ�.
select emp_name,
    case
        when substr(emp_no,8,1) in (1,3) then '��'
        when substr(emp_no,8,1) in (2,4) then '��'
        else '�ܰ���'
    end ����
from employee;

select * from employee;
select emp_id, emp_name,
    case
        when substr(emp_no,1,2)>=80 then '80����'
        when substr(emp_no,1,2)>=70 then '70����'
        when substr(emp_no,1,2)>=60 then '60����'
    end ���̴�
from employee
order by emp_no;

--quiz02
select emp_name,
ceil(months_between(sysdate,hire_date)/12) ����,
case
        when ceil(months_between(sysdate,hire_date)/12) >=20 then 'Senior'
        when ceil(months_between(sysdate,hire_date)/12) >=10 then 'Intermediate'
        when ceil(months_between(sysdate,hire_date)/12) >=0 then 'Junior'
end ���޷���
from employee
order by ����;


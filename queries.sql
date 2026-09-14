-- Analytical queries against the university database.
-- Grouped by the SQL technique each one demonstrates.

-- 1. JOIN — instructor roster with department building
select i.ID, i.name, i.dept_name, d.building, i.salary
from instructor i
join department d on i.dept_name = d.dept_name
order by i.dept_name, i.name;

-- 2. AGGREGATE + GROUP BY — average instructor salary per department
select dept_name, count(*) as num_instructors, round(avg(salary), 2) as avg_salary
from instructor
group by dept_name
order by avg_salary desc;

-- 3. GROUP BY + HAVING — students taking more than one course in Fall 2023
select t.ID, s.name, count(*) as courses_taken
from takes t
join student s on s.ID = t.ID
where t.semester = 'Fall' and t.year = 2023
group by t.ID, s.name
having count(*) > 1;

-- 4. MULTI-TABLE JOIN — full class list with course title, instructor, and room
select c.title, sec.semester, sec.year, s.name as student_name, i.name as instructor_name,
       sec.building, sec.room_number
from takes t
join section sec on (t.course_id, t.sec_id, t.semester, t.year)
                   = (sec.course_id, sec.sec_id, sec.semester, sec.year)
join course c on c.course_id = sec.course_id
join student s on s.ID = t.ID
join teaches te on (te.course_id, te.sec_id, te.semester, te.year)
                  = (sec.course_id, sec.sec_id, sec.semester, sec.year)
join instructor i on i.ID = te.ID
order by c.title, s.name;

-- 5. SUBQUERY — departments with an above-average budget
select dept_name, budget
from department
where budget > (select avg(budget) from department)
order by budget desc;

-- 6. LEFT JOIN + NULL check — instructors not currently teaching a section
select i.ID, i.name, i.dept_name
from instructor i
left join teaches t on t.ID = i.ID
where t.ID is null;

-- 7. Correlated subquery — students with more total credits than their department's average
select s.ID, s.name, s.dept_name, s.tot_cred
from student s
where s.tot_cred > (
	select avg(tot_cred) from student s2 where s2.dept_name = s.dept_name
)
order by s.dept_name, s.tot_cred desc;

-- 8. VIEW — reusable student transcript (course, grade, credits)
drop view if exists student_transcript;
create view student_transcript as
select t.ID as student_id, s.name as student_name, c.course_id, c.title, c.credits,
       t.semester, t.year, t.grade
from takes t
join student s on s.ID = t.ID
join course c on c.course_id = t.course_id;

select * from student_transcript where student_id = '00128';

-- 9. WINDOW FUNCTION — rank students by total credits within their department
select ID, name, dept_name, tot_cred,
       rank() over (partition by dept_name order by tot_cred desc) as credit_rank
from student
order by dept_name, credit_rank;

-- 10. Section headcount — how many students are enrolled per section
select sec.course_id, sec.sec_id, sec.semester, sec.year, count(t.ID) as enrolled
from section sec
left join takes t on (t.course_id, t.sec_id, t.semester, t.year)
                    = (sec.course_id, sec.sec_id, sec.semester, sec.year)
group by sec.course_id, sec.sec_id, sec.semester, sec.year
order by enrolled desc;

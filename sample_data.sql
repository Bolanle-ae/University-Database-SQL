-- Sample data for the university database.
-- Load after schema.sql. Respects every FK and CHECK constraint in that file.

insert into department (dept_name, building, budget) values
	('Comp. Sci.', 'Taylor', 100000.00),
	('Physics', 'Watson', 70000.00),
	('Elec. Eng.', 'Taylor', 85000.00),
	('Finance', 'Painter', 120000.00);

insert into instructor (ID, name, dept_name, salary) values
	('10101', 'Srinivasan', 'Comp. Sci.', 65000.00),
	('12121', 'Wu', 'Finance', 90000.00),
	('22222', 'Einstein', 'Physics', 95000.00),
	('33456', 'Gold', 'Physics', 87000.00),
	('45565', 'Katz', 'Comp. Sci.', 75000.00),
	('76543', 'Singh', 'Finance', 80000.00),
	('76766', 'Crick', 'Elec. Eng.', 72000.00),
	('83821', 'Brandt', 'Comp. Sci.', 92000.00),
	('98345', 'Kim', 'Elec. Eng.', 68000.00);

insert into student (ID, name, dept_name, tot_cred) values
	('00128', 'Zhang', 'Comp. Sci.', 102),
	('12345', 'Shankar', 'Comp. Sci.', 32),
	('19991', 'Brandt', 'Elec. Eng.', 80),
	('23121', 'Chavez', 'Finance', 110),
	('44553', 'Peltier', 'Physics', 56),
	('45678', 'Levy', 'Physics', 46),
	('54321', 'Williams', 'Comp. Sci.', 54),
	('55739', 'Sanchez', 'Elec. Eng.', 38),
	('70557', 'Snow', 'Physics', 0),
	('76653', 'Aoi', 'Elec. Eng.', 60),
	('98765', 'Bourikas', 'Elec. Eng.', 98),
	('98988', 'Tanaka', 'Finance', 120);

insert into classroom (building, room_number, capacity) values
	('Packard', '101', 500),
	('Painter', '514', 10),
	('Taylor', '3128', 70),
	('Watson', '100', 30),
	('Watson', '120', 50);

insert into course (course_id, title, dept_name, credits) values
	('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4),
	('CS-190', 'Game Design', 'Comp. Sci.', 4),
	('CS-315', 'Robotics', 'Comp. Sci.', 3),
	('CS-347', 'Database System Concepts', 'Comp. Sci.', 3),
	('FIN-201', 'Investment Banking', 'Finance', 3),
	('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3),
	('PHY-101', 'Physical Principles', 'Physics', 4);

insert into section (course_id, sec_id, semester, year, building, room_number, time_slot_id) values
	('CS-101', '1', 'Fall', 2023, 'Packard', '101', 'H'),
	('CS-190', '1', 'Spring', 2024, 'Taylor', '3128', 'C'),
	('CS-315', '1', 'Spring', 2024, 'Watson', '120', 'B'),
	('CS-347', '1', 'Fall', 2023, 'Taylor', '3128', 'A'),
	('FIN-201', '1', 'Fall', 2023, 'Painter', '514', 'B'),
	('EE-181', '1', 'Spring', 2024, 'Watson', '100', 'C'),
	('PHY-101', '1', 'Fall', 2023, 'Watson', '100', 'A');

insert into teaches (ID, course_id, sec_id, semester, year) values
	('10101', 'CS-347', '1', 'Fall', 2023),
	('45565', 'CS-101', '1', 'Fall', 2023),
	('83821', 'CS-190', '1', 'Spring', 2024),
	('83821', 'CS-315', '1', 'Spring', 2024),
	('76543', 'FIN-201', '1', 'Fall', 2023),
	('76766', 'EE-181', '1', 'Spring', 2024),
	('22222', 'PHY-101', '1', 'Fall', 2023);

insert into takes (ID, course_id, sec_id, semester, year, grade) values
	('00128', 'CS-101', '1', 'Fall', 2023, 'A'),
	('00128', 'CS-347', '1', 'Fall', 2023, 'A-'),
	('12345', 'CS-101', '1', 'Fall', 2023, 'C'),
	('12345', 'CS-190', '1', 'Spring', 2024, 'A'),
	('23121', 'FIN-201', '1', 'Fall', 2023, 'A'),
	('44553', 'PHY-101', '1', 'Fall', 2023, 'B-'),
	('45678', 'PHY-101', '1', 'Fall', 2023, 'B+'),
	('54321', 'CS-101', '1', 'Fall', 2023, 'A-'),
	('54321', 'CS-347', '1', 'Fall', 2023, 'B+'),
	('55739', 'EE-181', '1', 'Spring', 2024, 'B'),
	('76653', 'EE-181', '1', 'Spring', 2024, 'C+'),
	('98765', 'EE-181', '1', 'Spring', 2024, 'A-'),
	('98988', 'FIN-201', '1', 'Fall', 2023, 'A-');

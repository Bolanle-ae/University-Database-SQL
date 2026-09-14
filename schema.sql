-- University Database schema
-- Classic relational design: departments, instructors, students, courses,
-- sections, and the many-to-many links between people and sections.

create table if not exists classroom(
	building varchar(15) not null,
	room_number varchar(7) not null,
	capacity integer not null,
	primary key (building, room_number)
);

create table if not exists department(
	dept_name varchar (20) not null,
	building varchar (15) not null,
	budget numeric (12,2) not null check (budget > 0),
	primary key (dept_name)
);

create table if not exists instructor(
	ID char(5) not null,
	name varchar(20) not null,
	dept_name varchar(20) not null,
	salary numeric(8,2) not null,
	primary key(ID),
	foreign key (dept_name) references department
);

create table if not exists student(
	ID varchar(5) not null,
	name varchar(20) not null,
	dept_name varchar(20) not null,
	tot_cred numeric(3,0) not null check (tot_cred >= 0),
	primary key (ID),
	foreign key (dept_name) references department on delete set null
);

create table if not exists course(
	course_id varchar(7) not null,
	title varchar(50) not null,
	dept_name varchar(20) not null,
	credits numeric(2,0) check (credits > 0),
	primary key (course_id),
	foreign key (dept_name) references department on delete set null
);

create table if not exists section(
	course_id varchar(8) not null,
	sec_id varchar(8) not null,
	semester varchar(6) not null check (semester in ('Fall', 'Winter', 'Spring', 'Summer')),
	year numeric(4,0)  not null check (year > 1701 and year < 2100),
	building varchar(15) not null,
	room_number varchar(7) not null,
	time_slot_id varchar(4) not null,
	primary key (course_id, sec_id, semester, year),
	foreign key (course_id) references course on delete cascade,
	foreign key (building, room_number) references classroom on delete set null
);

create table if not exists teaches(
	ID varchar(5) not null,
	course_id varchar(8) not null,
	sec_id varchar(8) not null,
	semester varchar(6) not null,
	year numeric(4,0) not null,
	primary key (ID, course_id, sec_id, semester, year),
	foreign key (course_id, sec_id, semester, year) references section on delete cascade,
	foreign key (ID) references instructor on delete cascade
);

create table if not exists takes(
	ID varchar(5) not null,
	course_id varchar(8) not null,
	sec_id varchar(8) not null,
	semester varchar(6) not null,
	year numeric(4,0) not null,
	grade varchar(2),
	primary key (ID, course_id, sec_id, semester, year),
	foreign key (course_id, sec_id, semester, year) references section on delete cascade,
	foreign key (ID) references student on delete cascade
);

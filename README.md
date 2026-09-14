# University Database (SQL)

A relational database for a university: departments, instructors, students,
courses, sections, and the enrollment/teaching links between them. Built to
show core SQL skills end to end — schema design with constraints, sample
data, and a range of analytical queries.

## Schema

8 tables, normalized around composite keys for scheduling data:

- `department` — name, building, budget
- `instructor` / `student` — each tied to a `department`
- `classroom` — building + room, with capacity
- `course` — offered by a department
- `section` — a specific offering of a course (semester/year/room/time slot)
- `teaches` — instructor ↔ section
- `takes` — student ↔ section, with grade

Constraints enforced in the DDL: department budgets and course credits must
be positive, `section.semester` is restricted to an enum-style check, and
foreign keys cascade or null out on delete where it makes sense (e.g.
dropping a course cascades to its sections; dropping a department just
detaches its students rather than deleting them).

Entity relationships:

```
department 1---* instructor
department 1---* student
department 1---* course
classroom  1---* section
course     1---* section
section    1---* teaches *---1 instructor
section    1---* takes   *---1 student
```

## Files

| File | Purpose |
|---|---|
| `schema.sql` | DDL — run first |
| `sample_data.sql` | Realistic seed data respecting every constraint |
| `queries.sql` | 10 queries: joins, aggregation, subqueries, a view, a window function |

## Running it

Works on PostgreSQL, MySQL 8+, or SQLite (tested against SQLite):

```bash
sqlite3 university.db < schema.sql
sqlite3 university.db < sample_data.sql
sqlite3 university.db < queries.sql
```

## Query highlights (`queries.sql`)

1. Instructor roster joined to department building
2. Average salary per department
3. Students taking more than one course in a semester (`GROUP BY … HAVING`)
4. Full class list joining five tables at once
5. Departments with above-average budget (subquery)
6. Instructors not currently teaching anything (`LEFT JOIN` + `NULL` check)
7. Students above their department's average credit load (correlated subquery)
8. `student_transcript` view — per-student course/grade history
9. Students ranked by credits within department (`RANK() OVER (PARTITION BY …)`)
10. Enrollment headcount per section

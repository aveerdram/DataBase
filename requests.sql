-- 1. Модификация таблицы добавлением какого-либо атрибута.
-- Добавим в отношение 'Teacher' атрибут 'rating' - рэйтинг.

alter table Teacher add column rating smallint check (rating in (0, 1, 2, 3, 4, 5));

update Teacher set rating = 5 where teacher.id = 36;
update Teacher set rating = 5 where teacher.id = 37;
update Teacher set rating = 4 where teacher.id = 38;
update Teacher set rating = 4 where teacher.id = 39;
update Teacher set rating = 3 where teacher.id = 40;
update Teacher set rating = 5 where teacher.id = 41;
update Teacher set rating = 4 where teacher.id = 42;
update Teacher set rating = 2 where teacher.id = 43;
update Teacher set rating = 0 where teacher.id = 44;

select * from teacher;


-- 2. Выборка всех данных из таблицы.
-- Выведем отношение 'VeryExam'

select * from VeryExam;


-- 3. Выборка различных значений какого-либо столбца таблицы.
-- Выведем атрибут 'форма сдачи' в отношении StudyPlan.

select distinct(form_of_passing_ID) from StudyPlan;


-- 4. Выборка строк таблицы, где значения какого-либо 
-- атрибута принадлежат заданному диапазону.
-- Выведем те значения из отношения 'StudyPlan', форма сдачи которого - зачёт.

select * from StudyPlan where (studyplan.form_of_passing_id >= 3);


-- 5. Выборка строк таблицы, где значения какого-либо 
-- атрибута принадлежат заданному набору значений.
-- Выведем те строки таблицы TeacherDepartment, где 
-- кафедры - кафедры педагогики с двух факультетов.

select * from TeacherDepartment where (TeacherDepartment.department_id in (5, 8));


-- 6. Выборка строк таблицы, где значения какого-либо 
-- атрибута соответствуют заданному шаблону.
-- Выведем людей с фамилией, начинающейся на букву А.

select name from People where people.name LIKE 'А%';


-- 7. Выборка строк таблицы, где значения какого-либо атрибута не пусто.
-- Выведем строки таблицы Teacher.

select * from Teacher where teacher.degree_id is not null;


-- 8. Сортировка строк таблицы по двум ключам сортировки.
-- Просортируем таблицу связи 'специальность - факультет' по атрибутам id факультета и id специальности.

select specfac.faculty_id, specfac.specialty_id from SpecFac order by (specfac.faculty_id, specfac.specialty_id);


-- Просортируем таблицу связи Team по атрибутам id факультета и id специальности.

select team.form_of_education_id, team.type_of_eduation_id from Team order by (team.form_of_education_id, team.type_of_eduation_id);


-- 9. Внутреннее (естественное) соединение таблиц.
-- Объеденим таблицы 'Факультет' и таблицу связи 'Факультет - Специальность'.

select * from SpecFac natural join Faculty;


-- Объеденим таблицы 'Группа' и таблицу связи 'Факультет - Специальность'.

select specfac_ID, faculty_ID, specialty_ID, year_of_admission from Team natural join SpecFac;


-- 10. Правое соединение таблиц.
-- Объеденим таблицы 'предмет' и таблицу связи 'группа - предмет'.

select * from TeamSubject right outer join Team on (teamsubject.subject_id = team.id);


-- 11. Левое соединение таблиц.
-- Объеденим таблицы StudyPlan и таблицу 'форма сдачи предмета'

select studyplan.id, form_of_passing.name from StudyPlan left outer join Form_of_passing on (StudyPlan.form_of_passing_ID = Form_of_passing.id);


-- 12. Объединение двух таблиц.
-- Объеденим таблицу связи 'Study plan - Teacher Department', таблицу Studyplan и TeacherDepartment.

select studyplan.id, pass.studyplan_ID, pass.teacherdepartment_ID, teacherdepartment.id
from Studyplan
inner join Pass on (pass.studyplan_ID = studyplan.id)
inner join TeacherDepartment on (pass.teacherdepartment_ID = teacherdepartment.id);


-- 13. Группировка записей по двум или более полям.
-- Вывести название факультета и кол-во различных специальностей на них.

select count(specialty.name), faculty.name
from specialty
inner join specfac ON (specfac.specialty_id = specialty.id)
inner join faculty on (specfac.faculty_id = faculty.id)
group by  faculty.name;


-- 14. Вложенный подзапрос.
-- Выведем информацию о тех, студентах, кто сдал предметы на оценку с индексом 3.

select * from student 
where student.id in (select VeryExam.student_id from VeryExam where veryexam.type_of_mark_ID = 3);


-- 15. Создание представлений.
-- Создадим представление 'лист двоешников' по прошлому запросу.

create view my_view as select * from student 
where student.id in (select VeryExam.student_id from VeryExam where veryexam.type_of_mark_ID = 3);

select * from my_view;
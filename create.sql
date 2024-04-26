-- создание "маленьких" отношений

CREATE TABLE Faculty -- Факультет
(
id smallserial primary key,
name varchar(30) not null unique
);

INSERT INTO Faculty (name) VALUES 
('Механико-математический'),
('КНиИт');

select * from faculty;


CREATE TABLE Specialty -- Специальность
(
id smallserial primary key,
name varchar(30) not null unique
);

INSERT INTO Specialty VALUES
(11, 'МиКН'),
(12, 'ПМИ'),
(13, 'ПедОбраз'),
(21, 'ФИиИТ'),
(22, 'ИиВТ');

select * from specialty;


CREATE TABLE Form_of_education -- Форма обучения
(
id smallserial primary key,
name varchar(30) not null unique
);

INSERT INTO Form_of_education (name) VALUES
('Очная'),
('Заочная'),
('Очно-заочная');

select * from form_of_education;


CREATE TABLE Type_of_education -- Тип образования
(
id smallserial primary key,
name varchar(30) not null check (name in ('Бакалавриат', 'Магистратура'))
);

INSERT INTO Type_of_education (name) VALUES
('Бакалавриат'),
('Магистратура');

select * from type_of_education;


CREATE TABLE TPosition -- Должность
(
id smallserial primary key,
name varchar(30) not null unique
);

INSERT INTO TPosition (name) VALUES
('Лаборант'),
('Старший преподаватель'),
('Доцент'),
('Профессор'),
('Завкафедрой'),
('Декан'),
('Ректор');

select * from tposition;


CREATE TABLE Degree -- Степень
(
id smallserial primary key,
name varchar(40) not null unique
);

INSERT INTO Degree (name) VALUES
('Кандидат физико-математических наук'),
('Доктор физико-математических наук наук'),
('Кандидат педагогических наук'),
('Доктор педагогических наук');

select * from degree;


CREATE TABLE Form_of_passing -- Форма сдачи
(
id smallserial primary key,
name varchar(30) not null unique check (name in ('Зачёт', 'Зачёт с оценкой', 'Экзамен'))
);

INSERT INTO Form_of_passing (name) VALUES
('Зачёт'),
('Зачёт с оценкой'),
('Экзамен');

select * from form_of_passing;


CREATE TABLE Type_of_mark -- Вид оценки
(
id smallserial primary key,
name varchar(30) not null unique check (name in ('Неявка', 'Не зачтено', 'Зачтено', 'Неудовлетворительно', 'Удовлетворительно', 'Хорошо', 'Отлично'))
);

INSERT INTO Type_of_mark (name) VALUES
('Неявка'),
('Не зачтено'),
('Неудовлетворительно'),
('Удовлетворительно'),
('Хорошо'),
('Отлично'),
('Зачтено');

select * from type_of_mark;


CREATE TABLE Subject -- Предмет
(
id smallserial primary key,
name varchar(40) not null unique
);

INSERT INTO Subject (name) VALUES
('Алгебра'),
('Математический анализ'),
('Базы данных'),
('Стохастический анализ'),
('Информатика'),
('Информационные системы и технологии'),
('Педагогика'),
('Языки программирования');

select * from subject;

-- создание остальных отношений

CREATE TABLE SpecFac -- Таблица связи "специальность - факультет"
( 
id smallserial primary key,
faculty_ID smallint references Faculty (id) on delete set null,
specialty_ID smallint references Specialty (id) on delete set null,
unique (faculty_ID, specialty_ID)
);

INSERT INTO SpecFac (faculty_ID, specialty_ID) VALUES
(1, 11),
(1, 12),
(1, 13),
(2, 21),
(2, 13);

select * from SpecFac;


CREATE TABLE Department -- Кафедра
(
id smallserial primary key,
name varchar(30) not null,
faculty_ID smallint references Faculty (id) on delete set null,
unique (name, faculty_ID)
);

INSERT INTO Department (name, faculty_ID) VALUES
('КАиТЧ', 1),
('Мат. анализа', 1),
('МиКМ', 1),
('ТФиСА', 1),
('Кафедра педагогики', 1),
('ИиП', 2),
('ДМиИТ', 2),
('Кафедра педагогики', 2),
('МКиКН', 2);

select * from department;


CREATE TABLE Team -- Группа
(
id smallserial primary key,
specfac_ID smallint references specfac (id) on delete set null,
form_of_education_ID smallint references form_of_education (id) on delete set null,
type_of_eduation_ID smallint references type_of_education (id) on delete set null,
year_of_admission smallint  not null check (year_of_admission >= 1990 and year_of_admission <= 2090),
unique (specfac_ID, form_of_education_ID, type_of_eduation_ID, year_of_admission) -- вроде они все между собой должны быть уникальны
);

INSERT INTO Team (specfac_ID, form_of_education_ID, type_of_eduation_ID, year_of_admission) VALUES
(1, 1, 1, 2019),
(2, 1, 2, 2020),
(3, 2, 2, 2022),
(4, 3, 1, 2020),
(5, 2, 2, 2022),
(1, 2, 1, 2022);

select * from team;


CREATE TABLE People 
(
id integer primary key,
name varchar(50) not null,
phone varchar(12) unique check (phone ~ '^[0-9 ]*$'),
date_of_birth date 
);

INSERT INTO People VALUES
(1, 'Мардеева Александра Рустамовна', '89020401354', '2002-04-30'), -- бак 2019 + (1)
(2, 'Юнев Ярослав Евгеньевич', '88454529873', '2002-01-23'),
(3, 'Абрамова Майя Матвеевна', '89273470813', '2002-10-25'),
(4, 'Агеева Алиса Вячеславовна', '89272384840', '2001-04-24'),
(5, 'Галкина София Глебовна', '89064862372', '2001-08-23'),
(6, 'Горбунов Леонид Даниилович', '89279246210', '2001-08-04'),
(7, 'Гришин Андрей Кириллович', '89275696023', '2002-12-13'),
(8, 'Леонова Ева Данииловна', '86194847397', '2005-07-20'), -- бак 2022 + (6)
(9, 'Новикова Ева Романовна', '89273815063', '2005-08-20'),
(10, 'Сальников Артём Тимофеевич', '89278761867', '2005-11-17'),
(11, 'Сорокин Олег Львович', '80577576669', '2005-08-02'),
(12, 'Суслов Кирилл Андреевич', '89272613947', '2005-03-17'),
(13, 'Тимофеев Константин Тимофеевич', '89273207189', '2005-04-08'),
(14, 'Алехина Амалия Георгиевна', '89277008648', '2005-02-10'),
(15, 'Гусев Юрий Леонидович', '81791460045', '2003-12-21'), -- бак 2020 (4)
(16, 'Изимов Николай Тарасович', '89270679153', '2003-09-20'),
(17, 'Нечаева Александра Евгеньевна', '89276162004', '2003-04-22'),
(18, 'Осипова Вероника Артёмовна', '89276307922', '2002-09-27'),
(19, 'Зимина Яна Константиновна', '89278977885', '2002-12-13'),
(20, 'Галкин Илья Тимурович', '84957551602', '2002-08-21'),
(21, 'Лапшин Сергей Артёмович', '89272953006', '2003-04-07'), -- маг 2022 + (3)
(22, 'Кузнецова Алиса Мироновна', '89273743062', '2001-05-19'),
(23, 'Виноградов Константин Даниилович', '81306964820', '2000-09-02'),
(24, 'Некрасов Георгий Янович', '84417673706', '2000-11-15'),
(25, 'Седов Леонид Григорьевич', '89279129296', '2001-11-28'),
(26, 'Бочаров Ярослав Владиславович', '89276186716', '2000-08-10'),
(27, 'Жилин Максим Алиевич', '89270235522', '2001-12-17'),
(28, 'Максимова Елизавета Леонидовна', '89270126148', '1999-09-06'), -- маг 2020 + (2)
(29, 'Дементьев Кирилл Маркович', '89276579232', '1999-07-31'),
(30, 'Смирнов Иван Матвеевич', '89274238728', '1999-01-08'),
(31, 'Малышева Мария Максимовна', '88536546528', '1999-01-27'),
(32, 'Чистяков Илья Артёмович', '89275694592', '1998-10-06'),
(33, 'Воронин Глеб Артемьевич', '89270469366', '1998-03-03'),
(34, 'Румянцева София Михайловна', '89271236348', '1998-10-22'),
(35, 'Котова Варвара Демидовна', '89276631098', '1999-08-24'),
(36, 'Крылова Екатерина Юрьевна', '88452546480', '1984-08-12'), -- преподы
(37, 'Плаксина Ирина Владимировна', '88452808451', '1984-12-08'),
(38, 'Агафонова Нина Юрьевна', '88452515532', '1973-07-28'),
(39, 'Осипцев Михаил Анатольевич', '88452515537', '1971-02-24'),
(40, 'Кривобок Валерий Викторович', '88452515539', '1981-06-12'),
(41, 'Лебедева Светлана Владимировна', '88452525694', '1968-10-31'),
(42, 'Кальянов Леонтий Вениаминович', '88452618480', '1979-11-15'),
(43, 'Байтаков Жаслан Рашидович', '88452525309', '1977-06-30'),
(44, 'Сафрончик Мария Ильинична', '88452525699', '1974-04-05'),
(45, 'Кузин Дмитрий Александрович', '88582518480', '2000-08-09'), -- маг 2022 + (5)
(46, 'Титов Глеб Васильевич', '88452808751', '1999-03-06'),
(47, 'Королева Арина Тимофеевна', '88452515432', '2000-10-22'),
(48, 'Богомолова Валерия Львовна', '87452515537', '1999-12-02'),
(49, 'Ларионов Артём Владимирович', '88452516539', '1999-10-14'),
(50, 'Яковлев Николай Михайлович', '88466625694', '2000-02-23'),
(51, 'Александрова Софья Сергеевна', '89452518480', '1999-01-29'),
(52, 'Киселева Эмилия Кирилловна', '88458525309', '1999-11-15'),
(53, 'Зайцева Маргарита Данииловна', '88038725699', '2000-05-20');

select * from people;


CREATE TABLE Student -- Студент
(
id smallint references people (id) primary key,
team_ID smallint references team (id) on delete set null,
student_card varchar(8) unique check (student_card ~ '^[0-9 ]*$')
);

INSERT INTO Student VALUES
(1, 1, 22273097),
(2, 1, 99005407),
(3, 1, 95659287),
(4, 1, 24708144),
(5, 1, 41096959),
(6, 1, 39436439),
(7, 1, 33292003),
(8, 6, 58787958),
(9, 6, 65964108),
(10, 6, 23502227),
(11, 6, 27350525),
(12, 6, 92203488),
(13, 6, 81808802),
(14, 6, 85318002),
(15, 4, 21063444),
(16, 4, 88016036),
(17, 4, 90750341),
(18, 4, 55871278),
(19, 4, 61937291),
(20, 4, 47678500),
(21, 3, 61090750),
(22, 3, 80172921),
(23, 3, 37792050),
(24, 3, 50966834),
(25, 3, 15042245),
(26, 3, 84303511),
(27, 3, 30478022),
(28, 2, 22853683),
(29, 2, 57419289),
(30, 2, 64003441),
(31, 2, 59441506),
(32, 2, 74723155),
(33, 2, 29138745),
(34, 2, 52107062),
(35, 2, 35952113),
(45, 5, 28677903),
(46, 5, 58635490),
(47, 5, 57662657),
(48, 5, 59279764),
(49, 5, 22294630),
(50, 5, 79690469),
(51, 5, 28730179),
(52, 5, 81804682),
(53, 5, 74748018);

select * from student;


CREATE TABLE Teacher -- Преподаватель
(
id smallint references people (id) primary key,
tposition_ID smallint references tposition (id) on delete set null,
degree_ID smallint references degree (id) on delete set null,
date_of_hiring date 
);

INSERT INTO Teacher VALUES
(36, 7, 2, '2014-08-26'),
(37, 6, 3, '2006-09-15'),
(38, 4, 1, '1995-12-27'),
(39, 5, 2, '1996-10-07'),
(40, 3, 1, '2003-04-30'),
(41, 2, 4, '1993-02-09'),
(42, 4, 1, '1983-01-30'),
(43, 3, 3, '1998-08-24'),
(44, 1, null, '2003-05-06');

select * from teacher;


CREATE TABLE TeacherDepartment -- Таблица связи 'преподаватель - кафедра'
(
id smallserial primary key,
department_ID smallint references department (id) on delete set null,
teacher_ID smallint references teacher (id) on delete set null
);

INSERT INTO TeacherDepartment (department_ID, teacher_ID) VALUES
(3, 36),
(5, 37),
(4, 38),
(2, 39),
(1, 40),
(5, 41),
(7, 42),
(8, 43),
(9, 44);

select * from TeacherDepartment;


CREATE TABLE TeamSubject -- Таблица связи 'группа - предмет'
(
id smallserial primary key,
team_ID smallint references team (id) on delete set null,
subject_ID smallint references subject (id) on delete set null,
unique (team_ID, subject_ID)
);

INSERT INTO TeamSubject (team_ID, subject_ID) VALUES
(1, 2),
(1, 5),
(2, 1),
(2, 3),
(3, 4),
(3, 7),
(4, 6),
(4, 8),
(5, 3),
(5, 7),
(6, 4),
(6, 8);

select * from TeamSubject;


CREATE TABLE StudyPlan -- Учебный план
(
id smallserial primary key,
teamsubject_ID smallint references teamsubject (id) on delete set null,
form_of_passing_ID smallint references form_of_passing (id) on delete set null,
hours smallint check (hours in (72, 108, 144, 103, 256)),
semester smallint check (semester >= 1 and semester <= 12)
);

INSERT INTO StudyPlan (teamsubject_ID, form_of_passing_ID, hours, semester) VALUES
(1, 3, 144, 7),
(2, 3, 108, 7),
(3, 1, 72, 12),
(4, 3, 103, 12),
(5, 2, 144, 9),
(6, 3, 256, 9),
(7, 1, 72, 5),
(8, 2, 108, 5),
(9, 1, 72, 9),
(10, 2, 144, 9),
(11, 2, 256, 1),
(12, 1, 72, 1);

select * from StudyPlan;


CREATE TABLE Pass -- Какой преподаватель какой предмет ведёт
(
id smallserial primary key,
studyplan_ID smallint references studyplan (id) on delete set null,
teacherdepartment_ID smallint references teacherdepartment (id) on delete set null
);

INSERT INTO Pass (studyplan_ID, teacherdepartment_ID) VALUES
(1, 4),
(2, 7),
(3, 5),
(4, 1),
(5, 3),
(6, 6),
(7, 7),
(8, 9),
(9, 2),
(10, 8),
(11, 3),
(12, 9);

select * from Pass;


CREATE TABLE VeryExam -- Сама сдача предмета
(
id smallserial primary key,
pass_ID smallint references pass (id) on delete set null,
student_id smallint references student (id) on delete set null,
type_of_mark_ID smallint references type_of_mark (id) on delete set null,
date_of_passing date,
unique (pass_ID, student_ID)
);

INSERT INTO VeryExam (pass_ID, student_id, type_of_mark_ID, date_of_passing) VALUES
(1, 1, 6, '2022-12-29'),
(1, 2, 5, '2022-12-29'),
(1, 3, 3, '2022-12-29'),
(1, 4, 1, '2022-12-29'),
(1, 5, 6, '2022-12-29'),
(1, 6, 4, '2022-12-29'),
(1, 7, 4, '2022-12-29'),
(2, 1, 5, '2022-12-25'),
(2, 2, 4, '2022-12-25'),
(2, 3, 4, '2022-12-25'),
(2, 4, 1, '2022-12-25'),
(2, 5, 5, '2022-12-25'),
(2, 6, 3, '2022-12-25'),
(2, 7, 6, '2022-12-25'),
(3, 28, 7, '2022-12-29'),
(3, 29, 7, '2022-12-29'),
(3, 30, 2, '2022-12-29'),
(3, 31, 7, '2022-12-29'),
(3, 32, 7, '2022-12-29'),
(3, 34, 7, '2022-12-29'),
(3, 35, 1, '2022-12-29'),
(4, 28, 6, '2023-01-14'),
(4, 29, 6, '2023-01-14'),
(4, 30, 5, '2023-01-14'),
(4, 31, 4, '2023-01-14'),
(4, 32, 4, '2023-01-14'),
(4, 34, 6, '2023-01-14'),
(4, 35, 5, '2023-01-14'),
(5, 21, 3, '2023-01-12'),
(5, 22, 1, '2023-01-12'),
(5, 23, 5, '2023-01-12'),
(5, 24, 4, '2023-01-12'),
(5, 25, 4, '2023-01-12'),
(5, 26, 5, '2023-01-12'),
(5, 27, 6, '2023-01-12'),
(6, 21, 5, '2023-01-16'),
(6, 22, 3, '2023-01-16'),
(6, 23, 4, '2023-01-16'),
(6, 24, 6, '2023-01-16'),
(6, 25, 6, '2023-01-16'),
(6, 26, 3, '2023-01-16'),
(6, 27, 4, '2023-01-16'),
(7, 15, 7, '2022-12-26'),
(7, 16, 7, '2022-12-26'),
(7, 17, 7, '2022-12-26'),
(7, 18, 7, '2022-12-26'),
(7, 19, 7, '2022-12-26'),
(7, 20, 7, '2022-12-26'),
(8, 15, 6, '2022-12-29'),
(8, 16, 5, '2022-12-29'),
(8, 17, 5, '2022-12-29'),
(8, 18, 5, '2022-12-29'),
(8, 19, 6, '2022-12-29'),
(8, 20, 4, '2022-12-29'),
(9, 45, 7, '2022-12-23'),
(9, 46, 7, '2022-12-23'),
(9, 47, 1, '2022-12-23'),
(9, 48, 2, '2022-12-23'),
(9, 49, 7, '2022-12-23'),
(9, 50, 7, '2022-12-23'),
(9, 51, 7, '2022-12-23'),
(9, 52, 7, '2022-12-23'),
(9, 53, 2, '2022-12-23'),
(10, 45, 6, '2022-12-23'),
(10, 46, 6, '2022-12-23'),
(10, 47, 1, '2022-12-23'),
(10, 48, 3, '2022-12-23'),
(10, 49, 5, '2022-12-23'),
(10, 50, 5, '2022-12-23'),
(10, 51, 4, '2022-12-23'),
(10, 52, 4, '2022-12-23'),
(10, 53, 3, '2022-12-23'),
(11, 8, 6, '2023-01-12'),
(11, 9, 5, '2023-01-12'),
(11, 10, 4, '2023-01-12'),
(11, 11, 6, '2023-01-12'),
(11, 12, 6, '2023-01-12'),
(11, 13, 4, '2023-01-12'),
(11, 14, 5, '2023-01-12'),
(12, 8, 7, '2023-01-12'),
(12, 9, 7, '2023-01-12'),
(12, 10, 7, '2023-01-12'),
(12, 11, 1, '2023-01-12'),
(12, 12, 2, '2023-01-12'),
(12, 13, 7, '2023-01-12'),
(12, 14, 7, '2023-01-12');

select * from VeryExam;
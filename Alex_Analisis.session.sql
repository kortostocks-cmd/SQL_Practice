-- En SQLite no se usa CREATE DATABASE. 
-- Tu base de datos es el archivo .db que creaste en SQLTools.

-- Borramos las tablas si ya existen para empezar de cero
DROP TABLE IF EXISTS employee_demographics;
DROP TABLE IF EXISTS employee_salary;
DROP TABLE IF EXISTS parks_departments;

-- Crear tabla Demographics
CREATE TABLE employee_demographics (
  employee_id INTEGER PRIMARY KEY, -- En SQLite usamos INTEGER PRIMARY KEY para que sea autoincremental
  first_name TEXT,
  last_name TEXT,
  age INTEGER,
  gender TEXT,
  birth_date TEXT -- SQLite no tiene tipo DATE, usa TEXT en formato YYYY-MM-DD
);

-- Crear tabla Salary
CREATE TABLE employee_salary (
  employee_id INTEGER,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  occupation TEXT,
  salary INTEGER,
  dept_id INTEGER
);

-- Crear tabla Departments
CREATE TABLE parks_departments (
  department_id INTEGER PRIMARY KEY AUTOINCREMENT, -- Ajuste para SQLite
  department_name TEXT NOT NULL
);

-- Insertar Datos
INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);

INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');


#STORED PROCEDURE

CREATE PROCEDURE  large_salaraies()
BEGIN
  SELECT *
    FROM employee_salary
    WHERE salary >= 50000;

CALL o EXEC parks_department.large_salaries() llama todas las que tenga mas de 50000 de salrio
# CREA UNA FUNCION COMO UN BOTON


# USANDO DELIMITER $$ = {}

DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
  SELECT *
  FROM employe_salary;
  WHERE salary >= 50000
  SELECT *
  FROM employe_salary;
  WHERE salary >= 10000;
END $$ 

CALL large_slaries2()


CREATE VIEW grandes_salarios AS
SELECT * FROM employee_salary WHERE salary >= 50000;

--PARA LLAMAR
SELECT * FROM grandes_salarios
-- Y si quieres connectar tienes que usar Attach database por ejemplo

-- PARAMETROS EN SQL
DELIMITER $$
CREATE PROCEDURE large_salaries4(parametro INT)
BEGIN
  SELECT salary
  FROM employe_salary;
  WHERE employee_id = parametro
END $$ 

CALL large_salaries(1) -- primer id muestra su salario

-- TRIGGERS AND EVENTS
--CUANDO MIS EMPLEADOS EN DEMO SE PONGAN TAMBIEN EN EMPLOYEE SALARY QUE SE PONGA
SELECT * 
FROM employee_demographics;

SELECT * 
FROM employee_salary

DELIMITER $$

CREATE TRIGGER employee_insert
  AFTER INSERT ON employee_salary
  FRO EACH ROW
BEGIN
  INSERT INTO employee_demographics (employee_id, first_name, last_name)
  VALUES (NEW.employee_id, NEW.fisrt_name, NEW.last_name);
END $$
DELIMITER ;

--TEST 
INSERT INTO employee_salary (employee_id, first_name, last_name,occupation,salary,dept_id)
VALUES(13,'jonpaul','seper','ENTRETEIMENT 720 CEO',1000000,NULL);
-- SI funciona tambien estara en la tabla de demographics el nombre y lo otro y solo falta completarla



-- EVENTS 
SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
  DELETE
  FROM employee_demagraphics
  WHERE age >= 60;
END $$
DELIMITER ;

--CADA VEZ QUE LLEGUE A 60 Años se borra 

SHOW VARIABLES LIKE 'event%';
-- Mira so el evento esta ON o OFF
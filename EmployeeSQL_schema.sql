DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE departments (
  dept_no VARCHAR (10) PRIMARY KEY NOT NULL,
  dept_name VARCHAR (30) NOT NULL
);

SELECT *
FROM departments

CREATE TABLE titles (
  title_id VARCHAR (30) PRIMARY KEY NOT NULL,
  title VARCHAR (100) NOT NULL
);

SELECT *
FROM titles

CREATE TABLE employees (
  emp_no INT PRIMARY KEY NOT NULL,
  emp_title_id VARCHAR NOT NULL,
  birth_date DATE NOT NULL,
  first_name VARCHAR (50) NOT NULL,
  last_name VARCHAR (50) NOT NULL,
  sex VARCHAR (10) NOT NULL,
  hire_date DATE NOT NULL,
  CONSTRAINT fk_emp_title_id FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

SELECT *
FROM employees

CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR (10) NOT NULL,
  CONSTRAINT fk_emp_no FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  CONSTRAINT fk_dept_no FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  PRIMARY KEY (emp_no, dept_no)
);

SELECT *
FROM dept_emp

CREATE TABLE dept_manager (
  dept_no VARCHAR (10) NOT NULL,
  emp_no INT NOT NULL,
  CONSTRAINT fk_dept_no FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  CONSTRAINT fk_emp_no FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  PRIMARY KEY (dept_no,emp_no)
);

SELECT *
FROM dept_manager

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  CONSTRAINT fk_emp_no FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  PRIMARY KEY (emp_no)
);

SELECT *
FROM salaries

SELECT 
	employees.emp_no, 
	employees.last_name, 
	employees.first_name, 
	employees.sex,
  	salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

SELECT 
	employees.first_name,
	employees.last_name, 
	employees.hire_date
FROM employees
WHERE hire_date BETWEEN '01-01-1986' AND '12-31-1986'
;

SELECT 
	titles.title,
	dept_manager.dept_no,
	departments.dept_name,
	employees.emp_no, 
	employees.last_name, 
	employees.first_name 
FROM employees
INNER JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN titles ON employees.emp_title_id = titles.title_id
;

SELECT 
	dept_emp.dept_no,
	employees.emp_no, 
	employees.last_name, 
	employees.first_name,
	departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
;

SELECT 
	employees.first_name,
	employees.last_name, 
	employees.sex
FROM employees
WHERE first_name LIKE 'Hercules' AND last_name LIKE 'B%'
;

SELECT 
	departments.dept_name,
	employees.emp_no, 
	employees.last_name, 
	employees.first_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales'
;

SELECT 
	departments.dept_name,
	employees.emp_no, 
	employees.last_name, 
	employees.first_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
;

SELECT 
    last_name, 
    COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC
;
-- As the image illustrates, your schema should contain the following three tables:
DROP DATABASE IF EXISTS employees_db;

-- Creates the "employees_db" database --

CREATE DATABASE employees_db;

-- Makes it so all of the following code will affect inventory_db --

USE employees_db;

-- Creates the 'departments' table and adding contraints 

CREATE TABLE departments (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

-- Creates the 'roles' table and adding contraints 

CREATE TABLE roles (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(30) NOT NULL,
    salary DECIMAL NOT NULL,
    department_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Creates the `employees` table and adding contraints 
CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    role_id INT NOT NULL,
    manager_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (manager_id) REFERENCES employees(id)
);

-- `employee`
-- `manager_id`: `INT` to hold reference to another employee that is the manager of the current employee (`null` if the employee has no manager)
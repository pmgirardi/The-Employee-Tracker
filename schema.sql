-- As the image illustrates, your schema should contain the following three tables:
DROP DATABASE IF EXISTS employee_db;

-- Creates the "employee_db" database --

CREATE DATABASE employee_db;

-- Makes it so all of the following code will affect inventory_db --

USE employee_db;

-- Creates the 'department' table

CREATE TABLE departments (
    id INT NOT NULL, 
    name VARCHAR(30) NOT NULL, 
    PRIMARY KEY (id)
);

-- Creates the 'role' table

CREATE TABLE roles (
    id INT NOT NULL,
    title VARCHAR(30) NOT NULL, 
    salary  DECIMAL(10,2) NOT NULL, 
    department_id INT UNSIGNED NOT NULL REFERENCES departments(id), 
    PRIMARY KEY (id)
)

-- Creates the `employee` table
CREATE TABLE employee (
    id INT NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NUL,
    role_id INT UNSIGNED NOT NULL REFERENCES roles(id),
    manager_id INT UNSIGNED NOT NULL REFERENCES manger(id)
    PRIMARY KEY (id)
);

-- `employee`
-- `manager_id`: `INT` to hold reference to another employee that is the manager of the current employee (`null` if the employee has no manager)
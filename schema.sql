-- As the image illustrates, your schema should contain the following three tables:
DROP DATABASE IF EXISTS employee_db;

-- Creates the "employee_db" database --

CREATE DATABASE employee_db;

-- Makes it so all of the following code will affect inventory_db --

USE employee_db;

-- Creates the 'department' table and adding contraints 

CREATE TABLE departments (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30) NOT NULL
);

-- Creates the 'roles' table and adding contraints 

CREATE TABLE roles (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30) NOT NULL, 
    salary DECIMAL(10,2) NOT NULL, 
    department_id INT UNSIGNED NOT NULL,
      INDEX dep_ind (department_id),
  CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES department(id) ON DELETE CASCADE
);

-- Creates the `employee` table and adding contraints 
CREATE TABLE employee (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    role_id INT UNSIGNED NOT NULL, INDEX role_ind (role_id),
  CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
  manager_id INT UNSIGNED,
  INDEX man_ind (manager_id),
  CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employee(id) ON DELETE SET NULL
);

-- `employee`
-- `manager_id`: `INT` to hold reference to another employee that is the manager of the current employee (`null` if the employee has no manager)
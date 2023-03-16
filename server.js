const express = require('express');
const inquirer = require('inquirer');
const mysql = require('mysql2');

const PORT = process.env.PORT || 3001;
const app = express();

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

const db = mysql.createConnection(
    {
        host: '127.0.0.1',
        user: 'root',
        password: '89Bronc2!',
        database: 'employees_db'
    },
    console.log(`Connected to the employees_db database.`)
);

db.connect(err => {
    if (err) throw err;
    console.log('Employee Manager');
    employeeTracker();
});

function employeeTracker() {
    inquirer.prompt({
        type: 'list',
        name: 'employeeManger',
        message: 'What would you like to do?',
        choices: [
            'View All Employees',
            'Add Employee',
            'Update Employee Role',
            'View All Roles',
            'Add Role',
            'View All Departments',
            'Add Department'
        ]
    })
        .then((answer) => {
            switch (answer.employeeManger) {
                case 'View All Employees':
                    viewAllEmployees();
                    break;
                case 'Add Employee':
                    addEmployee();
                       break;
                case 'Update Employee Role':
                    updateEmployeeRole();
                        break;
                case 'View All Roles':
                    viewAllRoles();
                        break;
                case 'Add Role':
                    addRole();
                        break;
                case 'View All Departments':
                    viewAllDepartments();
                    break;
                case 'Add Department':
                    addDepartment();
                    break;
            }
        });
}

// Function to view all Employees

function viewAllEmployees() {
    db.query('SELECT * FROM employees', (err, results) => {
        if (err) throw err;
        console.table(results);
        employeeTracker();
    });
}


// Function to add an Employees

function addEmployee() {
    inquirer.prompt([
        {
            type: 'input',
            name: 'first_name',
            message: 'First name:'
        },
        {
            type: 'input',
            name: 'last_name',
            message: 'Last name:'
        },
        {
            type: 'input',
            name: 'role_id',
            message: 'Role ID:'
        },
        {
            type: 'input',
            name: 'manager_id',
            message: 'Manager ID:'
        }
    ])
        .then((answer) => {
            db.query('INSERT INTO employees (first_name, last_name, role_id, manager_id) VALUES (?, ?, ?, ?)', [answer.first_name, answer.last_name, answer.role_id, answer.manager_id], (err, results) => {
                if (err) throw err;
                console.log('Employee added.');
                employeeTracker();
            });
        });
}

// function to update Employees role

function updateEmployeeRole() {
    inquirer.prompt([
        {
            type: 'input',
            name: 'id',
            message: 'New employee ID:'
        },
        {
            type: 'input',
            name: 'role_id',
            message: 'New role ID:'
        }
    ])
        .then((answer) => {
            db.query('UPDATE employees SET role_id = ? WHERE id = ?', [answer.role_id, answer.id], (err, results) => {
                if (err) throw err;
                console.log('New employee role updated.');
                employeeTracker();
            });
        });

}

// function to view all roles

function viewAllRoles() {
    db.query('SELECT * FROM roles', (err, results) => {
        if (err) throw err;
        console.table(results);
        employeeTracker();
    });
}

// function to add role

function addRole() {
    inquirer.prompt([
        {
            type: 'input',
            name: 'title',
            message: 'Title:'
        },
        {
            type: 'input',
            name: 'salary',
            message: 'Salary:'
        },
        {
            type: 'input',
            name: 'department_id',
            message: 'Department ID:'
        }
    ])
        .then((answer) => {
            db.query('INSERT INTO roles (title, salary, department_id) VALUES (?, ?, ?)', [answer.title, answer.salary, answer.department_id], (err, results) => {
                if (err) throw err;
                console.log('Role added.');
                employeeTracker();
            });
        });
}

// function to view all departments

function viewAllDepartments() {
    db.query('SELECT * FROM departments', (err, results) => {
        if (err) throw err;
        console.table(results);
        employeeTracker();
    });
}

// function to add department 

function addDepartment() {
    inquirer.prompt({
        type: 'input',
        name: 'department',
        message: 'Department name:'
    })
        .then((answer) => {
            db.query('INSERT INTO departments (name) VALUES (?)', answer.department, (err, results) => {
                if (err) throw err;
                console.log('Department added.');
                employeeTracker();
            });
        });
}


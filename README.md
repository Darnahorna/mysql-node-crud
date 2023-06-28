# To-Do App Server

This is a Node.js server application for a simple To-Do app. It provides an HTTP API for managing to-do items and lists by interacting with a MySQL database.

## Prerequisites

Before running the server, make sure you have the following dependencies installed:

- Node.js
- MySQL

## Installation

1. Clone the repository: ```git clone git@github.com:Darnahorna/FooCoding.git```
2. Navigate to the project directory: ```cd databases/week03/```
3. Configure the MySQL connection. Open the server.js file and modify the following lines according to your MySQL database configuration:
```
const pool = mysql.createPool({
host: "localhost",
user: "your_username",
password: "your_password",
database: "todoapp",
waitForConnections: true,
connectionLimit: 10,
queueLimit: 0,
});
```
## Usage

To start the server, run the following command:

node server.js
The server will start listening on port 3000. You can access the API endpoints using HTTP methods (POST, DELETE, PUT) on the following routes:

- **POST /listItem**: Add a new to-do item(s).
Example of body (raw) request.
```[{
"name": "Bring the ball back to Fritidsbanken", 
"description": "They work until 4pm", 
"isCompleted": "F", 
"reminder": "2023-06-13",
"listId": 1
},
{
"name": "Discuss deployment problem with Harry", 
"description": "Fly.io", 
"isCompleted": "F", 
"reminder": "2023-06-13",
"listId": 8
}
]
```
- **DELETE /listItem**: Delete one or more to-do items.
Example of body (raw) request.
```[15254,15255,15256]```
- **PUT /listItem/ :id**: Mark a to-do item as complete.
Example of URL.```http://localhost:3000/listItem/10```
- **POST /list**: Add a new to-do list(s). 
Example of body (raw) request. ```[{
    "idList": 11, 
    "listName": "Plants", 
    "created": "2023-06-05 20:00:00", 
    "userId": 1}
]```
- **DELETE /list**: Delete a to-do list.
- Example of body (raw) request.
```[11]```
- **PUT /list/ :id**: Set a reminder for a to-do list.
Example of URL.```http://localhost:3000/list/10```

Please note that you need to replace **_:id_** with the actual ID of the item or list you want to modify.

## Testing 
For better testing you can use Postman Public Workspace. Click here - https://www.postman.com/darnahorna/workspace/to-do-application

## Database Schema

The server assumes the existence of the MySQL database and tables. Make sure to create the database and tables in your MySQL server before running the server. 

For creating databese from dump you have to run todoapp.sql script using a command ```source \home\user\Desktop\test.sql;```

After that you have to write a command  ```USE todoapp;```

## Acknowledgment

This project is educational project for FooCoding course in Malmo.

const http = require("http");
const mysql = require("mysql2");
const {
  addElement,
  deleteListItem,
  markComplete,
  addList,
  deleteList,
  setReminder,
} = require("./controllers");

const pool = mysql.createPool({
  host: "localhost",
  user: "darnahorna",
  password: "qwerty",
  database: "todoapp",
  waitForConnections: true,
  connectionLimit: 10,
});

const server = http.createServer((req, res) => {
  const urlParts = req.url.split("/");
  const endpoint = "/" + urlParts[1];
  const id = urlParts[2];

  switch (endpoint) {
    case "/listItem":
      if (req.method === "POST") {
        addElement(pool, req, display);
      } else if (req.method === "DELETE") {
        deleteListItem(pool, req, display);
      } else if (req.method === "PUT" && id) {
        markComplete(pool, id, display);
      } else {
        notFound(res);
      }
      break;
    case "/list":
      if (req.method === "POST") {
        addList(pool, req, display);
      } else if (req.method === "DELETE") {
        deleteList(pool, req, display);
      } else if (req.method === "PUT" && id) {
        setReminder(pool, req, id, display);
      } else {
        notFound(res);
      }
      break;
    default:
      notFound(res);
  }

  function display(err, result) {
    if (err) {
      console.error("Error executing query: ", err);
      res.statusCode = 500;
      res.end(err.sqlMessage);
      return;
    }
    res.statusCode = 200;
    res.end("Query executed successfully! ");
  }
});

const port = 3000;
server.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});

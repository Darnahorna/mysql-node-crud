function deleteListItem(pool, req, cb) {
  collectRequestBodyData(req, (body) => {
    const data = JSON.parse(body);

    data.forEach((item) => {
      getConnection(
        pool,
        "DELETE FROM todoitem WHERE (idtoDoItem = ?);",
        [item],
        cb
      );
    });
  });
}

function deleteList(pool, req, cb) {
  collectRequestBodyData(req, (body) => {
    const data = JSON.parse(body);

    data.forEach((item) => {
      getConnection(
        pool,
        "DELETE FROM todolist WHERE (idList = ?);",
        [item],
        cb
      );
    });
  });
}

function addElement(pool, req, cb) {
  collectRequestBodyData(req, (body) => {
    const data = JSON.parse(body);

    data.forEach((item) => {
      getConnection(
        pool,
        "INSERT INTO todoitem ( name, description, isCompleted, reminder, listId) VALUES ( ?, ?, ?, ?, ?);",
        [
          item.name,
          item.description,
          item.isCompleted,
          item.reminder,
          item.listId,
        ],
        cb
      );
    });
  });
}
function markComplete(pool, id, cb) {
  getConnection(
    pool,
    'UPDATE todoitem SET isCompleted = "T" WHERE (idtoDoItem = ?)',
    [id],
    cb
  );
}
function addList(pool, req, cb) {
  collectRequestBodyData(req, (body) => {
    const data = JSON.parse(body);

    data.forEach((item) => {
      getConnection(
        pool,
        "INSERT INTO toDoList (idList, listName, created, userId) VALUES (?, ?, ?, ?)",
        [item.idList, item.listName, item.created, item.userId],
        cb
      );
    });
  });
}
function setReminder(pool, req, id, cb) {
  collectRequestBodyData(req, (body) => {
    const data = JSON.parse(body);

    getConnection(
      pool,
      `UPDATE todolist SET reminder = ? WHERE (idList = ?);`,
      [data.reminder, id],
      cb
    );
  });
}

function getConnection(pool, mySqlRequest, parameters, callback) {
  pool.getConnection(function (err, connection) {
    console.log("Connected to the database!");
    connection.prepare(mySqlRequest, (err, statement) => {
      statement.execute(parameters, callback);
      statement.close();
    });

    pool.releaseConnection(connection);
  });
}
function collectRequestBodyData(req, callback) {
  let body = "";
  req.on("data", (chunk) => {
    body += chunk;
  });

  req.on("end", () => {
    callback(body);
  });
}
module.exports.addElement = addElement;
module.exports.deleteListItem = deleteListItem;
module.exports.deleteList = deleteList;
module.exports.markComplete = markComplete;
module.exports.addList = addList;
module.exports.setReminder = setReminder;

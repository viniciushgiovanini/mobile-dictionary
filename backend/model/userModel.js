const connection = require("../config/db.js");

const findUserByEmail = async (email) => {
  const sql = `SELECT * FROM users WHERE email = ?`;

  const [rows] = await connection.promise().query(sql, [email]);

  return rows[0];
};

const createUser = async (name, email, passwordHash, borndate) => {
  const [result] = await connection
    .promise()
    .query(
      "INSERT INTO users (name, email, password, borndate) VALUES (?, ?, ?, ?)",
      [name, email, passwordHash, borndate]
    );
  return result.insertId;
};

module.exports = {
  findUserByEmail,
  createUser,
};

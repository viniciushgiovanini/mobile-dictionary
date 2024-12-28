const connection = require("../config/db");

const getAllDict = async () => {
  const sql = `SELECT * from dicionario`;

  const [rows] = await connection.promise().query(sql);

  return rows;
};

module.exports = {
  getAllDict,
};

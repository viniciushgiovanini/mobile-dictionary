const connection = require("../config/db.js");

/**
 * Faz a request selecionando o usuario pelo email unico.
 * Parte do SQL.
 * @param email - email unico que sera pesquisado se existe esse registro no banco
 * @returns {json} - Retorno o obj com email que chegou como parametro
 */
const findUserByEmail = async (email) => {
  const sql = `SELECT * FROM users WHERE email = ?`;

  const [rows] = await connection.promise().query(sql, [email]);

  return rows[0];
};

/**
 * Faz a request selecionando o usuario pelo email unico.
 * Parte do SQL.
 * @param nome - nome do usuario
 * @param email - email unico que sera pesquisado se existe esse registro no banco
 * @param passwordHash - senha ja em hash
 * @param borndate - string que é o dia de nascimento do usuario
 * @returns {json} - Retorno o obj com email que chegou como parametro
 */
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

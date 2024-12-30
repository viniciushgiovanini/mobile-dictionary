const connection = require("../config/db");

/**
 * Faz a request te todos os dados do dataset e retorna (Todas as palavras).
 * Parte do SQL.
 *
 * @returns {json} - Retorno todos os dados do dicionario
 */
const getAllDict = async () => {
  const sql = `SELECT * from dicionario`;

  const [rows] = await connection.promise().query(sql);

  return rows;
};

module.exports = {
  getAllDict,
};

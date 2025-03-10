const Dicio = require("../model/dictModel");

/**
 * Faz a request te todos os dados do dataset e retorna (Todas as palavras)
 *
 * @param {dynamic} req
 * @param {dynamic} res
 * @returns {json} - Retorno todos os dados do dicionario
 */
const getDict = async (req, res) => {
  try {
    const dicio = await Dicio.getAllDict();

    if (!dicio) {
      return res.status(400).json({ message: "Erro na request do dicionario" });
    } else {
      return res
        .status(200)
        .json({ message: "Request Realizada com Sucesso", data: dicio });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erro na requisição do dicionario !" });
  }
};

module.exports = {
  getDict,
};

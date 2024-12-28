const bcrypy = require("bcryptjs");
const User = require("../model/userModel");

const registerUser = async (req, res) => {
  const { name, email, password, borndate } = req.body;

  try {
    const existingUser = await User.findUserByEmail(email);

    if (existingUser) {
      return res.status(400).json({ message: "Email ja cadastrado !" });
    }

    const passwordHash = await bcrypy.hash(password, 10);

    const userId = await User.createUser(name, email, passwordHash, borndate);

    res.status(201).json({ message: "Usuario registrado com sucesso !" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "ERRO na criacao do usuario !" });
  }
};

const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findUserByEmail(email);

    if (!user) {
      return res.status(400).json({ message: "Email ou senha incorretos" });
    }

    const isMatch = await bcrypy.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ message: "Email ou senha incorretos" });
    }

    res.status(200).json({ message: "Login bem-sucedido !", data: user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "ERRO no Login do usuario !" });
  }
};

module.exports = {
  registerUser,
  loginUser,
};

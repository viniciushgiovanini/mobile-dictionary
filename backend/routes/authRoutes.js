const express = require("express");
const router = express.Router();
const authControler = require("../controllers/authController");
const dicioControler = require("../controllers/dicionarioController");

router.post("/api/auth/register", authControler.registerUser);

router.post("/api/auth/login", authControler.loginUser);

router.get("/api/dados/dicionario", dicioControler.getDict);

module.exports = router;

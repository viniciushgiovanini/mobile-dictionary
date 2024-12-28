const express = require("express");
const router = express.Router();
const authControler = require("../controllers/authController");

router.post("/register", authControler.registerUser);

router.post("/login", authControler.loginUser);

module.exports = router;

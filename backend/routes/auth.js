const express = require('express');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const authRouter = express.Router();
const auth = require('../middleware/auth');
const User = require('../models/user');

// Input validation function
const validateSignupInput = (name, email, password) => {
    const errors = [];
    
    // Check for empty or whitespace-only inputs
    if (!name || name.trim().length === 0) {
        errors.push("Name is required");
    }
    
    if (!email || email.trim().length === 0) {
        errors.push("Email is required");
    } else if (!email.includes('@')) { // Basic email format validation
        errors.push("Invalid email format");
    }
    
    if (!password || password.trim().length === 0) {
        errors.push("Password is required");
    } else if (password.length < 6) { // Add minimum password length requirement
        errors.push("Password must be at least 6 characters long");
    }
    
    return errors;
};

// Sign Up
authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password } = req.body;

        // Validate input
        const validationErrors = validateSignupInput(name, email, password);
        if (validationErrors.length > 0) {
            return res.status(400).json({ 
                msg: "Validation failed", 
                errors: validationErrors 
            });
        }

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res
                .status(400)
                .json({ msg: "User with this email already exists!" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        const user = await User.create({
            email: email.trim(),
            password: hashedPassword,
            name: name.trim(),
        });
        
        // Remove password from response
        const { password: _, ...userResponse } = user;
        res.json(userResponse);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// Sign In
authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;
        
        // Basic signin validation
        if (!email || !password) {
            return res
                .status(400)
                .json({ msg: "Email and password are required" });
        }

        const user = await User.findOne({ email });
        if (!user) {
            return res
                .status(400)
                .json({ msg: "User with this email does not exist!" });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res
                .status(400)
                .json({ msg: "Invalid credentials!" });
        }

        const token = jwt.sign({ id: user.id }, "passwordKey");
        const { password: _, ...userResponse } = user;
        res.json({ token, ...userResponse });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// Get user data
authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    const { password: _, ...userResponse } = user;
    res.json({ ...userResponse, token: req.token });
});

module.exports = authRouter;
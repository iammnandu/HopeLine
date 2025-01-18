const express = require("express");
const authRouter = require("./routes/auth");
const { initializeDatabase } = require("./database");

const PORT = process.env.PORT || 3000;
const app = express();
const cors = require('cors');

app.use(cors());
app.use(express.json());
app.use(authRouter);

// Initialize database before starting server
initializeDatabase()
    .then(() => {
        app.listen(PORT, "172.18.100.178", () => {
            console.log(`Server running on port ${PORT}`);
        });
    })
    .catch(err => {
        console.error("Failed to initialize database:", err);
        process.exit(1);
    });

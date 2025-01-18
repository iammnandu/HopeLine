const express = require("express");
const authRouter = require("./routes/auth");
const path = require('path');
const meditationRoutes = require('./adapters/routes/meditationRoutes');
const songRoutes = require('./adapters/routes/songRoutes');
const { initializeDatabase } = require("./database");

const PORT = process.env.PORT || 6000;
const app = express();
const cors = require('cors');

app.use(cors());
app.use(express.json());
app.use(authRouter);
// Serve static files from the media directory
app.use('/media', express.static(path.join(__dirname, 'media')));

app.use('/hopeline', meditationRoutes);
app.use('/songs', songRoutes);

// Initialize database before starting server
initializeDatabase()
    .then(() => {
        app.listen(PORT, "192.168.1.100", () => {
            console.log(`Server running on port ${PORT}`);
        });
    })
    .catch(err => {
        console.error("Failed to initialize database:", err);
        process.exit(1);
    });
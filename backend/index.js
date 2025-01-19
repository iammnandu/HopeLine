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
        app.listen(PORT, "192.168.1.102", () => {
            console.log(`Server running on port ${PORT}`);
        });
    })
    .catch(err => {
        console.error("Failed to initialize database:", err);
        process.exit(1);
    });


// API endpoint to save quiz results
app.post('/api/quiz-results', async (req, res) => {
    const { userId, score, totalQuestions, timestamp } = req.body;
  
    db.serialize(() => {
      // Begin transaction
      db.run('BEGIN TRANSACTION');
  
      try {
        // Insert quiz result
        db.run(
          'INSERT INTO quiz_results (user_id, score, total_questions, timestamp) VALUES (?, ?, ?, ?)',
          [userId, score, totalQuestions, timestamp]
        );
  
        // Update user rewards
        db.run(
          `INSERT INTO user_rewards (user_id, total_points) 
           VALUES (?, ?) 
           ON CONFLICT(user_id) 
           DO UPDATE SET total_points = total_points + ?`,
          [userId, score, score]
        );
  
        // Commit transaction
        db.run('COMMIT');
        res.json({ success: true, message: 'Results saved successfully' });
      } catch (error) {
        db.run('ROLLBACK');
        res.status(500).json({ success: false, message: error.message });
      }
    });
  });
  
  // API endpoint to get user's total points
  app.get('/api/user-points/:userId', (req, res) => {
    const userId = req.params.userId;
    
    db.get(
      'SELECT total_points FROM user_rewards WHERE user_id = ?',
      [userId],
      (err, row) => {
        if (err) {
          res.status(500).json({ success: false, message: err.message });
        } else {
          res.json({ 
            success: true, 
            points: row ? row.total_points : 0 
          });
        }
      }
    );
  });
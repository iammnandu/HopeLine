const express = require('express');
const auth = require('../middleware/auth');
const User = require('../models/user');
const quizRouter = express.Router();

quizRouter.post('/api/quiz-results', auth, async (req, res) => {
    try {
        const { score, totalQuestions, timestamp } = req.body;
        const userId = req.user;  // From auth middleware
        const db = await getDb();

        await db.run('BEGIN TRANSACTION');

        try {
            // Save quiz result
            await db.run(
                'INSERT INTO quiz_results (user_id, score, total_questions, timestamp) VALUES (?, ?, ?, ?)',
                [userId, score, totalQuestions, timestamp]
            );

            // Update user reward points
            await User.updateRewardPoints(userId, score);

            await db.run('COMMIT');
            
            // Get updated total points
            const totalPoints = await User.getRewardPoints(userId);

            res.json({ 
                success: true, 
                message: 'Results saved successfully',
                totalPoints
            });
        } catch (error) {
            await db.run('ROLLBACK');
            throw error;
        }
    } catch (error) {
        res.status(500).json({ 
            success: false, 
            message: error.message 
        });
    }
});

quizRouter.get('/api/user-points', auth, async (req, res) => {
    try {
        const userId = req.user;
        const points = await User.getRewardPoints(userId);
        res.json({ 
            success: true, 
            points 
        });
    } catch (error) {
        res.status(500).json({ 
            success: false, 
            message: error.message 
        });
    }
});

module.exports = quizRouter;
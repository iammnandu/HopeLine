const { getDb } = require('../database');

class User {
    static async findOne({ email }) {
        const db = await getDb();
        return db.get('SELECT * FROM users WHERE email = ?', [email]);
    }

    static async findById(id) {
        const db = await getDb();
        return db.get('SELECT * FROM users WHERE id = ?', [id]);
    }

    static async create({ name, email, password }) {
        const db = await getDb();
        const result = await db.run(
            'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
            [name, email, password]
        );
        
        // Initialize user rewards when creating new user
        await db.run(
            'INSERT INTO user_rewards (user_id, total_points) VALUES (?, 0)',
            [result.lastID]
        );
        
        return {
            id: result.lastID,
            name,
            email,
            password
        };
    }

    static async updateRewardPoints(userId, points) {
        const db = await getDb();
        await db.run(
            `INSERT INTO user_rewards (user_id, total_points) 
             VALUES (?, ?) 
             ON CONFLICT(user_id) 
             DO UPDATE SET total_points = total_points + ?`,
            [userId, points, points]
        );
    }

    static async getRewardPoints(userId) {
        const db = await getDb();
        const result = await db.get(
            'SELECT total_points FROM user_rewards WHERE user_id = ?',
            [userId]
        );
        return result ? result.total_points : 0;
    }
}

module.exports = User;
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
        
        return {
            id: result.lastID,
            name,
            email,
            password
        };
    }
}

module.exports = User;
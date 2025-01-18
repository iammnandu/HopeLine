const sqlite3 = require('sqlite3').verbose();
const { open } = require('sqlite');
const path = require('path');

let db = null;

async function getDb() {
    if (db) return db;
    
    db = await open({
        filename: path.join(__dirname, 'database.sqlite'),
        driver: sqlite3.Database
    });
    
    return db;
}

async function initializeDatabase() {
    const db = await getDb();
    
    await db.exec(`
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL
        )
    `);
}

module.exports = { getDb, initializeDatabase };
const db = require("..");
const Song = require("../../../domain/entities/Song");

const getAllSongs = async () => {
    try {
        const rows = await db.query('SELECT * FROM songs');
        if (rows.length === 0) {
            console.log("No songs found.");
        } else {
            console.log("Songs retrieved:", rows);
        }
        return rows;
    } catch (error) {
        console.error("Error fetching songs:", error);
        throw error;
    }
};

const addSong = async (title, artist, songLink) => {
    try {
        const result = await db.query(
            'INSERT INTO songs (title, artist, songLink) VALUES (?, ?, ?)',
            [title, artist, songLink]
        );
        console.log("Song added successfully");
        return result;
    } catch (error) {
        console.error("Error adding song:", error);
        throw error;
    }
};

// Function to add multiple songs at once
const addBulkSongs = async (songs) => {
    try {
        for (const song of songs) {
            await addSong(song.title, song.artist, song.songLink);
        }
        console.log("All songs added successfully");
    } catch (error) {
        console.error("Error adding bulk songs:", error);
        throw error;
    }
};

// Helper function to initialize the database with sample songs
const initializeSongs = async () => {
    const songs = [
        {
            title: "Anti-Hero",
            artist: "Taylor Swift",
            songLink: "/media/03 Anti-Hero.m4a"
        },
        {
            title: "august",
            artist: "Taylor Swift",
            songLink: "/media/08 august.m4a"
        },
        {
            title: "Cornelia Street",
            artist: "Taylor Swift",
            songLink: "/media/09 Cornelia Street.m4a"
        },
        {
            title: "Death By A Thousand Cuts",
            artist: "Taylor Swift",
            songLink: "/media/10 Death By A Thousand Cuts.m4a"
        },
        {
            title: "Call It What You Want",
            artist: "Taylor Swift",
            songLink: "/media/14 Call It What You Want.m4a"
        },
        {
            title: "Daylight",
            artist: "Taylor Swift",
            songLink: "/media/18 Daylight.m4a"
        },
        {
            title: "All Too Well (10 Minute Version)",
            artist: "Taylor Swift",
            songLink: "/media/30 All Too Well (10 Minute Version).m4a"
        },
        {
            title: "Back To December (Taylor's Version)",
            artist: "Taylor Swift",
            songLink: "/media/Taylor Swift - Back To December (Taylor's Version).m4a"
        },
        {
            title: "Enchanted (Taylor's Version)",
            artist: "Taylor Swift",
            songLink: "/media/Taylor Swift - Enchanted (Taylor's Version).m4a"
        }
    ];

    await addBulkSongs(songs);
};

module.exports = {
    getAllSongs,
    addSong,
    addBulkSongs,
    initializeSongs
};



/*
// Additional helper functions for CRUD operations
const addSong = async (title, artist, duration) => {
    try {
        const result = await db.query(
            'INSERT INTO songs (title, artist, duration) VALUES (?, ?, ?)',
            [title, artist, duration]
        );
        console.log("Song added successfully");
        return result;
    } catch (error) {
        console.error("Error adding song:", error);
        throw error;
    }
};

const getSongById = async (id) => {
    try {
        const rows = await db.query('SELECT * FROM songs WHERE id = ?', [id]);
        return rows[0];
    } catch (error) {
        console.error("Error fetching song:", error);
        throw error;
    }
};

const updateSong = async (id, title, artist, duration) => {
    try {
        await db.query(
            'UPDATE songs SET title = ?, artist = ?, duration = ? WHERE id = ?',
            [title, artist, duration, id]
        );
        console.log("Song updated successfully");
    } catch (error) {
        console.error("Error updating song:", error);
        throw error;
    }
};

const deleteSong = async (id) => {
    try {
        await db.query('DELETE FROM songs WHERE id = ?', [id]);
        console.log("Song deleted successfully");
    } catch (error) {
        console.error("Error deleting song:", error);
        throw error;
    }
};

module.exports = {
    getAllSongs,
    addSong,
    getSongById,
    updateSong,
    deleteSong
};


*/
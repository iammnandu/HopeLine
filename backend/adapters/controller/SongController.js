const { getAllSongs, addSong, initializeSongs } = require('../../infrastructure/db/queries/songQueries');

class SongController {
    static async all(req, res) {
        try {
            const songs = await getAllSongs();
            res.json(songs);
        } catch (error) {
            console.error('Error in SongController.all:', error);
            res.status(500).json({ error: 'Failed to fetch songs' });
        }
    }

    static async initialize(req, res) {
        try {
            await initializeSongs();
            res.json({ message: 'Songs initialized successfully' });
        } catch (error) {
            console.error('Error in SongController.initialize:', error);
            res.status(500).json({ error: 'Failed to initialize songs' });
        }
    }

    static async add(req, res) {
        try {
            const { title, artist, songLink } = req.body;
            if (!title || !artist || !songLink) {
                return res.status(400).json({ error: 'Missing required fields' });
            }
            
            const result = await addSong(title, artist, songLink);
            res.status(201).json({ 
                message: 'Song added successfully', 
                id: result.lastID 
            });
        } catch (error) {
            console.error('Error in SongController.add:', error);
            res.status(500).json({ error: 'Failed to add song' });
        }
    }
}

module.exports = SongController;
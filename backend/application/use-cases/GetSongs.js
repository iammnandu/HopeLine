const UseCaseInterface = require("../interfaces/UseCaseInterface");
const getAllSongs = require('../../infrastructure/db/queries/songQueries').getAllSongs;
const Song = require("../../domain/entities/Song");

class GetSongs extends UseCaseInterface {
    async execute() {
        const songRows = await getAllSongs();
        return songRows.map(song => new Song(
            {
                id: song.id,
                title: song.title,
                artist: song.artist,
                songLink: song.songLink, 
            }
        ));
    }
}


module.exports = GetSongs;
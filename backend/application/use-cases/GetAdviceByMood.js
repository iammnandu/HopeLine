class GetAdviceByMood {
    constructor(quotesRepository) {
        this.quotesRepository = quotesRepository;
    }

    async execute(mood) {
        if (!mood) {
            throw new Error('Mood parameter is required');
        }
        return await this.quotesRepository.getAdviceByMood(mood);
    }
}

module.exports = GetAdviceByMood;
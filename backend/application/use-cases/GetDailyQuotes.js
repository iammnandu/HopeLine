const UseCaseInterface = require("../interfaces/UseCaseInterface");
const Meditation = require("../../domain/entities/Meditation");

class GetDailyQuotes extends UseCaseInterface {
    constructor(quoteRepository) {
        super();
        this.quoteRepository = quoteRepository;
    }

    async execute() {
        const quotesData = await this.quoteRepository.getDailyQuotes();
        return {
            morningQuote: quotesData.morningQuote,
            afternoonQuote: quotesData.afternoonQuote,
            eveningQuote: quotesData.eveningQuote
        };
    }
}

module.exports = GetDailyQuotes;
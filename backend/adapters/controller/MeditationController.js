const GetAdviceByMood = require("../../application/use-cases/GetAdviceByMood");
const GetDailyQuotes = require("../../application/use-cases/GetDailyQuotes");
const HuggingFaceApi = require("../../infrastructure/huggingface/huggingfaceService");

class MeditationController {
    static async dailyQuote(req, res) {
        try {
            const quotesRepository = new HuggingFaceApi();
            const getDailyQuotes = new GetDailyQuotes(quotesRepository);
            const quotes = await getDailyQuotes.execute();
            res.json(quotes);
        } catch (error) {
            console.error('Controller error:', error);
            res.status(500).json({ error: error.message });
        }
    }

    static async myMood(req, res) {
        try {
            const { mood } = req.params;
            if (!mood) {
                return res.status(400).json({ error: "Mood parameter is required" });
            }

            const quotesRepository = new HuggingFaceApi();
            const getAdviceByMood = new GetAdviceByMood(quotesRepository);
            const advice = await getAdviceByMood.execute(mood);
            res.json(advice);
        } catch (error) {
            console.error('Controller error:', error);
            res.status(500).json({ error: error.message });
        }
    }
}

module.exports = MeditationController;
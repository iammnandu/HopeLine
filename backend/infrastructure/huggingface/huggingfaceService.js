const QuoteRepository = require("../../application/interfaces/QuotesRepository");
const config = require('../../config');

class HuggingFaceApi extends QuoteRepository {
    constructor() {
        super();
        this.headers = {
            Authorization: `Bearer ${config.HUGGINGFACE_API_KEY}`,
            "Content-Type": "application/json",
        };
        this.baseURL = config.HUGGINGFACE_API_URL;
        this.model = config.DEFAULT_MODEL;
    }

    async query(data) {
        const response = await fetch(`${this.baseURL}${this.model}`, {
            headers: this.headers,
            method: "POST",
            body: JSON.stringify(data),
        });

        if (!response.ok) {
            throw new Error(`API request failed with status ${response.status}`);
        }

        return await response.json();
    }

    async getDailyQuotes() {
        try {
            const prompt = `Generate three meditation quotes in JSON format: 
            {
                "morningQuote": "quote for morning meditation",
                "afternoonQuote": "quote for afternoon meditation",
                "eveningQuote": "quote for evening meditation"
            }`;

            const response = await this.query({
                inputs: prompt,
                parameters: {
                    max_new_tokens: 256,
                    temperature: 0.7,
                    return_full_text: false
                }
            });

            let content = response[0]?.generated_text || "";
            
            // Clean up the response to extract JSON
            content = content.substring(content.indexOf("{"), content.lastIndexOf("}") + 1);
            
            try {
                return JSON.parse(content);
            } catch (error) {
                console.error('JSON parsing error:', error, 'Content:', content);
                return {
                    morningQuote: "Start your day with mindful breathing",
                    afternoonQuote: "Find peace in the present moment",
                    eveningQuote: "Let go of today's worries"
                };
            }
        } catch (error) {
            console.error('Error fetching daily quotes:', error);
            throw new Error('Failed to fetch daily quotes');
        }
    }

    async getAdviceByMood(mood) {
        try {
            const prompt = `Based on the mood "${mood}", provide meditation advice in JSON format:
            {
                "advice": "your meditation advice here"
            }`;

            const response = await this.query({
                inputs: prompt,
                parameters: {
                    max_new_tokens: 256,
                    temperature: 0.7,
                    return_full_text: false
                }
            });

            let content = response[0]?.generated_text || "";
            
            // Clean up the response to extract JSON
            content = content.substring(content.indexOf("{"), content.lastIndexOf("}") + 1);
            
            try {
                return JSON.parse(content);
            } catch (error) {
                console.error('JSON parsing error:', error, 'Content:', content);
                return {
                    advice: "Take a deep breath and focus on the present moment."
                };
            }
        } catch (error) {
            console.error('Error fetching advice:', error);
            throw new Error('Failed to fetch advice');
        }
    }
}

module.exports = HuggingFaceApi;
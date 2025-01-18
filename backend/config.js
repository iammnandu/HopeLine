require('dotenv').config();

const config = {
    HUGGINGFACE_API_KEY: process.env.HUGGINGFACE_API_KEY,
    HUGGINGFACE_API_URL: "https://api-inference.huggingface.co/models/",
    DEFAULT_MODEL: "google/gemma-2-2b-it" 
};

module.exports = config;
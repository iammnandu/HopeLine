const UseCaseInterface = require("../interfaces/UseCaseInterface");

class GetAdviceByMood extends UseCaseInterface {
    constructor(adviceRepository) {
        super();
        this.adviceRepository = adviceRepository;
    }

    async execute(mood) {
        const adviceData = await this.adviceRepository.getAdviceByMood(mood);
        return new Meditation({ text: adviceData.text });
    } 


}

module.exports = GetAdviceByMood;
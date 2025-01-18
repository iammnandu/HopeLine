class UseCaseInterface {
    async execute() {
        throw new Error( 'Method not implemented' );
    }
}

module.exports = UseCaseInterface;
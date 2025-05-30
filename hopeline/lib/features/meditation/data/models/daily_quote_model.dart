import 'package:hopeline/features/meditation/domain/entities/daily_quote.dart';

class DailyQuoteModel extends DailyQuote {
  DailyQuoteModel({
    required String morningQuote,
    required String noonQuote,
    required String eveningQuote,
  }) : super(
            morningQuote: morningQuote,
            noonQuote: noonQuote,
            eveningQuote: eveningQuote);

  factory DailyQuoteModel.fromJson(Map<String, dynamic> json) {
    final quotes = json['text'];
    return DailyQuoteModel(
      morningQuote: quotes['morningQuote'],
      noonQuote: quotes['noonQuote'],
      eveningQuote: quotes['eveningQuote'],
    );
  }
}

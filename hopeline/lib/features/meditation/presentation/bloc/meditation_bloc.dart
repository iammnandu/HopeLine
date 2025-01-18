import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hopeline/features/meditation/domain/usecases/get_daily_quote.dart';
import 'package:hopeline/features/meditation/domain/usecases/get_mood_message.dart';
import 'package:hopeline/features/meditation/presentation/bloc/meditation_event.dart';
import 'package:hopeline/features/meditation/presentation/bloc/meditation_state.dart';

class MeditationBloc extends Bloc<MeditationEvent, MeditationState> {
  final GetDailyQuote getDailyQuote;
  final GetMoodMessage getMoodMessage;

  MeditationBloc(super.initialState, this.getDailyQuote, this.getMoodMessage) {
    on<FetchDailyQuote>((event, emit) async {
      emit(MeditationLoading());
      try {
        final dailyQuote = await getDailyQuote();
        emit(DailyQuoteLoaded(dailyQuote: dailyQuote));
      } catch (e) {
        emit(MeditationError(message: e.toString()));
      }
    });
  }
}

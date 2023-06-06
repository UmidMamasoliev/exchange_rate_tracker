import 'package:exchange_rate_tracker/data/exchange_rates_repository.dart';
import 'package:exchange_rate_tracker/models/exchange_rate_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exchange_rates_event.dart';
part 'exchange_rates_state.dart';

class ExchangeRatesBloc extends Bloc<ExchangeRatesEvent, ExchangeRatesState> {
  final ExchangeRatesRepository exchangeRatesRepository;
  ExchangeRatesBloc(this.exchangeRatesRepository)
      : super(ExchangeRatesInitial()) {
    on<ExchangeRatesEvent>(
      (event, emit) async {
        if (event is FetchExchangeRates) {
          emit(ExchangeRatesLoading());
          try {
            final List<ExchangeRate> exchangeRates =
                await exchangeRatesRepository.fetchExchangeRates(false);
            final List<HistoricalRate> historicalRates =
                await exchangeRatesRepository
                    .fetchHistoricalRates(event.currencyCode ?? 'USD');
            emit(ExchangeRatesLoaded(
              historicalRates: historicalRates,
              exchangeRates: exchangeRates,
            ));
          } catch (e) {
            emit(
              ExchangeRatesError(message: 'Failed to fetch exchange rates.'),
            );
            emit(
              ExchangeRatesError(message: 'Failed to fetch historical rates.'),
            );
          }
        } else if (event is ResetExchangeRates) {
          emit(ExchangeRatesLoading());
          try {
            final List<ExchangeRate> exchangeRates =
                await exchangeRatesRepository.fetchExchangeRates(true);
            final List<HistoricalRate> historicalRates =
                await exchangeRatesRepository
                    .fetchHistoricalRates(event.currencyCode ?? 'USD');
            emit(ExchangeRatesLoaded(
              historicalRates: historicalRates,
              exchangeRates: exchangeRates,
            ));
          } catch (e) {
            emit(
              ExchangeRatesError(message: 'Failed to reset exchange rates.'),
            );
          }
        }
      },
    );
  }
}

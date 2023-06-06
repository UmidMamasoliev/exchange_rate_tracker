part of 'exchange_rates_bloc.dart';

abstract class ExchangeRatesState {}

class ExchangeRatesInitial extends ExchangeRatesState {}

class ExchangeRatesLoading extends ExchangeRatesState {}

class ExchangeRatesLoaded extends ExchangeRatesState {
  final List<ExchangeRate> exchangeRates;
  final List<HistoricalRate> historicalRates;

  ExchangeRatesLoaded({
    required this.historicalRates,
    required this.exchangeRates,
  });
}

class ExchangeRatesError extends ExchangeRatesState {
  final String message;

  ExchangeRatesError({required this.message});
}

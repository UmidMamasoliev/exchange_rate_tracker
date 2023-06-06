part of 'exchange_rates_bloc.dart';

abstract class ExchangeRatesEvent {}

class FetchExchangeRates extends ExchangeRatesEvent {
  final String? currencyCode;

  FetchExchangeRates([this.currencyCode]);
}

class ResetExchangeRates extends ExchangeRatesEvent {
  final String? currencyCode;

  ResetExchangeRates([this.currencyCode]);
}

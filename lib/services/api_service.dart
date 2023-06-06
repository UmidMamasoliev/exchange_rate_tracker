import 'dart:math';

import '../models/currency_model.dart';
import '../models/exchange_rate_model.dart';
import '../utils/chart_data_formatter.dart';

class ApiService {
  List<ExchangeRate> exchangeRates = [];

  Future<List<ExchangeRate>> fetchExchangeRates(bool emptyList) async {
    if (exchangeRates.isNotEmpty && emptyList != true) {
      return exchangeRates;
    } else if (emptyList == true || emptyList == false) {
      // Simulating API call and generating random exchange rates
      exchangeRates = [];
      await Future.delayed(const Duration(seconds: 1));
      final List<Currency> currencies = await _fetchCurrencies();
      final Random random = Random();

      for (final currency in currencies) {
        final double rate = random.nextDouble() * 10;
        bool isRateIncreased = random.nextBool();
        final exchangeRate = ExchangeRate(
          currencyCode: currency.code,
          currencyName: currency.name,
          rate: rate,
          isRateIncreased: isRateIncreased,
        );
        exchangeRates.add(exchangeRate);
      }
    }
    return exchangeRates;
  }

  Future<List<Currency>> _fetchCurrencies() async {
    // Simulating API call and returning a list of currencies
    await Future.delayed(const Duration(seconds: 1));
    return [
      Currency(code: 'USD', name: 'United States Dollar'),
      Currency(code: 'EUR', name: 'Euro'),
      Currency(code: 'GBP', name: 'British Pound'),
      Currency(code: 'JPY', name: 'Japanese Yen'),
      Currency(code: 'CAD', name: 'Canadian Dollar'),
      Currency(code: 'AUD', name: 'Australian Dollar'),
      Currency(code: 'BGN', name: 'Bulgarian Lev'),
      Currency(code: 'BRL', name: 'Brazilian Real'),
      Currency(code: 'CAD', name: 'Canadian Dollar'),
      Currency(code: 'CHF', name: 'Swiss Franc'),
      Currency(code: 'CNY', name: 'Chinese Renminbi Yuan'),
      Currency(code: 'CZK', name: 'Czech Koruna'),
    ];
  }

  Future<List<HistoricalRate>> fetchHistoricalRates(String currencyCode) async {
    // Simulating API call and generating random historical rates
    await Future.delayed(const Duration(seconds: 1));
    final Random random = Random();
    final List<String> dates = ChartDataFormatter.generateRandomDates(7);
    final List<HistoricalRate> historicalRates = [];

    for (int i = 0; i < dates.length; i++) {
      final double rate = random.nextDouble() * 10;
      final HistoricalRate historicalRate =
          HistoricalRate(date: dates[i], rate: rate);
      historicalRates.add(historicalRate);
    }

    return historicalRates;
  }
}

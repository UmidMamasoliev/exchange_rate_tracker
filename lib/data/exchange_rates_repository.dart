import '../models/exchange_rate_model.dart';
import '../services/api_service.dart';

class ExchangeRatesRepository {
  final ApiService apiService;

  ExchangeRatesRepository({required this.apiService});

  Future<List<ExchangeRate>> fetchExchangeRates(bool emptyList) {
    return apiService.fetchExchangeRates(emptyList);
  }

  Future<List<HistoricalRate>> fetchHistoricalRates(String currencyCode) {
    return apiService.fetchHistoricalRates(currencyCode);
  }
}

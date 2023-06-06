class ExchangeRate {
  final String currencyCode;
  final String currencyName;
  final double rate;
  bool isRateIncreased;

  ExchangeRate({
    required this.currencyCode,
    required this.currencyName,
    required this.rate,
    required this.isRateIncreased,
  });
}

class HistoricalRate {
  final String date;
  final double rate;

  HistoricalRate({
    required this.date,
    required this.rate,
  });
}

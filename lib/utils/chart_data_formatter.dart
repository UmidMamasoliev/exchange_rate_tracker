import '../models/exchange_rate_model.dart';

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}

class ChartDataFormatter {
  static List<ChartData> generateChartData(
      List<HistoricalRate> historicalRates, double lastRate) {
    final List<ChartData> chartData = [];
    for (final rate in historicalRates) {
      final chartPoint = ChartData(rate.date, rate.rate);
      chartData.add(chartPoint);
    }
    chartData.add(ChartData('Latest', lastRate));
    return chartData;
  }

  static List<String> generateRandomDates(int count) {
    final List<String> dates = [];
    final DateTime now = DateTime.now();
    for (int i = count - 1; i >= 0; i--) {
      final DateTime date = now.subtract(Duration(days: i + 1));
      final String formattedDate =
          '${date.year}-${_formatTwoDigits(date.month)}-${_formatTwoDigits(date.day)}';
      dates.add(formattedDate);
    }
    return dates;
  }

  static String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}

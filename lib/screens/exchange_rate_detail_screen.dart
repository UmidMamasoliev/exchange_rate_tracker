import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../bloc/exchange_rates_bloc.dart';
import '../models/exchange_rate_model.dart';

class ExchangeRateDetailScreen extends StatelessWidget {
  final ExchangeRate exchangeRate;

  const ExchangeRateDetailScreen({Key? key, required this.exchangeRate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rate Detail'),
        elevation: 0,
      ),
      body: BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
        builder: (context, state) {
          if (state is ExchangeRatesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExchangeRatesLoaded) {
            final List<HistoricalRate> historicalRates = state.historicalRates;
            final List<HistoricalRate> combinedRates = [
              ...historicalRates,
              HistoricalRate(
                date: DateTime.now().toString(),
                rate: exchangeRate.rate,
              ),
            ];
            if (historicalRates.last.rate < exchangeRate.rate) {
              exchangeRate.isRateIncreased = true;
            } else {
              exchangeRate.isRateIncreased = false;
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Currency Code: ${exchangeRate.currencyCode}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Rate: ${exchangeRate.rate.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Icon(
                          exchangeRate.isRateIncreased
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          size: 40.0,
                          color: exchangeRate.isRateIncreased
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Description: ${exchangeRate.currencyName}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Exchange Rate History:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: historicalRates.length,
                          itemBuilder: (context, index) {
                            final historicalRate = historicalRates[index];
                            return Text(
                              '${historicalRate.date}: ${historicalRate.rate.toStringAsFixed(2)}\n',
                            );
                          },
                        ),
                      ],
                    ),
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries<HistoricalRate, String>>[
                        LineSeries<HistoricalRate, String>(
                          dataSource: combinedRates,
                          xValueMapper: (HistoricalRate rate, _) => rate.date,
                          yValueMapper: (HistoricalRate rate, _) => rate.rate,
                          markerSettings: const MarkerSettings(
                            isVisible: true,
                          ),
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            );
          } else if (state is ExchangeRatesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

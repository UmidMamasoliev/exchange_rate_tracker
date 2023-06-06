import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exchange_rates_bloc.dart';
import '../models/exchange_rate_model.dart';
import 'exchange_rate_detail_screen.dart';

class ExchangeRatesListScreen extends StatelessWidget {
  const ExchangeRatesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rates'),
      ),
      body: BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
        builder: (context, state) {
          if (state is ExchangeRatesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExchangeRatesLoaded) {
            final List<ExchangeRate> exchangeRates = state.exchangeRates;
            final List<HistoricalRate> historicalRates = state.historicalRates;
            return ListView.builder(
              itemCount: exchangeRates.length,
              itemBuilder: (_, index) {
                final exchangeRate = exchangeRates[index];
                if (historicalRates.last.rate < exchangeRate.rate) {
                  exchangeRate.isRateIncreased = true;
                } else {
                  exchangeRate.isRateIncreased = false;
                }
                return ListTile(
                  title: Text(exchangeRate.currencyCode),
                  subtitle: Text(exchangeRate.rate.toStringAsFixed(2)),
                  trailing: Icon(
                    exchangeRate.isRateIncreased
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: exchangeRate.isRateIncreased
                        ? Colors.green
                        : Colors.red,
                  ),
                  onTap: () async {
                    context
                        .read<ExchangeRatesBloc>()
                        .add(FetchExchangeRates(exchangeRate.currencyCode));
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<ExchangeRatesBloc>(context),
                          child: ExchangeRateDetailScreen(
                            exchangeRate: exchangeRate,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ExchangeRatesBloc>().add(ResetExchangeRates());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

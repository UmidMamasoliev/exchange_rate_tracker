import 'package:exchange_rate_tracker/screens/exchange_rates_list_screen.dart';
import 'package:exchange_rate_tracker/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/exchange_rates_bloc.dart';
import 'data/exchange_rates_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    final ExchangeRatesRepository exchangeRatesRepository =
        ExchangeRatesRepository(apiService: apiService);
    final ExchangeRatesBloc exchangeRatesBloc =
        ExchangeRatesBloc(exchangeRatesRepository)..add(FetchExchangeRates());

    return MaterialApp(
      title: 'Exchange Rate Tracker',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => exchangeRatesBloc,
        child: const ExchangeRatesListScreen(),
      ),
    );
  }
}

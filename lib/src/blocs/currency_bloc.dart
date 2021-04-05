import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CurrencyBloc {

  final BehaviorSubject<String> _currencySubject =
  BehaviorSubject<String>();

  Stream<String> get currencyStream$ => _currencySubject.stream;

  Sink<String> get currencySink => _currencySubject.sink;
  String get currentCurrency => _currencySubject.value;

  dispose() {
    _currencySubject.close();
  }
}

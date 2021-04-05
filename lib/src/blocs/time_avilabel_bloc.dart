import 'dart:async';
import 'package:rxdart/rxdart.dart';

class TimeAvailableBloc {

  final PublishSubject<int> _timeAvailableSubject =
  PublishSubject<int>();

  Stream<int> get timeAvilable$ => _timeAvailableSubject.stream;

 // String get currentAvilable => _timeAvailableSubject.value;

  Sink<int> get timeAvilableSink => _timeAvailableSubject.sink;

  dispose() {
    _timeAvailableSubject.close();
  }
}

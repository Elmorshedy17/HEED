import 'dart:async';
import 'package:rxdart/rxdart.dart';

class TimeDateBridge {

  final BehaviorSubject<bool> _timeDateSubject =
  BehaviorSubject<bool>.seeded(false);

 // Stream<bool> get _timeDate$ => _timeDateSubject.stream;

   bool get currentTimeDateSubject => _timeDateSubject.value;

  Sink<bool> get timeDateSink => _timeDateSubject.sink;

  dispose() {
    _timeDateSubject.close();
  }
}



/////////////// just another bloc to pass an bool from calendar to time input widget

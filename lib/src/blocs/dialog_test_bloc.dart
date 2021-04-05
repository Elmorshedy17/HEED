import 'dart:async';
import 'package:rxdart/rxdart.dart';

class DialogColor {

  final PublishSubject<int> _dialogColorSubject =
  PublishSubject<int>();

  Stream<int> get dialogColor$ => _dialogColorSubject.stream;

  Sink<int> get dialogColorSink => _dialogColorSubject.sink;

  dispose() {
_dialogColorSubject.close();
  }
}

import 'dart:async';
import 'package:rxdart/rxdart.dart';

class FirebaseTokenBloc{

  final BehaviorSubject<String> _firebaseTokenSubject =
  BehaviorSubject<String>.seeded("");

  Stream<String> get firebaseTokenStream$ => _firebaseTokenSubject.stream;
  Sink<String> get firebaseTokenSink => _firebaseTokenSubject.sink;
  String get currentFirebaseToken => _firebaseTokenSubject.value;

  dispose() {
    _firebaseTokenSubject.close();
  }
}

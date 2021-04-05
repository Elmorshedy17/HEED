//import 'dart:async';
//import 'package:rxdart/rxdart.dart';
//
//class SignUpCheckBoxBloc {
//
//  final BehaviorSubject<bool> _SignUpCheckBoxSubject =
//  BehaviorSubject<bool>.seeded(false);
//
//  // Stream<bool> get _timeDate$ => _timeDateSubject.stream;
//
//  bool get currentSignUpCheck => _SignUpCheckBoxSubject.value;
//
//  Sink<bool> get SignUpCheckSink => _SignUpCheckBoxSubject.sink;
//
//  changeCheckBoxController() {
//    SignUpCheckSink.add(!currentSignUpCheck);
//  }
//
//
//
//
//
//
//
////
////
////  final BehaviorSubject<bool> _finalSubject =
////  BehaviorSubject<bool>.seeded(false);
////
////
////  bool get current_finalSubject => _finalSubject.value;
////
////  Sink<bool> get finalSubjectSink => _finalSubject.sink;
//
//
//  dispose() {
//    _SignUpCheckBoxSubject.close();
//  //  _finalSubject.close();
//  }
//}
//
//
//
///////////////// just another bloc to pass an bool from calendar to time input widget

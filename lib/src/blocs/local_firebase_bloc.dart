import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LocalFirebaseBloc {

  final BehaviorSubject<String> _localFirebaseSubject =
  BehaviorSubject<String>();

  Stream<String> get localFirebase$ => _localFirebaseSubject.stream;

   String get currentlocalFirebase => _localFirebaseSubject.value;

  Sink<String> get localFirebaseSink => _localFirebaseSubject.sink;



  final BehaviorSubject<String> _localFirebaseSubjectTitle =
  BehaviorSubject<String>();

  Stream<String> get localFirebaseTitle$ => _localFirebaseSubjectTitle.stream;

   String get currentlocalFirebaseTitle => _localFirebaseSubjectTitle.value;

  Sink<String> get localFirebaseSinkTitle => _localFirebaseSubjectTitle.sink;





  dispose() {
    _localFirebaseSubject.close();
  }
}

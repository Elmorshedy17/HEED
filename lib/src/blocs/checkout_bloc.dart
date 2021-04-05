import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ChangePageBloc {


  final BehaviorSubject<int> _changepage = BehaviorSubject<int>();

  Function(int) get changePageSink => _changepage.sink.add;



  Stream<int> get changePage$ =>
      _changepage.stream;



  dispose() {
    _changepage.close();
  }
}

import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/checkTime_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:rxdart/rxdart.dart';

class CheckTimeBloc {
  //           you can say this is the main one           //

  final BehaviorSubject<CheckTimeModel> _checkTimeSubject =
      BehaviorSubject<CheckTimeModel>();
  //
  Stream<CheckTimeModel> get checkTime$ => _checkTimeSubject.stream;

  ////////////////////////////////  ID  ///////////////////////////////////////////
  final BehaviorSubject<String> _idSubject = BehaviorSubject<String>.seeded('');
  ////
  Sink<String> get inId => _idSubject.sink;

  /////////////////////////////////  Time  ////////////////////////////////////////////
  final BehaviorSubject<String> _timeSubject =
      BehaviorSubject<String>.seeded('');
  ////
  Sink<String> get inTime => _timeSubject.sink;

  /////////////////////////////////  Date  ////////////////////////////////////////////

  final BehaviorSubject<String> _dateSubject =
      BehaviorSubject<String>.seeded('');
////
  Sink<String> get inDate => _dateSubject.sink;

  /////////////////////////////////  Clicked  ////////////////////////////////////////////
  final BehaviorSubject<bool> _clickedSubject = BehaviorSubject<bool>();
  //
  Sink<bool> get inClick => _clickedSubject.sink;

  ////////////////////////////////////////////////////////////////////////////////

  CheckTimeBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _clickedSubject.switchMap((clicked) async* {
    //       yield await ApiService.checkTime(_idSubject.value.trim(),
    //           _dateSubject.value.trim(), _timeSubject.value.trim());
    //     }).listen((value) {
    //       _checkTimeSubject.add(value);
    //     });
    //   }
    // });

    _clickedSubject.switchMap((clicked) async* {
      yield await ApiService.checkTime(_idSubject.value.trim(),
          _dateSubject.value.trim(), _timeSubject.value.trim());
    }).listen((value) {
      _checkTimeSubject.add(value);
    });
  }

  void dispose() {
    _timeSubject.close();
    _dateSubject.close();
    _clickedSubject.close();
    _idSubject.close();
  }
}

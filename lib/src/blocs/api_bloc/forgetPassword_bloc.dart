import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/forgetPassword_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:rxdart/rxdart.dart';

class ForgetPasswordApiBloc {
  final BehaviorSubject<ForgetPasswordModel> _forgetPasswordSubject =
      BehaviorSubject<ForgetPasswordModel>();
////////////////////////////////////////////////////////////////////////////////
  final BehaviorSubject<bool> _clickedSubject = BehaviorSubject<bool>();
  Sink<bool> get inClick => _clickedSubject.sink;

  final BehaviorSubject<String> _emailSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inEmail => _emailSubject.sink;
////////////////////////////////////////////////////////////////////////////////
  Stream<ForgetPasswordModel> get forgetPassword$ =>
      _forgetPasswordSubject.stream;

  ForgetPasswordApiBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _clickedSubject.switchMap((clicked) async* {
    //       yield await ApiService.postForgetPasswordModel(
    //         _emailSubject.value.trim(),
    //       );
    //     }).listen((value) {
    //       _forgetPasswordSubject.add(value);
    //     });
    //   }
    // });

    _clickedSubject.switchMap((clicked) async* {
      yield await ApiService.postForgetPasswordModel(
        _emailSubject.value.trim(),
      );
    }).listen((value) {
      _forgetPasswordSubject.add(value);
    });
  }

  void dispose() {
    _emailSubject.close();
    _clickedSubject.close();
  }
}

import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/login_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final BehaviorSubject<LoginModel> _loginSubject =
      BehaviorSubject<LoginModel>();
////////////////////////////////////////////////////////////////////////////////
  final BehaviorSubject<bool> _clickedSubject = BehaviorSubject<bool>();
  Sink<bool> get inClick => _clickedSubject.sink;
  final BehaviorSubject<String> _emailSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inEmail => _emailSubject.sink;
  final BehaviorSubject<String> _passwordSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inPassword => _passwordSubject.sink;

////////////////////////////////////////////////////////////////////////////////
  Stream<LoginModel> get login$ => _loginSubject.stream;

  LoginBloc() {
    print('in LoginBloc constractor');
    print(_emailSubject.value);

    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _clickedSubject.switchMap((clicked) async* {
    //       yield await ApiService.login(
    //           _emailSubject.value.trim(), _passwordSubject.value.trim());
    //     }).listen((value) {
    //       _loginSubject.add(value);
    //     });
    //   }
    // });

    _clickedSubject.switchMap((clicked) async* {
      yield await ApiService.login(
          _emailSubject.value.trim(), _passwordSubject.value.trim());
    }).listen((value) {
      _loginSubject.add(value);
    });

    print("mail:${_emailSubject.value},password:${_passwordSubject.value}");
  }

  void dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _clickedSubject.close();
  }
}

import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/register_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc {
  final BehaviorSubject<RegisterModel> _registerSubject =
      BehaviorSubject<RegisterModel>();
////////////////////////////////////////////////////////////////////////////////
  final BehaviorSubject<bool> _clickedSubject = BehaviorSubject<bool>();
  Sink<bool> get inClick => _clickedSubject.sink;
  final BehaviorSubject<String> _emailSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inEmail => _emailSubject.sink;
  final BehaviorSubject<String> _passwordSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inPassword => _passwordSubject.sink;
  final BehaviorSubject<String> _passwordConfirmationSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inPasswordConfirmation => _passwordConfirmationSubject.sink;
  final BehaviorSubject<String> _nameSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inName => _nameSubject.sink;
  final BehaviorSubject<String> _phoneSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inPhone => _phoneSubject.sink;

////////////////////////////////////////////////////////////////////////////////
  Stream<RegisterModel> get register$ => _registerSubject.stream;

  RegisterBloc() {
    print('in LoginBloc constractor');
    print(_emailSubject.value);

    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _clickedSubject.switchMap((clicked) async* {
    //       yield await ApiService.postRegisterModel(
    //           _emailSubject.value.trim(),
    //           _passwordSubject.value.trim(),
    //           _passwordConfirmationSubject.value.trim(),
    //           _nameSubject.value.trim(),
    //           _phoneSubject.value.trim());
    //     }).listen((value) {
    //       print('in RegisterBloc method');
    //       _registerSubject.add(value);
    //     });
    //   }
    // });

    _clickedSubject.switchMap((clicked) async* {
      yield await ApiService.postRegisterModel(
          _emailSubject.value.trim(),
          _passwordSubject.value.trim(),
          _passwordConfirmationSubject.value.trim(),
          _nameSubject.value.trim(),
          _phoneSubject.value.trim());
    }).listen((value) {
      print('in RegisterBloc method');
      _registerSubject.add(value);
    });

    print("mail:${_emailSubject.value},password:${_passwordSubject.value}");
  }

  void dispose() {
    _clickedSubject.close();
    _emailSubject.close();
    _passwordSubject.close();
    _passwordConfirmationSubject.close();
    _nameSubject.close();
    _phoneSubject.close();
  }
}

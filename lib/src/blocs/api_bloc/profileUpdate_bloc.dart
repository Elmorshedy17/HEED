import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/profileUpdate_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:rxdart/rxdart.dart';

class ProfileUpdateBloc {
  final BehaviorSubject<ProfileUpdateModel> _profileUpdateSubject =
      BehaviorSubject<ProfileUpdateModel>();
////////////////////////////////////////////////////////////////////////////////
  final BehaviorSubject<bool> _clickedSubject = BehaviorSubject<bool>();
  Sink<bool> get inClick => _clickedSubject.sink;

  final BehaviorSubject<String> _emailSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inEmail => _emailSubject.sink;

  final BehaviorSubject<String> _phoneSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inPhone => _phoneSubject.sink;

  final BehaviorSubject<String> _passwordSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inPassword => _passwordSubject.sink;

  final BehaviorSubject<String> _nameSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inName => _nameSubject.sink;
////////////////////////////////////////////////////////////////////////////////
  Stream<ProfileUpdateModel> get profileUpdate$ => _profileUpdateSubject.stream;

  ProfileUpdateBloc() {
    print('in LoginBloc constructor');
    print(_emailSubject.value);

    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    // _clickedSubject.switchMap((clicked) async* {
    //   yield await ApiService.postProfileUpdateModel(
    //       _emailSubject.value.trim(),
    //       _phoneSubject.value.trim(),
    //       _passwordSubject.value.trim(),
    //       _nameSubject.value.trim());
    // }).listen((value) {
    //   _profileUpdateSubject.add(value);
    // });
    //   }
    // });

    _clickedSubject.switchMap((clicked) async* {
      yield await ApiService.postProfileUpdateModel(
          _emailSubject.value.trim(),
          _phoneSubject.value.trim(),
          _passwordSubject.value.trim(),
          _nameSubject.value.trim());
    }).listen((value) {
      _profileUpdateSubject.add(value);
    });

    print("mail:${_emailSubject.value},password:${_passwordSubject.value}");
  }

  void dispose() {
    _emailSubject.close();
    _phoneSubject.close();
    _passwordSubject.close();
    _nameSubject.close();
    _clickedSubject.close();
  }
}

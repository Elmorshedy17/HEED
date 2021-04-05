import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/contactAction_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:rxdart/rxdart.dart';

class ContactActionBloc {
  final BehaviorSubject<ContactActionModel> _contactActionSubject =
      BehaviorSubject<ContactActionModel>();
////////////////////////////////////////////////////////////////////////////////
  final BehaviorSubject<bool> _clickedSubject = BehaviorSubject<bool>();
  Sink<bool> get inClick => _clickedSubject.sink;
  final BehaviorSubject<String> _emailSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inEmail => _emailSubject.sink;
  final BehaviorSubject<String> _messageSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inMessage => _messageSubject.sink;
  final BehaviorSubject<String> _nameSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inName => _nameSubject.sink;
  final BehaviorSubject<String> _phoneSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inPhone => _phoneSubject.sink;

////////////////////////////////////////////////////////////////////////////////
  Stream<ContactActionModel> get contactAction$ => _contactActionSubject.stream;

  ContactActionBloc() {
    print('in LoginBloc constractor');
    print(_emailSubject.value);

    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _clickedSubject.switchMap((clicked) async* {
    //       yield await ApiService.postContactActionModel(
    //           _emailSubject.value.trim(),
    //           _messageSubject.value.trim(),
    //           _nameSubject.value.trim(),
    //           _phoneSubject.value.trim());
    //     }).listen((value) {
    //       _contactActionSubject.add(value);
    //     });
    //   }
    // });

    _clickedSubject.switchMap((clicked) async* {
      yield await ApiService.postContactActionModel(
          _emailSubject.value.trim(),
          _messageSubject.value.trim(),
          _nameSubject.value.trim(),
          _phoneSubject.value.trim());
    }).listen((value) {
      _contactActionSubject.add(value);
    });

    print("mail:${_emailSubject.value},password:${_messageSubject.value}");
  }

  void dispose() {
    _clickedSubject.close();
    _emailSubject.close();
    _messageSubject.close();
    _nameSubject.close();
    _phoneSubject.close();
  }
}

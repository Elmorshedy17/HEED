import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/joinRequest_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:rxdart/rxdart.dart';

class JoinUsBloc {
  final BehaviorSubject<JoinUsModel> _joinUsSubject =
      BehaviorSubject<JoinUsModel>();
////////////////////////////////////////////////////////////////////////////////
  final BehaviorSubject<bool> _clickedSubject = BehaviorSubject<bool>();
  Sink<bool> get inClick => _clickedSubject.sink;

  final BehaviorSubject<String> _clinicSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inClinic => _clinicSubject.sink;

  final BehaviorSubject<String> _phoneSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inPhone => _phoneSubject.sink;

  final BehaviorSubject<String> _addressSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inAddress => _addressSubject.sink;

  final BehaviorSubject<String> _nameSubject =
      BehaviorSubject<String>.seeded('');
  Sink<String> get inName => _nameSubject.sink;
////////////////////////////////////////////////////////////////////////////////
  Stream<JoinUsModel> get joinUs$ => _joinUsSubject.stream;

  JoinUsBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _clickedSubject.switchMap((clicked) async* {
    //       yield await ApiService.postJoinUsModel(
    //         _nameSubject.value.trim(),
    //         _clinicSubject.value.trim(),
    //         _addressSubject.value.trim(),
    //         _phoneSubject.value.trim(),
    //       );
    //     }).listen((value) {
    //       _joinUsSubject.add(value);
    //     });
    //   }
    // });

    _clickedSubject.switchMap((clicked) async* {
      yield await ApiService.postJoinUsModel(
        _nameSubject.value.trim(),
        _clinicSubject.value.trim(),
        _addressSubject.value.trim(),
        _phoneSubject.value.trim(),
      );
    }).listen((value) {
      _joinUsSubject.add(value);
    });
  }

  void dispose() {
    _clinicSubject.close();
    _phoneSubject.close();
    _addressSubject.close();
    _nameSubject.close();
    _clickedSubject.close();
  }
}

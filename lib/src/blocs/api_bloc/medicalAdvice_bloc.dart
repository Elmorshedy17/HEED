import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/medicalAdvice_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class MedicalAdviceBloc {
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<MedicalAdviceModel> _medicalAdviceSubject =
      BehaviorSubject<MedicalAdviceModel>();

  Stream<MedicalAdviceModel> get medicalAdvice$ => _medicalAdviceSubject.stream;
  Sink<String> get inLang => _langSubject.sink;

  MedicalAdviceBloc() {
//    locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
//      if (status == InternetStatus.Offline) {
//        _medicalAdviceSubject.addError('Network not available');
//      } else {
//        _langSubject.switchMap((lang) async* {
//          yield await ApiService.getMedicalAdviceModel(lang);
//        }).listen((value) {
//          _medicalAdviceSubject.add(value);
//        });
//      }
//    });

    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getMedicalAdviceModel(lang);
    //     }).listen((value) {
    //       _medicalAdviceSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getMedicalAdviceModel(lang);
    }).listen((value) {
      _medicalAdviceSubject.add(value);
    });
  }
}

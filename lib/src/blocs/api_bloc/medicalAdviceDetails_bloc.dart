import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/medicalAdviceDetails_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class MedicalAdviceDetailsBloc {
  final int id;
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<MedicalAdviceDetailsModel>
      _medicalAdviceDetailsSubject =
      BehaviorSubject<MedicalAdviceDetailsModel>();

  Stream<MedicalAdviceDetailsModel> get medicalAdviceDetails$ =>
      _medicalAdviceDetailsSubject.stream;
  Sink<String> get inLang => _langSubject.sink;

  MedicalAdviceDetailsBloc({this.id}) {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getMedicalAdviceDetailsModel(lang, id);
    //     }).listen((value) {
    //       _medicalAdviceDetailsSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getMedicalAdviceDetailsModel(lang, id);
    }).listen((value) {
      _medicalAdviceDetailsSubject.add(value);
    });
  }
}

import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/clinics_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class OurClinicsBloc {
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  // final BehaviorSubject<String> _filterSubject =
  //     BehaviorSubject<String>.seeded('');
  final BehaviorSubject<ClinicsModel> _ourClinicsSubject =
      BehaviorSubject<ClinicsModel>();

  Stream<ClinicsModel> get ourClinics$ => _ourClinicsSubject.stream;
  Sink<String> get inLang => _langSubject.sink;
  // Sink<String> get inFilter => _filterSubject.sink;

  OurClinicsBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getOurClinicsModel(
    //         lang,
    //       );
    //       // filter: _filterSubject.value.toString());
    //     }).listen((value) {
    //       _ourClinicsSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getOurClinicsModel(
        lang,
      );
      // filter: _filterSubject.value.toString());
    }).listen((value) {
      _ourClinicsSubject.add(value);
    });
  }
  dispose() {
    // _filterSubject.close();
  }
}

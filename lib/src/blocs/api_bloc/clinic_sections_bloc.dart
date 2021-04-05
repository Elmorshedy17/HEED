import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/clinic_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class ClinicSectionsBloc {
  final int id;
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<ClinicModel> _clinicsSubject =
      BehaviorSubject<ClinicModel>();

  Stream<ClinicModel> get clinicStream$ => _clinicsSubject.stream;
  Sink<String> get inLang => _langSubject.sink;

  ClinicSectionsBloc({this.id}) {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getClinicModel(lang, id);
    //     }).listen((value) {
    //       _clinicsSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getClinicModel(lang, id);
    }).listen((value) {
      _clinicsSubject.add(value);
    });
  }
}

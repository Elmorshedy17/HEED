import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/about_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class AboutBloc {
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<AboutModel> _aboutSubject =
      BehaviorSubject<AboutModel>();

  Stream<AboutModel> get about$ => _aboutSubject.stream;
  Sink<String> get inLang => _langSubject.sink;

  AboutBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getAboutModel(lang);
    //     }).listen((value) {
    //       _aboutSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getAboutModel(lang);
    }).listen((value) {
      _aboutSubject.add(value);
    });
  }
}

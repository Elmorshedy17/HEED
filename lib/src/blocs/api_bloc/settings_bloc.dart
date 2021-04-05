import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/setting_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<SettingModel> _settingSubject =
      BehaviorSubject<SettingModel>();

  Stream<SettingModel> get setting$ => _settingSubject.stream;
  Sink<String> get inLang => _langSubject.sink;

  SettingsBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getSettingModel(lang);
    //     }).listen((value) {
    //       _settingSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getSettingModel(lang);
    }).listen((value) {
      _settingSubject.add(value);
    });
  }
}

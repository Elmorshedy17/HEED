import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/profileInfo_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class ProfileInfoBloc {
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<ProfileInfoModel> _profileInfoSubject =
      BehaviorSubject<ProfileInfoModel>();

  Stream<ProfileInfoModel> get profileInfo$ => _profileInfoSubject.stream;
  Sink<String> get inLang => _langSubject.sink;

  ProfileInfoBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getProfileInfoModel(lang);
    //     }).listen((value) {
    //       _profileInfoSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getProfileInfoModel(lang);
    }).listen((value) {
      _profileInfoSubject.add(value);
    });
  }
}

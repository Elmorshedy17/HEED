import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/contactInfo_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class ContactInfoBloc {
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<ContactInfoModel> _contactInfoSubject =
      BehaviorSubject<ContactInfoModel>();

  Stream<ContactInfoModel> get contactInfo$ => _contactInfoSubject.stream;
  Sink<String> get inLang => _langSubject.sink;

  ContactInfoBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getContactInfoModel(lang);
    //     }).listen((value) {
    //       _contactInfoSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getContactInfoModel(lang);
    }).listen((value) {
      _contactInfoSubject.add(value);
    });
  }
}

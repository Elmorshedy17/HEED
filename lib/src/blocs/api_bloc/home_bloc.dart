import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/homeScreen_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<HomeScreenModel> _homeSubject =
      BehaviorSubject<HomeScreenModel>();

  Stream<HomeScreenModel> get home$ => _homeSubject.stream;
  Sink<String> get inLang => _langSubject.sink;
  HomeBloc() {
    _langSubject.switchMap((lang) async* {
      yield await ApiService.getHomeScreen(lang);
    }).listen((value) {
      _homeSubject.add(value);
    });
  }
}

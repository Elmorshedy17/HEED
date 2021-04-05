import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/favorites_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesBloc {
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);

  final BehaviorSubject<FavoritesModel> _favoritesSubject =
      BehaviorSubject<FavoritesModel>();

  Stream<FavoritesModel> get favorites$ => _favoritesSubject.stream;
  Sink<String> get inLang => _langSubject.sink;

  FavoritesBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getFavoritesModel(lang);
    //     }).listen((value) {
    //       _favoritesSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getFavoritesModel(lang);
    }).listen((value) {
      _favoritesSubject.add(value);
    });
  }
}

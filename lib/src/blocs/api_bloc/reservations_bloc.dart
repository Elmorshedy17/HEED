import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/reservations_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class ReservationsBloc {
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<ReservationsModel> _reservationsSubject =
      BehaviorSubject<ReservationsModel>();

  Stream<ReservationsModel> get reservations$ => _reservationsSubject.stream;
  Sink<String> get inLang => _langSubject.sink;

  ReservationsBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getReservationsModel(lang);
    //     }).listen((value) {
    //       _reservationsSubject.add(value);
    //     });
    //   }
    // });

    _langSubject.switchMap((lang) async* {
      yield await ApiService.getReservationsModel(lang);
    }).listen((value) {
      _reservationsSubject.add(value);
    });
  }
}

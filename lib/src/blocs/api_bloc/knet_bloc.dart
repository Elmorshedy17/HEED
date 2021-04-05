import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/checkout_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class KnetBloc {
  final BehaviorSubject<String> _urlSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<CheckoutModel> _knetSubject =
      BehaviorSubject<CheckoutModel>();

  Stream<CheckoutModel> get knet$ => _knetSubject.stream;
  Sink<String> get inUrl => _urlSubject.sink;

  KnetBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _urlSubject.switchMap((url) async* {
    //       yield await ApiService.getKnetScreen(url);
    //     }).listen((value) {
    //       _knetSubject.add(value);
    //     });
    //   }
    // });

    _urlSubject.switchMap((url) async* {
      yield await ApiService.getKnetScreen(url);
    }).listen((value) {
      _knetSubject.add(value);
    });
  }
}

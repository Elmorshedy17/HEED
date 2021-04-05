import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/notifications_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsBloc {
  BehaviorSubject<bool> _isClickedSubject = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<int> _countSubject = BehaviorSubject<int>();
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  final BehaviorSubject<NotificationsModel> _notificationSubject =
      BehaviorSubject<NotificationsModel>();

  Stream<NotificationsModel> get notifications$ => _notificationSubject.stream;
  Sink<String> get inLang => _langSubject.sink;
  Stream<int> get count$ => _countSubject.stream;
  Sink<bool> get inClicked => _isClickedSubject.sink;

  NotificationsBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _langSubject.switchMap((lang) async* {
    //       yield await ApiService.getNotificationsModel(lang);
    //     }).listen((value) {
    //       _notificationSubject.add(value);
    //     });

    //     _notificationSubject.listen((data) => _countSubject
    //         .add(_isClickedSubject.value ? 0 : data.data.notifications.length));
    //   }
    // });

//    locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
//      if (status == InternetStatus.Offline) {
//        _notificationSubject.addError('Network not available');
//        _countSubject.addError('Network not available');
//      } else {
//        _langSubject.switchMap((lang) async* {
//          yield await ApiService.getNotificationsModel(lang);
//        }).listen((value) {
//          _notificationSubject.add(value);
//        });
//
//        _notificationSubject.listen((data) => _countSubject
//            .add(_isClickedSubject.value ? 0 : data.data.notifications.length));
//      }
//    });
    _langSubject.switchMap((lang) async* {
      yield await ApiService.getNotificationsModel(lang);
    }).listen((value) {
      _notificationSubject.add(value);
    });

    _notificationSubject.listen((data) => _countSubject
        .add(_isClickedSubject.value ? 0 : data.data.notifications.length));
  }

  dispose() {
    _isClickedSubject.close();
  }
}

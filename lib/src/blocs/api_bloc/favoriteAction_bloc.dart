import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/favoritesAction_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteActionBloc {
  final int id;
  final BehaviorSubject<String> _actionSubject = BehaviorSubject<String>();
  final BehaviorSubject<FavoritesActionsModel> _favoriteActionSubject =
      BehaviorSubject<FavoritesActionsModel>();

  final BehaviorSubject<bool> _clickedSubject = BehaviorSubject<bool>();
  Sink<bool> get inClick => _clickedSubject.sink;

  Stream<FavoritesActionsModel> get favoriteAction$ =>
      _favoriteActionSubject.stream;
  Sink<String> get inAction => _actionSubject.sink;

  FavoriteActionBloc({this.id}) {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _clickedSubject.switchMap((clicked) async* {
    //       yield await ApiService.postFavoritesActionsModel(
    //           _actionSubject.value.trim(), id);
    //     }).listen((value) {
    //       _favoriteActionSubject.add(value);
    //     });
    //   }
    // });

    _clickedSubject.switchMap((clicked) async* {
      yield await ApiService.postFavoritesActionsModel(
          _actionSubject.value.trim(), id);
    }).listen((value) {
      _favoriteActionSubject.add(value);
    });
  }

  dispose() {
    _actionSubject.close();
  }
}

import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/category_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class ClinicsBloc {
  final int id;
  final BehaviorSubject<String> _langSubject =
      BehaviorSubject<String>.seeded(locator<PrefsService>().appLanguage);
  // final BehaviorSubject<String> _filterSubject =
  //     BehaviorSubject<String>.seeded('');
  final BehaviorSubject<CategoryModel> _clinicsSubject =
      BehaviorSubject<CategoryModel>();

  Stream<CategoryModel> get clinics$ => _clinicsSubject.stream;
  Sink<String> get inLang => _langSubject.sink;
  // Sink<String> get inFilter => _filterSubject.sink;

  ClinicsBloc({this.id}) {
    _langSubject.switchMap((lang) async* {
      yield await ApiService.getCategoryModel(
        lang,
        id,
      );
      // filter: _filterSubject.value.toString());
    }).listen((value) {
      _clinicsSubject.add(value);
    });
  }

  dispose() {
    // _filterSubject.close();
  }
}

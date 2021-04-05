import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/category_model.dart';
import 'package:rxdart/rxdart.dart';

class ClinicsSearchBloc {
  final PublishSubject<String> _querySubject = PublishSubject<String>();
  final BehaviorSubject<List<Clinics>> _clinicsSearchSubject =
      BehaviorSubject<List<Clinics>>();
  final PublishSubject<List<Clinics>> _filteredClinicsSubject =
      PublishSubject<List<Clinics>>();
  Sink<List<Clinics>> get inClinics => _clinicsSearchSubject.sink;
  Sink<String> get inQuery => _querySubject.sink;
  Stream<String> get query$ => _querySubject.stream;
  Stream<List<Clinics>> get filteredClinics$ => _filteredClinicsSubject.stream;
  Stream<List<Clinics>> get allClinics$ => _clinicsSearchSubject.stream;

  ClinicsSearchBloc() {
    _querySubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((query) async* {
      yield await SearchService.search(query);
    }).listen((list) async {
      _filteredClinicsSubject.add(list);
    });
  }

  dispose() {
    _querySubject.close();
    _clinicsSearchSubject.close();
  }
}

class SearchService {
  static Future<List<Clinics>> search(String query) async {
    List<Clinics> filteredClinics = [];
    locator<ClinicsSearchBloc>().allClinics$.listen((clinics) {
      for (var item in clinics) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          filteredClinics.add(item);
        }
      }
    });
    return filteredClinics;
  }
}

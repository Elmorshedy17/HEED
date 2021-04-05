import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/medicalAdvice_model.dart';
import 'package:rxdart/rxdart.dart';

class MedicalSearchBloc {
  final PublishSubject<String> _querySubject = PublishSubject<String>();
  final BehaviorSubject<List<MedicalAdvice>> _medicalSearchSubject =
      BehaviorSubject<List<MedicalAdvice>>();
  final PublishSubject<List<MedicalAdvice>> _filteredMedicalSubject =
      PublishSubject<List<MedicalAdvice>>();
  Sink<List<MedicalAdvice>> get inMedical => _medicalSearchSubject.sink;
  Sink<String> get inQuery => _querySubject.sink;
  Stream<String> get query$ => _querySubject.stream;
  Stream<List<MedicalAdvice>> get filteredMedical$ =>
      _filteredMedicalSubject.stream;
  Stream<List<MedicalAdvice>> get allMedical$ => _medicalSearchSubject.stream;

  MedicalSearchBloc() {
    _querySubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((query) async* {
      yield await SearchService.search(query);
    }).listen((list) async {
      _filteredMedicalSubject.add(list);
    });
  }

  dispose() {
    _querySubject.close();
    _medicalSearchSubject.close();
  }
}

class SearchService {
  static Future<List<MedicalAdvice>> search(String query) async {
    List<MedicalAdvice> filteredClinics = [];
    locator<MedicalSearchBloc>().allMedical$.listen((medicalAdvice) {
      for (var item in medicalAdvice) {
        if (item.title.toLowerCase().contains(query.toLowerCase())) {
          filteredClinics.add(item);
        }
      }
    });
    return filteredClinics;
  }
}

import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/clinic_model.dart';
import 'package:rxdart/rxdart.dart';

class DoctorsSearchBloc {
  final PublishSubject<String> _querySubject = PublishSubject<String>();
  final BehaviorSubject<List<Doctors>> _doctorsSearchSubject =
      BehaviorSubject<List<Doctors>>();
  final PublishSubject<List<Doctors>> _filteredDoctorsSubject =
      PublishSubject<List<Doctors>>();
  Sink<List<Doctors>> get inDoctors => _doctorsSearchSubject.sink;
  Sink<String> get inQuery => _querySubject.sink;
  Stream<String> get query$ => _querySubject.stream;
  Stream<List<Doctors>> get filteredDoctors$ => _filteredDoctorsSubject.stream;
  Stream<List<Doctors>> get allDoctors$ => _doctorsSearchSubject.stream;

  DoctorsSearchBloc() {
    _querySubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((query) async* {
      yield await SearchService.search(query);
    }).listen((list) async {
      _filteredDoctorsSubject.add(list);
    });
  }

  dispose() {
    _querySubject.close();
    _doctorsSearchSubject.close();
  }
}

class SearchService {
  static Future<List<Doctors>> search(String query) async {
    List<Doctors> filteredClinics = [];
    locator<DoctorsSearchBloc>().allDoctors$.listen((clinics) {
      for (var item in clinics) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          filteredClinics.add(item);
        }
      }
    });
    return filteredClinics;
  }
}

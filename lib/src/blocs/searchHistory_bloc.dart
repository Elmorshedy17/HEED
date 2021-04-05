import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/reservations_model.dart';
import 'package:rxdart/rxdart.dart';

class HistorySearchBloc {
  final PublishSubject<String> _querySubject = PublishSubject<String>();
  final BehaviorSubject<List<Reservations>> _historySearchSubject =
      BehaviorSubject<List<Reservations>>();
  final PublishSubject<List<Reservations>> _filteredHistorySubject =
      PublishSubject<List<Reservations>>();
  Sink<List<Reservations>> get inHistory => _historySearchSubject.sink;
  Sink<String> get inQuery => _querySubject.sink;
  Stream<String> get query$ => _querySubject.stream;
  Stream<List<Reservations>> get filteredHistory$ =>
      _filteredHistorySubject.stream;
  Stream<List<Reservations>> get allHistory$ => _historySearchSubject.stream;

  HistorySearchBloc() {
    _querySubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((query) async* {
      yield await SearchService.search(query);
    }).listen((list) async {
      _filteredHistorySubject.add(list);
    });
  }

  dispose() {
    _querySubject.close();
    _historySearchSubject.close();
  }
}

class SearchService {
  static Future<List<Reservations>> search(String query) async {
    List<Reservations> filteredClinics = [];
    locator<HistorySearchBloc>().allHistory$.listen((reservations) {
      for (var item in reservations) {
        if (item.clinic.toLowerCase().contains(query.toLowerCase())) {
          filteredClinics.add(item);
        }
      }
    });
    return filteredClinics;
  }
}

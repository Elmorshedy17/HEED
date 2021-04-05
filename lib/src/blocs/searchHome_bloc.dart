import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/homeScreen_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeSearchBloc {
  final PublishSubject<String> _querySubject = PublishSubject<String>();
  final BehaviorSubject<List<Categories>> _homeSearchSubject =
      BehaviorSubject<List<Categories>>();
  final PublishSubject<List<Categories>> _filteredHomeSubject =
      PublishSubject<List<Categories>>();
  Sink<List<Categories>> get inHome => _homeSearchSubject.sink;
  Sink<String> get inQuery => _querySubject.sink;
  Stream<String> get query$ => _querySubject.stream;
  Stream<List<Categories>> get filteredHome$ => _filteredHomeSubject.stream;
  Stream<List<Categories>> get allHome$ => _homeSearchSubject.stream;

  HomeSearchBloc() {
    _querySubject
        .debounceTime(Duration(milliseconds: 500))
        .switchMap((query) async* {
      yield await SearchService.search(query);
    }).listen((list) async {
      _filteredHomeSubject.add(list);
    });
  }

  dispose() {
    _querySubject.close();
    _homeSearchSubject.close();
  }
}

class SearchService {
  static Future<List<Categories>> search(String query) async {
    List<Categories> filteredCategories = [];
    locator<HomeSearchBloc>().allHome$.listen((categories) {
      for (var item in categories) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          filteredCategories.add(item);
        }
      }
    });
    return filteredCategories;
  }
}

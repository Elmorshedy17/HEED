// import 'package:heed/locator.dart';
// import 'package:heed/src/models/api_models/GET/category_model.dart';
// import 'package:rxdart/rxdart.dart';

// class ClinicsAdsManager {
//   final PublishSubject<int> _querySubject = PublishSubject<int>();
//   final BehaviorSubject<List<Clinics>> _clinicsSearchSubject =
//       BehaviorSubject<List<Clinics>>();
//   final PublishSubject<List<Clinics>> _filteredClinicsSubject =
//       PublishSubject<List<Clinics>>();
//   Sink<List<Clinics>> get inClinics => _clinicsSearchSubject.sink;
//   Sink<int> get inQuery => _querySubject.sink;
//   Stream<int> get query$ => _querySubject.stream;
//   Stream<List<Clinics>> get filteredClinics$ => _filteredClinicsSubject.stream;
//   Stream<List<Clinics>> get allClinics$ => _clinicsSearchSubject.stream;

//   ClinicsAdsManager() {
//     _querySubject
//         .debounceTime(Duration(milliseconds: 500))
//         .switchMap((query) async* {
//       yield await SearchService.search(query);
//     }).listen((list) async {
//       _filteredClinicsSubject.add(list);
//     });
//   }

//   dispose() {
//     _querySubject.close();
//     _clinicsSearchSubject.close();
//   }
// }

// class SearchService {
//   static Future<List<Clinics>> search(int query) async {
//     List<Clinics> filteredClinics = [];
//     locator<ClinicsAdsManager>().allClinics$.listen((clinics) {
//       for (var item in clinics) {
//         if (item.id == query) {
//           filteredClinics.add(item);
//         }
//       }
//     });
//     return filteredClinics;
//   }
// }

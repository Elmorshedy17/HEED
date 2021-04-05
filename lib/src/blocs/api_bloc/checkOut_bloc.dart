import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/POST/checkout_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:rxdart/rxdart.dart';

class CheckOutBloc {
  //           you can say this is the main one           //

  final BehaviorSubject<CheckoutModel> _checkOutSubject =
      BehaviorSubject<CheckoutModel>();

  //
  Stream<CheckoutModel> get checkOut$ => _checkOutSubject.stream;

  dynamic get currentCheckOut => _checkOutSubject.value;

  ////////////////////////////////  ID  ///////////////////////////////////////////
  final BehaviorSubject<String> _idSubject = BehaviorSubject<String>.seeded('');

  ////
  Sink<String> get inId => _idSubject.sink;

  /////////////////////////////////  Time  ////////////////////////////////////////////
  final BehaviorSubject<String> _timeSubject =
      BehaviorSubject<String>.seeded('');

  ////
  Sink<String> get inTime => _timeSubject.sink;

  /////////////////////////////////  Date  ////////////////////////////////////////////

  final BehaviorSubject<String> _dateSubject =
      BehaviorSubject<String>.seeded('');

////
  Sink<String> get inDate => _dateSubject.sink;

  /////////////////////////////////  PayType  ////////////////////////////////////////////

  final BehaviorSubject<String> _PayTypeSubject =
      BehaviorSubject<String>.seeded('');

////
  Sink<String> get inPayType => _PayTypeSubject.sink;
  ////////
  String get currentPayment => _PayTypeSubject.value;

  /////////////////////////////////  name  ////////////////////////////////////////////

  final BehaviorSubject<String> _nameSubject =
      BehaviorSubject<String>.seeded('');

////
  Sink<String> get inName => _nameSubject.sink;

  /////////////////////////////////  phone  ////////////////////////////////////////////

  final BehaviorSubject<String> _phoneSubject =
      BehaviorSubject<String>.seeded('');

////
  Sink<String> get inPhone => _phoneSubject.sink;

  /////////////////////////////////  Insurance  ////////////////////////////////////////////

  final BehaviorSubject<String> _insuranceSubject =
      BehaviorSubject<String>.seeded('');

////
  Sink<String> get inInsurance => _insuranceSubject.sink;

  /////////////////////////////////  Clicked  ////////////////////////////////////////////
  final BehaviorSubject<bool> _clickedSubject = BehaviorSubject<bool>();

  //
  Sink<bool> get inClick => _clickedSubject.sink;

  ////////////////////////////////////////////////////////////////////////////////

  CheckOutBloc() {
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Online) {
    //     _clickedSubject.switchMap((clicked) async* {
    //       yield await ApiService.checkOut(
    //           _idSubject.value.trim(),
    //           _dateSubject.value.trim(),
    //           _timeSubject.value.trim(),
    //           _PayTypeSubject.value.trim(),
    //           _nameSubject.value.trim(),
    //           _phoneSubject.value.trim(),
    //           _insuranceSubject.value.trim());
    //     }).listen((value) {
    //       _checkOutSubject.add(value);
    //     });
    //   }
    // });

    _clickedSubject.switchMap((clicked) async* {
      yield await ApiService.checkOut(
          _idSubject.value.trim(),
          _dateSubject.value.trim(),
          _timeSubject.value.trim(),
          _PayTypeSubject.value.trim(),
          _nameSubject.value.trim(),
          _phoneSubject.value.trim(),
          _insuranceSubject.value.trim());
    }).listen((value) {
      _checkOutSubject.add(value);
    });
  }

  void dispose() {
    _timeSubject.close();
    _dateSubject.close();
    _clickedSubject.close();
    _idSubject.close();
    _checkOutSubject.close();
    _insuranceSubject.close();
    _phoneSubject.close();
    _nameSubject.close();
    _PayTypeSubject.close();
  }
}

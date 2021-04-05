import 'dart:async';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class PatientReserveBloc {
  final _timeCtrl = BehaviorSubject<String>();

   get timeStream => _timeCtrl.stream;

  Function(String) get sinkTime => _timeCtrl.add;

  String get currentTime => _timeCtrl.value;

  void timeItem(String time) {
    sinkTime(time);
  }

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 3) {
      sink.add(name);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "enter a valid user name"
          : "ادخل اسم مستخجم صالح");
    }
  });

  final validateConfirmPassword =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (confirmPassword, sink) {
    if (confirmPassword.length > 0) {
      sink.add(confirmPassword);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "please enter your password again"
          : "برجاء ادخال كلمة السر مجددا");
    }
  });

  final validateMobile = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobile, sink) {
    if (mobile.length > 3) {
      sink.add(mobile);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "enter a valid Mobile Number"
          : "ادخل رقم هاتف صالح");
    }
  });

  final _dateCtrl = BehaviorSubject<DateTime>();

  get getDate => _dateCtrl.stream.transform(validateDate);

  Function(DateTime) get setDate => _dateCtrl.add;

  DateTime get currentDate => _dateCtrl.value;

  final validateDate = StreamTransformer<DateTime, DateTime>.fromHandlers(
      handleData: (getDate, sink) {
    if (getDate != null) {
      sink.add(getDate);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "Please choose a date"
          : "برجاء اختيار الوقت");
    }
  });

  final BehaviorSubject<int> radioCtrl = BehaviorSubject();

  int get currentPayment => radioCtrl.value;

   get radioStream => radioCtrl.stream;

  Function(int) get changeRadio => radioCtrl.sink.add;

  int get currentRadio => radioCtrl.value;

  void setValue(val) {
    changeRadio(val);
  }

  final BehaviorSubject<String> _name = BehaviorSubject<String>();
  final BehaviorSubject<String> _mobile = BehaviorSubject<String>();

  String get currentMobile => _mobile.value;
  String get currentName => _name.value;

  Function(String) get changeName => _name.sink.add;

  Function(String) get changeMobile => _mobile.sink.add;

  Stream<String> get name =>
      _name.stream.transform(validateName).asBroadcastStream();

  Stream<String> get mobile =>
      _mobile.stream.transform(validateMobile).asBroadcastStream();

  //
  // Registration button
  Stream<bool> get registerValid => Rx.combineLatest5(
          name, mobile, radioCtrl, getDate, timeStream, (n, m, r, g, t) => true)
      .asBroadcastStream();

  dispose() {
    _name.close();
    _mobile.close();
    _timeCtrl.close();
    radioCtrl.close();
    _dateCtrl.close();
//    registerValid.close();
  }
}

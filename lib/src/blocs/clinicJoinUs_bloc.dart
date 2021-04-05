import 'dart:async';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class ClinicJoinUsBloc {
  final validateClinicName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 3) {
      sink.add(name);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "enter a valid clinic name"
          : "ادخل اسم عيادة صالح");
    }
  });

  final validateClinicRepName = StreamTransformer<String, String>.fromHandlers(
      handleData: (nameClinicRep, sink) {
    if (nameClinicRep.length > 3) {
      sink.add(nameClinicRep);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "enter a valid representative name"
          : "ادخل اسم صالح لممثل العيادة");
    }

//    var item=1;
  });

  final validateMobileClinic = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobileClinic, sink) {
    if (mobileClinic.length > 3) {
      sink.add(mobileClinic);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "enter a valid Mobile Number"
          : "ادخل رقم هاتف صالح");
    }
  });

  final validateLocation = StreamTransformer<String, String>.fromHandlers(
      handleData: (locationClinic, sink) {
    if (locationClinic.length > 3) {
      sink.add(locationClinic);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "enter Location"
          : "ادخل الموقع الجغرافي");
    }
  });

  final BehaviorSubject<String> _nameClinic = BehaviorSubject<String>();
  final BehaviorSubject<String> _nameClinicRep = BehaviorSubject<String>();
  final BehaviorSubject<String> _mobileClinic = BehaviorSubject<String>();
  final BehaviorSubject<String> _locationClinic = BehaviorSubject<String>();

  Function(String) get changeNameClinic => _nameClinic.sink.add;

  Function(String) get changeMobileClinic => _mobileClinic.sink.add;

  Function(String) get changeNameClinicRep => _nameClinicRep.sink.add;

  Function(String) get changeLocationClinic => _locationClinic.sink.add;

  Stream<String> get nameClinic =>
      _nameClinic.stream.transform(validateClinicName).asBroadcastStream();

  Stream<String> get mobileClinic =>
      _mobileClinic.stream.transform(validateMobileClinic).asBroadcastStream();

  Stream<String> get nameClinicRep => _nameClinicRep.stream
      .transform(validateClinicRepName)
      .asBroadcastStream();

  Stream<String> get locationClinic =>
      _locationClinic.stream.transform(validateLocation).asBroadcastStream();

  //
  // Registration button
  Stream<bool> get registerValid => Rx.combineLatest4(
      nameClinic,
      mobileClinic,
      nameClinicRep,
      locationClinic,
      (
        nc,
        mo,
        ncr,
        lc,
      ) =>
          true).asBroadcastStream();

  dispose() {
    _locationClinic.close();
    _mobileClinic.close();
    _nameClinic.close();
    _nameClinicRep.close();
  }
}

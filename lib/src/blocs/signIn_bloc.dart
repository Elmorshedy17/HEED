import 'dart:async';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc {
  final validateMobileInOrEmail =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (mobileOrEmail, sink) {
    if (mobileOrEmail.length > 3) {
      sink.add(mobileOrEmail);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "Incorrect Phone Number Or Email"
          : "بريد الكتروني او رقم هاتف غير صحيح");
    }
  });

  final validatePasswordIn = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 3) {
      sink.add(password);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "password must be at least 3 characters"
          : "كلمة السر يجيب الاتقل عن 3 عناصر");
    }
  });

  final BehaviorSubject<String> _mobileOrEmail = BehaviorSubject<String>();
  final BehaviorSubject<String> _password = BehaviorSubject<String>();

  Function(String) get changeMobileOrEmail => _mobileOrEmail.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Stream<String> get mobileOrEmail =>
      _mobileOrEmail.stream.transform(validateMobileInOrEmail);

  Stream<String> get password => _password.stream.transform(validatePasswordIn);

  Stream<bool> get registerValid =>
      Rx.combineLatest2(password, mobileOrEmail, (p, m) => true);

  dispose() {
    _password.close();
    _mobileOrEmail.close();
  }
}

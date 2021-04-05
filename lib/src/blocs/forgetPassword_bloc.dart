import 'dart:async';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class ForgetPasswordBloc {
  final validateEmailForget =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kEmailRule);
    if (!emailExp.hasMatch(email) || email.isEmpty) {
      sink.addError(locator<PrefsService>().appLanguage == "en"?'Entre your email':"ادخل بريدك الالكتروني");
    } else {
      sink.add(email);
    }
  });

  final BehaviorSubject<String> _emailForget = BehaviorSubject<String>();

//
  Function(String) get changeEmail => _emailForget.sink.add;

  Stream<String> get emailForget =>
      _emailForget.stream.transform(validateEmailForget).asBroadcastStream();
  //
  // Registration button
//  Stream<bool> get registerValid => Observable();

  dispose() {
    _emailForget.close();
  }
}

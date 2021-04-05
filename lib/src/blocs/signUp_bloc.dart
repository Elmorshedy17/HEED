import 'dart:async';
import 'package:flutter/material.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

var passKey = GlobalKey<FormFieldState>();
const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class SignUpBloc {
//
//  var passKey = GlobalKey<FormFieldState>();

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 3) {
      sink.add(name);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "enter a valid user name"
          : "ادخل اسم مستخدم صالح");
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
          : "ادخل كلمة السر مجددا");
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

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kEmailRule);
    if (!emailExp.hasMatch(email) || email.isEmpty) {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? 'Entre a valid email'
          : "ادخل بريد اليكتروني صالح");
    } else {
      sink.add(email);
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError(locator<PrefsService>().appLanguage == "en"
          ? "password must be at least 3 characters"
          : "كلمة السر يجيب الا تقل عن 3 عناصر");
    }
  });
//  bool checkBoxState = false;
// streams of checkBox
  final BehaviorSubject<bool> streamCheckBoxController =
      BehaviorSubject<bool>.seeded(false);
// sink
//  Sink get checkBoxSink => streamCheckBoxController.sink;
// stream
  Stream<bool> get checkBoxStream => streamCheckBoxController.stream;

  bool get _currentState => streamCheckBoxController.value;

// function to change the color
  changeCheckBoxController() {
    streamCheckBoxController.add(!_currentState);
  }
  //Bloc(){colorSink.add(Colors.red);}
//
//// streams of Color
//  final BehaviorSubject<String> termsCheckController = BehaviorSubject<String>();
//// sink
//  Sink get termsCheckSink => termsCheckController.sink;
//// stream
//  Stream<Color> get termsCheckStream => termsCheckController.Observable;
//
//// function to change the color
//  changeColor() {
//    colorSink.add(Colors.red);
//  }
////  Bloc(){colorSink.add(Colors.red);}

  final BehaviorSubject<String> _name = BehaviorSubject<String>();
  final BehaviorSubject<String> _confirmPassword = BehaviorSubject<String>();
  final BehaviorSubject<String> _mobile = BehaviorSubject<String>();
  final BehaviorSubject<String> _password = BehaviorSubject<String>();
  final BehaviorSubject<String> _email = BehaviorSubject<String>();

//
//  final _mobile = StreamController<String>.broadcast();
//  final _confirmPassword = StreamController<String>.broadcast();
//  final _password = StreamController<String>.broadcast();
//  final _email = StreamController<String>.broadcast();

  Function(String) get changeName => _name.sink.add;

  Function(String) get changeMobile => _mobile.sink.add;

  Function(String) get changePasswordConfirmation => _confirmPassword.sink.add;

//
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Stream<String> get name => _name.stream.transform(validateName);

  Stream<String> get mobile => _mobile.stream.transform(validateMobile);

  Stream<String> get confirmPassword =>
      _confirmPassword.stream.transform(validatePassword).doOnData((String c) {
        // If the password is accepted (after validation of the rules)
        // we need to ensure both password and retyped password match
        if (0 != _password.value.compareTo(c)) {
          // If they do not match, add an error
          _confirmPassword.addError(locator<PrefsService>().appLanguage == "en"
              ? "No Match"
              : "غير متطابق مع كلمة السر");
        }
      });

  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get password => _password.stream.transform(validatePassword);

  //
  // Registration button
  Stream<bool> get registerValid => Rx.combineLatest5(
      email, password, confirmPassword, name, mobile, (e, p, c, n, m) => true);

  dispose() {
    _email.close();
    _password.close();
    _confirmPassword.close();
    _name.close();
    _mobile.close();
    streamCheckBoxController.close();
  }
}

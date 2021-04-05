import 'dart:async';
import 'package:flutter/material.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:rxdart/rxdart.dart';

var passKey = GlobalKey<FormFieldState>();
const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class EditProfileBloc {
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

  final validateMobile = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobile, sink) {
    if (mobile.length >= 3) {
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
          : "ادخل بريد الكتروني صالح");
    } else {
      sink.add(email);
    }
  });

//  bool checkBoxState = false;
// streams of checkBox
  final BehaviorSubject<bool> streamEnableEditController =
      BehaviorSubject<bool>.seeded(false);
// sink
//  Sink get checkBoxSink => streamCheckBoxController.sink;
// stream
  Stream<bool> get checkBoxStream => streamEnableEditController.stream;

  bool get _currentState => streamEnableEditController.value;

// function to change the color
  changeEnableEditController() {
    streamEnableEditController.add(!_currentState);
  }

  final BehaviorSubject<String> _name =
      BehaviorSubject<String>.seeded(locator<PrefsService>().userObj.name
          // locator<PrefsService>().registerUser?.name ??
          //     locator<PrefsService>().loginUser.name
          );
  final BehaviorSubject<String> _mobile =
      BehaviorSubject<String>.seeded(locator<PrefsService>().userObj.phone
          // locator<PrefsService>().registerUser?.phone ??
          //     locator<PrefsService>().loginUser.phone
          );
  final BehaviorSubject<String> _email =
      BehaviorSubject<String>.seeded(locator<PrefsService>().userObj.email
          // locator<PrefsService>().registerUser?.email ??
          //     locator<PrefsService>().loginUser.email
          );

  Function(String) get changeName => _name.sink.add;

  Function(String) get changeMobile => _mobile.sink.add;

//
  Function(String) get changeEmail => _email.sink.add;

  Stream<String> get name =>
      _name.stream.transform(validateName).asBroadcastStream();

  Stream<String> get mobile =>
      _mobile.stream.transform(validateMobile).asBroadcastStream();

  Stream<String> get email =>
      _email.stream.transform(validateEmail).asBroadcastStream();

  //
  // Registration button
  Stream<bool> get registerValid =>
      Rx.combineLatest3(email, name, mobile, (e, n, m) => true)
          .asBroadcastStream();

  dispose() {
    _email.close();
    _name.close();
    _mobile.close();
  }
}

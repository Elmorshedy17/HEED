import 'dart:convert';

import 'package:heed/src/models/api_models/POST/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static PrefsService _instance;
  static SharedPreferences _preferences;

  static const String APP_LANGUAGE_KEY = 'language_code';
  static const String APP_COUNTRY_CODE = 'countryCode';
  static const String HAS_CHOSEN_LANGUAGE = 'hasChosenLanguage';
  static const String SIGN_UP_KEY = 'signedUp';
  static const String LOG_IN_KEY = 'loggedIn';
  static const String NOTIFICATION_FlAG = 'notificationFlag';
  static const String IS_CLINICS_FIRST_TIME_OPINING =
      'isClinicsFirstTimeOpining';
  static const String IS_BACK_TO_ONLINE = 'isBackToOnline';
  // static const String HAS_CONNECTION = 'hasConnection';
//  static const String NOTIFICATIONS_COUNT = 'notificationsCount';
  // static const String USER_AUTH = 'userAuth';
  // static const String USER_NAME = 'userName';
  // static const String USER_EMAIL = 'userEmail';
  // static const String USER_PHONE = 'userPhone';
  // static const String USER_OBJ_REGISTER = 'registerUser';
  static const String USER_OBJ = 'user';
  // static const String USER_OBJ_LOGIN = 'loginUser';
  static const String USER_PASSWORD = 'userPassword';

  static Future<PrefsService> getInstance() async {
    if (_instance == null) {
      _instance = PrefsService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  dynamic _getFromPrefs(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  // updated _saveToDisk function that handles all types
  void _saveToPrefs<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    } else if (content is bool) {
      _preferences.setBool(key, content);
    } else if (content is int) {
      _preferences.setInt(key, content);
    } else if (content is double) {
      _preferences.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  // remove from Prefs
  void _removeFromPrefs(String key) {
    _preferences.remove(key);
  }

  // clear all Prefs
  void clearAllPrefs() {
    _preferences.clear();
  }

/////////////////////////////////////////////////////////////////////////////////
  bool get notificationFlag => _getFromPrefs(NOTIFICATION_FlAG) ?? true;
  set notificationFlag(bool value) => _saveToPrefs(NOTIFICATION_FlAG, value);
////////////////////////////////////////////////////////////////////////////////
  bool get hasSignedUp => _getFromPrefs(SIGN_UP_KEY) ?? false;
  set hasSignedUp(bool value) => _saveToPrefs(SIGN_UP_KEY, value);
////////////////////////////////////////////////////////////////////////////////
  bool get hasLoggedIn => _getFromPrefs(LOG_IN_KEY) ?? false;
  set hasLoggedIn(bool value) => _saveToPrefs(LOG_IN_KEY, value);
////////////////////////////////////////////////////////////////////////////////
  // getter for notificationsCount
//  int get notificationsCount => _getFromPrefs(NOTIFICATIONS_COUNT) ?? 0;
//  // setter for notificationsCount
//  set notificationsCount(int value) => _saveToPrefs(NOTIFICATIONS_COUNT, value);
//  // remove notificationsCount
//  removeNotificationsCount() => _removeFromPrefs(NOTIFICATIONS_COUNT);
////////////////////////////////////////////////////////////////////////////////
  // getter for App language.
  String get appLanguage => _getFromPrefs(APP_LANGUAGE_KEY);
  // setter for App language.
  set appLanguage(String value) => _saveToPrefs(APP_LANGUAGE_KEY, value);
// ////////////////////////////////////////////////////////////////////////////////
  // getter for UserPassword.
  String get userPassword => _getFromPrefs(USER_PASSWORD);
  // setter for UserPassword.
  set userPassword(String value) => _saveToPrefs(USER_PASSWORD, value);
////////////////////////////////////////////////////////////////////////////////
  // getter for country code.
  String get countryCode => _getFromPrefs(APP_COUNTRY_CODE);
  // setter for country code.
  set countryCode(String value) => _saveToPrefs(APP_COUNTRY_CODE, value);
////////////////////////////////////////////////////////////////////////////////
  bool get hasChosenLanguage => _getFromPrefs(HAS_CHOSEN_LANGUAGE) ?? false;
  set hasChosenLanguage(bool value) => _saveToPrefs(HAS_CHOSEN_LANGUAGE, value);
////////////////////////////////////////////////////////////////////////////////
  bool get isClinicsFirstTimeOpining =>
      _getFromPrefs(IS_CLINICS_FIRST_TIME_OPINING) ?? false;
  set isClinicsFirstTimeOpining(bool value) =>
      _saveToPrefs(IS_CLINICS_FIRST_TIME_OPINING, value);
////////////////////////////////////////////////////////////////////////////////
  bool get isBackToOnline => _getFromPrefs(IS_BACK_TO_ONLINE) ?? false;
  set isBackToOnline(bool value) => _saveToPrefs(IS_BACK_TO_ONLINE, value);
////////////////////////////////////////////////////////////////////////////////
  // bool get hasConnection => _getFromPrefs(HAS_CONNECTION) ?? false;
  // set hasConnection(bool value) => _saveToPrefs(HAS_CONNECTION, value);
////////////////////////////////////////////////////////////////////////////////
  // getter for USER_OBJECT from RegisterModel.
  User get userObj {
    var userJson = _getFromPrefs(USER_OBJ);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(json.decode(userJson));
  }

  // setter for USER_OBJECT.
  set userObj(User userToSave) {
    _saveToPrefs(USER_OBJ, json.encode(userToSave.toJson()));
  }

  // Remove UserObj
  removeUserObj() => _removeFromPrefs(USER_OBJ);
////////////////////////////////////////////////////////////////////////////////
//   // getter for UserAuth.
//   String get userAuth => _getFromPrefs(USER_AUTH);
//   // setter for UserAuth.
//   set userAuth(String value) => _saveToPrefs(USER_AUTH, value);
// ////////////////////////////////////////////////////////////////////////////////
//   // getter for USER_NAME.
//   String get userName => _getFromPrefs(USER_NAME);
//   // setter for USER_NAME.
//   set userName(String value) => _saveToPrefs(USER_NAME, value);
// ////////////////////////////////////////////////////////////////////////////////
//   // getter for USER_EMAIL.
//   String get userEmail => _getFromPrefs(USER_EMAIL);
//   // setter for USER_EMAIL.
//   set userEmail(String value) => _saveToPrefs(USER_EMAIL, value);
////////////////////////////////////////////////////////////////////////////////

  // // getter for USER_PHONE.
  // String get userPhone => _getFromPrefs(USER_PHONE);
  // // setter for USER_PHONE.
  // set userPhone(String value) => _saveToPrefs(USER_PHONE, value);
////////////////////////////////////////////////////////////////////////////////

  // getter for USER_OBJECT from RegisterModel.
  // registerModel.User get registerUser {
  //   var userJson = _getFromPrefs(USER_OBJ_REGISTER);
  //   if (userJson == null) {
  //     return null;
  //   }

  //   return registerModel.User.fromJson(json.decode(userJson));
  // }

  // // setter for USER_OBJECT.
  // set registerUser(registerModel.User userToSave) {
  //   _saveToPrefs(USER_OBJ_REGISTER, json.encode(userToSave.toJson()));
  // }

  // removeRegisterUser() => _removeFromPrefs(USER_OBJ_REGISTER);
////////////////////////////////////////////////////////////////////////////////

}

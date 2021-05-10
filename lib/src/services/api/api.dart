import 'dart:io';
import 'package:dio/dio.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/models/api_models/GET/about_model.dart';
import 'package:heed/src/models/api_models/GET/category_model.dart';
import 'package:heed/src/models/api_models/GET/clinic_model.dart';
import 'package:heed/src/models/api_models/GET/clinics_model.dart';
import 'package:heed/src/models/api_models/GET/contactInfo_model.dart';
import 'package:heed/src/models/api_models/GET/favorites_model.dart';
import 'package:heed/src/models/api_models/GET/homeScreen_model.dart';
import 'package:heed/src/models/api_models/GET/medicalAdviceDetails_model.dart';
import 'package:heed/src/models/api_models/GET/medicalAdvice_model.dart';
import 'package:heed/src/models/api_models/GET/notifications_model.dart';
import 'package:heed/src/models/api_models/GET/profileInfo_model.dart';
import 'package:heed/src/models/api_models/GET/reservations_model.dart';
import 'package:heed/src/models/api_models/GET/setting_model.dart';
import 'package:heed/src/models/api_models/POST/checkTime_model.dart';
import 'package:heed/src/models/api_models/POST/checkout_model.dart';
import 'package:heed/src/models/api_models/POST/contactAction_model.dart';
import 'package:heed/src/models/api_models/POST/favoritesAction_model.dart';
import 'package:heed/src/models/api_models/POST/forgetPassword_model.dart';
import 'package:heed/src/models/api_models/POST/joinRequest_model.dart';
import 'package:heed/src/models/api_models/POST/login_model.dart';
import 'package:heed/src/models/api_models/POST/profileUpdate_model.dart';
import 'package:heed/src/models/api_models/POST/register_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/blocs/firebase_token.dart';
import 'Api_Constants.dart';

class ApiService {
  String firebaseToken = locator<FirebaseTokenBloc>().currentFirebaseToken;

  // Fetch home screen
  static Future<HomeScreenModel> getHomeScreen(String lang) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

//
//    dio.interceptors.add(LogInterceptor(
//      responseBody: true,
//      request: true,
//      requestHeader: true,
//      requestBody: true,
//      responseHeader: true,
//    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response = await dio.get("$BASE_URL$HomeScreen_VAR");
      print("home response $response");
      return HomeScreenModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  // Fetch knet
  static Future<CheckoutModel> getKnetScreen(String url) async {
    final dio = Dio();
    try {
      Response response = await dio.get(url);
      return CheckoutModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
// Fetch CategoryModel
  static Future<CategoryModel> getCategoryModel(
    String lang,
    int id,
  ) async {
    // {String filter = ''}) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response = await dio.get("$BASE_URL$CATEGORY_VAR$id");
      // await dio.get("$BASE_URL$CATEGORY_VAR$id?sort=$filter");
      return CategoryModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////

// Fetch ClinicSectionsModel
  static Future<ClinicModel> getClinicModel(String lang, int id) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response = await dio.get("$BASE_URL$CLINIC_VAR$id");
      return ClinicModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
// Fetch MedicalAdvice
  static Future<MedicalAdviceModel> getMedicalAdviceModel(String lang) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response = await dio.get("$BASE_URL$MEDICAL_ADVICE_VAR");
      return MedicalAdviceModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
// Fetch MedicalAdviceDetailsModel
  static Future<MedicalAdviceDetailsModel> getMedicalAdviceDetailsModel(
      String lang, int id) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response =
          await dio.get("$BASE_URL$MEDICAL_ADVICE_DETAILS_VAR$id");
      return MedicalAdviceDetailsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
// Fetch NotificationsModel
  static Future<NotificationsModel> getNotificationsModel(String lang) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response = await dio.get("$BASE_URL$NOTIFICATIONS_VAR");
      return NotificationsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////////////////////
// Fetch SettingModel
  static Future<SettingModel> getSettingModel(String lang) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response = await dio.get("$BASE_URL$SETTING_VAR");
      return SettingModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
// Fetch AboutModel
  static Future<AboutModel> getAboutModel(String lang) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response = await dio.get("$BASE_URL$ABOUT_VAR");
      return AboutModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
// Fetch ProfileInfoModel TODO
//  static Future<ProfileInfoModel> getProfileInfoModel(String lang) async {
//    final dio = Dio();
//
//    dio.interceptors.add(
//      InterceptorsWrapper(
//        onRequest: (options,handler) {
//          options.headers[LANG_HEADER] = lang;
//          options.headers[AUTH_HEADER]=locator<PrefsService>().userAuth;
//          return handler.next(options);
//        },
//      ),
//    );
//    try {
//      Response response = await dio.get("$BASE_URL$PROFILE_INFO_VAR");
//      return ProfileInfoModel.fromJson(response.data);
//    } catch (error, stacktrace) {
//      print("Exception occured: $error stackTrace: $stacktrace");
//      return null;
//    }
//  }

////////////////////////////////////////////////////////////////////////////////
  // fetch ContactInfoModel
  static Future<ContactInfoModel> getContactInfoModel(String lang) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    try {
      Response response = await dio.get(
        '$BASE_URL$CONTACT_INFO_VAR',
        options: Options(
          headers: {
            LANG_HEADER: lang,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return ContactInfoModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
  //!  fetch ProfileInfoModel => replaced with shared preferences stored user object
  static Future<ProfileInfoModel> getProfileInfoModel(String lang) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    try {
      Response response = await dio.get(
        '$BASE_URL$PROFILE_INFO_VAR',
        options: Options(
          headers: {
            LANG_HEADER: lang,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return ProfileInfoModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////
  //  fetch ClinicsModel => OurClinics
  static Future<ClinicsModel> getOurClinicsModel(
    String lang,
  ) async {
    // {String filter = ''}) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    try {
      Response response = await dio.get(
        '$BASE_URL$CLINICS_VAR',
        // '$BASE_URL$CLINICS_VAR?sort=$filter',
        options: Options(
          headers: {
            LANG_HEADER: lang,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return ClinicsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////////////////////
// Fetch FavoritesModel
  static Future<FavoritesModel> getFavoritesModel(String lang) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response = await dio.get(
        "$BASE_URL$FAVORITES_VAR",
      );
      return FavoritesModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

///////////////////////////////////////////////////////////////////////////////
  /// Fetch ReservationsModel
  static Future<ReservationsModel> getReservationsModel(String lang) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options,handler) {
          options.headers[PLATFORM_HEADER] = platform;
          options.headers[FIRE_BASE_TOKEN_HEADER] =
              locator<FirebaseTokenBloc>().currentFirebaseToken;
          options.headers[LANG_HEADER] = lang;
          options.headers[AUTH_HEADER] =
              locator<PrefsService>().userObj?.authorization ?? '';
          return handler.next(options);
        },
      ),
    );
    try {
      Response response = await dio.get(
        "$BASE_URL$RESERVATIONS_VAR",
      );
      return ReservationsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
///////////////////////////Performing a POST request////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  // Post Login
  static Future<LoginModel> login(String email, String password) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    FormData formData =
        FormData.fromMap({"email_phone": email, "password": password});

    try {
      Response response = await dio.post(
        '$BASE_URL$LOGIN_VAR',
        data: formData,
        options: Options(
          headers: {
            LANG_HEADER: locator<PrefsService>().appLanguage,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return LoginModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
  // Post RegisterModel
  static Future<RegisterModel> postRegisterModel(String email, String password,
      String passwordConfirmation, String name, String phone) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    FormData formData = FormData.fromMap({
      "email": email,
      "password": password,
      'password_confirmation': passwordConfirmation,
      'name': name,
      'phone': phone
    });

    try {
      Response response = await dio.post(
        '$BASE_URL$REGISTER_VAR',
        data: formData,
        options: Options(
          headers: {
            LANG_HEADER: locator<PrefsService>().appLanguage,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return RegisterModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
// post Contact us Action Model
  static Future<ContactActionModel> postContactActionModel(
      String email, String message, String name, String phone) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    FormData formData = FormData.fromMap(
        {'name': name, 'message': message, "email": email, 'phone': phone});

    try {
      Response response = await dio.post(
        '$BASE_URL$CONTACT_ACTION_VAR',
        data: formData,
        options: Options(
          headers: {
            LANG_HEADER: locator<PrefsService>().appLanguage,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return ContactActionModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
// post Profile update Model
  static Future<ProfileUpdateModel> postProfileUpdateModel(
      String email, String phone, String password, String name) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    FormData formData = FormData.fromMap(
        {"email": email, 'phone': phone, 'password': password, 'name': name});

    try {
      Response response = await dio.post(
        '$BASE_URL$PROFILE_UPDATE_VAR',
        data: formData,
        options: Options(
          headers: {
            LANG_HEADER: locator<PrefsService>().appLanguage,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return ProfileUpdateModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  // post JoinUs Model
  static Future<JoinUsModel> postJoinUsModel(
      String name, String clinic, String address, String phone) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    FormData formData = FormData.fromMap(
        {"name": name, 'clinic': clinic, 'address': address, 'phone': phone});

    try {
      Response response = await dio.post(
        '$BASE_URL$JOIN_VAR',
        data: formData,
        options: Options(
          headers: {
            LANG_HEADER: locator<PrefsService>().appLanguage,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
            Country_HEADER: '',
          },
        ),
      );
      return JoinUsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////

  // post ForgetPasswordModel
  static Future<ForgetPasswordModel> postForgetPasswordModel(
      String email) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    FormData formData = FormData.fromMap({"email": email});

    try {
      Response response = await dio.post(
        '$BASE_URL$FORGET_PASSWORD_VAR',
        data: formData,
        options: Options(
          headers: {
            LANG_HEADER: locator<PrefsService>().appLanguage,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
            Country_HEADER: '',
          },
        ),
      );
      return ForgetPasswordModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////////////////////
///////////////////////////Performing a POST request////for check time////////////////////////
////////////////////////////////////////////////////////////////////////////////
  // Post CheckTime
  static Future<CheckTimeModel> checkTime(
      String id, String date, String time) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }
//
//    FormData formData =
//        FormData.fromMap({"doctor_id": id, "date": date, "time": time});

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$CHECK_TIME_VAR',
        data: {"doctor_id": id, "date": date, "time": time},
//        formData,
        options: Options(
          headers: {
            LANG_HEADER: locator<PrefsService>().appLanguage,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return CheckTimeModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
///////////////////////////Performing a POST request////for CheckOut////////////////////////
////////////////////////////////////////////////////////////////////////////////
  // Post checkoutmodel
  static Future<CheckoutModel> checkOut(String id, String date, String time,
      String payType, String name, String phone, String insuranceId) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

//    FormData formData = FormData.fromMap({
//      "doctor_id": id,
//      "date": date,
//      "time": time,
//      "pay_type": payType,
//      "name": name,
//      "phone": phone,
//      "insurance_id": insuranceId
//    });

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));

    try {
      Response response = await dio.post(
        '$BASE_URL$CHECKOUT_VAR',
        data: {
          "doctor_id": id,
          "date": date,
          "time": time,
          "pay_type": payType,
          "name": name,
          "phone": phone,
          "insurance_id": insuranceId
        },
        //formData,
        options: Options(
          headers: {
            LANG_HEADER: locator<PrefsService>().appLanguage,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return CheckoutModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////////////////////
  // Post FavoritesActions
  static Future<FavoritesActionsModel> postFavoritesActionsModel(
      String action, int id) async {
    final dio = Dio();

    String platform;

    if (Platform.isAndroid) {
      platform = 'android';
    } else if (Platform.isIOS) {
      platform = 'ios';
    }

    FormData formData = FormData.fromMap({"action": action});

    try {
      Response response = await dio.post(
        '$BASE_URL$FAVORITES_ACTION_VAR$id',
        data: formData,
        options: Options(
          headers: {
            LANG_HEADER: locator<PrefsService>().appLanguage,
            PLATFORM_HEADER: platform,
            FIRE_BASE_TOKEN_HEADER:
                locator<FirebaseTokenBloc>().currentFirebaseToken,
            AUTH_HEADER: locator<PrefsService>().userObj?.authorization ?? '',
          },
        ),
      );
      return FavoritesActionsModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////
//  Performing multiple concurrent requests:
//  response = await Future.wait([dio.post("/info"), dio.get("/token")]);

}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:heed/localizations/app_language.dart';
import 'package:heed/src/blocs/ads_manager.dart';
import 'package:heed/src/blocs/api_bloc/ContactInfo_bloc.dart';
import 'package:heed/src/blocs/api_bloc/aboutUs_bloc.dart';
import 'package:heed/src/blocs/api_bloc/checkOut_bloc.dart';
import 'package:heed/src/blocs/api_bloc/checkTime_bloc.dart';
import 'package:heed/src/blocs/api_bloc/contactAction_bloc.dart';
import 'package:heed/src/blocs/api_bloc/favorites_bloc.dart';
import 'package:heed/src/blocs/api_bloc/forgetPassword_bloc.dart';
import 'package:heed/src/blocs/api_bloc/joinUs_bloc.dart';
import 'package:heed/src/blocs/api_bloc/knet_bloc.dart';
import 'package:heed/src/blocs/api_bloc/login_bloc.dart';
import 'package:heed/src/blocs/api_bloc/medicalAdvice_bloc.dart';
import 'package:heed/src/blocs/api_bloc/notification_bloc.dart';
import 'package:heed/src/blocs/api_bloc/ourClinics_bloc.dart';
import 'package:heed/src/blocs/api_bloc/profileInfo_bloc.dart';
import 'package:heed/src/blocs/api_bloc/profileUpdate_bloc.dart';
import 'package:heed/src/blocs/api_bloc/register_bloc.dart';
import 'package:heed/src/blocs/api_bloc/reservations_bloc.dart';
import 'package:heed/src/blocs/clinic_data_bloc.dart';
import 'package:heed/src/blocs/local_firebase_bloc.dart';
import 'package:heed/src/blocs/offlineOnline.dart';
import 'package:heed/src/blocs/searchDoctors_bloc.dart';
import 'package:heed/src/blocs/searchHistory_bloc.dart';
import 'package:heed/src/blocs/api_bloc/settings_bloc.dart';
import 'package:heed/src/blocs/checkout_bloc.dart';
import 'package:heed/src/blocs/clinicJoinUs_bloc.dart';
import 'package:heed/src/blocs/clinic_tabs.dart';
import 'package:heed/src/blocs/api_bloc/clinics_bloc.dart';
import 'package:heed/src/blocs/contactUs_bloc.dart';
import 'package:heed/src/blocs/currency_bloc.dart';
import 'package:heed/src/blocs/dialog_test_bloc.dart';
import 'package:heed/src/blocs/editProfile_bloc.dart';
import 'package:heed/src/blocs/forgetPassword_bloc.dart';
import 'package:heed/src/blocs/api_bloc/home_bloc.dart';
import 'package:heed/src/blocs/firebase_token.dart';
import 'package:heed/src/blocs/patient_reserve_bloc.dart';
import 'package:heed/src/blocs/searchClinics_bloc.dart';
import 'package:heed/src/blocs/searchHome_bloc.dart';
import 'package:heed/src/blocs/searchMedicalAdvice_bloc.dart';
import 'package:heed/src/blocs/signIn_bloc.dart';
import 'package:heed/src/blocs/signUp_bloc.dart';
import 'package:heed/src/blocs/signup_checkbox_bloc.dart';
import 'package:heed/src/blocs/time_avilabel_bloc.dart';
import 'package:heed/src/blocs/time_date_bridge_bloc.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/permission_service.dart';
import 'package:heed/src/services/prefs_Service.dart';

final GetIt locator = GetIt.instance;

Future setupLocator() async {
  // [Setup services]
  // Setup PrefsService.
  var instance = await PrefsService.getInstance();
  locator.registerSingleton<PrefsService>(instance);

  //Setup PermissionsService.
  // locator.registerLazySingleton<PermissionsService>(() => PermissionsService());

  // Setup ConnectionCheckerService.
  locator.registerLazySingleton<ConnectionCheckerService>(
      () => ConnectionCheckerService());

  // [Setup managers]
  locator.registerLazySingleton<AppLanguage>(() => AppLanguage());
  locator.registerLazySingleton<FirebaseTokenBloc>(() => FirebaseTokenBloc());

  // Forms setting //
  locator.registerLazySingleton<SignUpBloc>(() => SignUpBloc());
  locator.registerLazySingleton<SignInBloc>(() => SignInBloc());
  locator.registerLazySingleton<ForgetPasswordBloc>(() => ForgetPasswordBloc());
  locator.registerLazySingleton<ClinicJoinUsBloc>(() => ClinicJoinUsBloc());
  locator.registerLazySingleton<ContactUsBloc>(() => ContactUsBloc());
  // locator.registerLazySingleton<ItemsClinicsBloc>(() => ItemsClinicsBloc());
  locator.registerLazySingleton<EditProfileBloc>(() => EditProfileBloc());
  locator.registerLazySingleton<ClinicTabsBloc>(() => ClinicTabsBloc());
  locator.registerLazySingleton<PatientReserveBloc>(() => PatientReserveBloc());
  //Api bloc
  locator.registerLazySingleton<HomeBloc>(() => HomeBloc());
//  locator.registerLazySingleton<ClinicsBloc>(() => ClinicsBloc());
  locator.registerLazySingleton<MedicalAdviceBloc>(() => MedicalAdviceBloc());
  locator.registerLazySingleton<NotificationsBloc>(() => NotificationsBloc());
  locator.registerLazySingleton<SettingsBloc>(() => SettingsBloc());
  locator.registerLazySingleton<AboutBloc>(() => AboutBloc());
  locator.registerLazySingleton<LoginBloc>(() => LoginBloc());
  locator.registerLazySingleton<RegisterBloc>(() => RegisterBloc());
  locator.registerLazySingleton<ContactInfoBloc>(() => ContactInfoBloc());
  locator.registerLazySingleton<ContactActionBloc>(() => ContactActionBloc());
  locator.registerLazySingleton<ProfileInfoBloc>(() => ProfileInfoBloc());
  locator.registerLazySingleton<ProfileUpdateBloc>(() => ProfileUpdateBloc());
  locator.registerLazySingleton<JoinUsBloc>(() => JoinUsBloc());
  locator.registerLazySingleton<ForgetPasswordApiBloc>(
      () => ForgetPasswordApiBloc());
  locator.registerLazySingleton<OurClinicsBloc>(() => OurClinicsBloc());
  locator.registerLazySingleton<FavoritesBloc>(() => FavoritesBloc());
  locator.registerLazySingleton<ReservationsBloc>(() => ReservationsBloc());
  locator.registerLazySingleton<CheckTimeBloc>(() => CheckTimeBloc());
  locator.registerLazySingleton<DialogColor>(() => DialogColor());
  locator.registerLazySingleton<CheckOutBloc>(() => CheckOutBloc());
  locator.registerLazySingleton<ChangePageBloc>(() => ChangePageBloc());
  locator.registerLazySingleton<TimeAvailableBloc>(() => TimeAvailableBloc());
  locator.registerLazySingleton<ClinicsSearchBloc>(() => ClinicsSearchBloc());
  locator.registerLazySingleton<HomeSearchBloc>(() => HomeSearchBloc());
  locator.registerLazySingleton<CurrencyBloc>(() => CurrencyBloc());
  locator.registerLazySingleton<HistorySearchBloc>(() => HistorySearchBloc());
  locator.registerLazySingleton<MedicalSearchBloc>(() => MedicalSearchBloc());
  locator.registerLazySingleton<DoctorsSearchBloc>(() => DoctorsSearchBloc());
  locator.registerLazySingleton<ClinicDataBloc>(() => ClinicDataBloc());
  locator.registerLazySingleton<LocalFirebaseBloc>(() => LocalFirebaseBloc());
  locator.registerLazySingleton<TimeDateBridge>(() => TimeDateBridge());
  locator.registerLazySingleton<KnetBloc>(() => KnetBloc());
  locator.registerLazySingleton<OfflineOnlineBloc>(() => OfflineOnlineBloc());
  locator.registerLazySingleton<TextEditingController>(
      () => TextEditingController());
}

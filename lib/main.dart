import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:heed/SplashScreen/SplashScreen.dart';
import 'package:heed/localizations/app_language.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/about_screen.dart';
import 'package:heed/src/views/screens/ads_screen.dart';
import 'package:heed/src/views/screens/clinicJoinUs_screen.dart';
import 'package:heed/src/views/screens/clinicSectionDetails_screen.dart';
import 'package:heed/src/views/screens/clinicSections_screen.dart';
import 'package:heed/src/views/screens/clinics_screen.dart';
import 'package:heed/src/views/screens/contactUs_screen.dart';
import 'package:heed/src/views/screens/favoriteClinics_screen.dart';
import 'package:heed/src/views/screens/forgetPassword_screen.dart';
import 'package:heed/src/views/screens/history_screen.dart';
import 'package:heed/src/views/screens/home_screen.dart';
import 'package:heed/src/views/screens/lang_screen.dart';
import 'package:heed/src/views/screens/login_screen.dart';
import 'package:heed/src/views/screens/medicalAdvice_screen.dart';
import 'package:heed/src/views/screens/notifications_screen.dart';
import 'package:heed/src/views/screens/ourClinics_screen.dart';
import 'package:heed/src/views/screens/profile_screen.dart';
import 'package:heed/src/views/screens/settings_screen.dart';
import 'package:heed/src/views/screens/signUp_screen.dart';
import 'package:heed/src/views/widgets/LifeCycle_widget.dart';
import 'package:provider/provider.dart';

import 'src/blocs/firebase_token.dart';
////////////////////////////////////////////////////////////////////////////////

void main() async {
/*Set `enableInDevMode` to true to see reports while in debug mode
This is only to be used for confirming that reports are being submitted as expected.
It is not intended to be used for everyday development.*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;


  Future initialize() async {
    String tokenStr;

    if (Platform.isAndroid) {
      _fcm.getToken().then((token) {
        print(token);
        tokenStr = token.toString();
        locator<FirebaseTokenBloc>().firebaseTokenSink.add(tokenStr);
      });
    } else if (Platform.isIOS) {
      tokenStr =  await _fcm.getAPNSToken();
      if(tokenStr == null){
        _fcm.getToken().then((token) {
          print(token);
          tokenStr = token.toString();
          locator<FirebaseTokenBloc>().firebaseTokenSink.add(tokenStr);

        });
      }

    }
  }

  initialize();

  try {
    await setupLocator().then((_) async {
      AppLanguage appLanguage = locator<AppLanguage>();
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError =  FirebaseCrashlytics.instance.recordFlutterError;

      await appLanguage.fetchLocale();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
        runApp(HeedApp(
          appLanguage: appLanguage,
        ));
      });
      runApp(HeedApp(
        appLanguage: appLanguage,
      ));
    }, onError:
    FirebaseCrashlytics.instance.recordError
    );
  } catch (error) {
    print("erroro $error");
  }
}

////////////////////////////////////////////////////////////////////////////////

class HeedApp extends StatelessWidget {
  final AppLanguage appLanguage;
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);


  HeedApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<InternetStatus>(
      create: (_) => ConnectionCheckerService().getConnectionStatus$,
      child: ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: model.appLocal,
                supportedLocales: [
                  Locale('en', 'US'),
                  Locale('ar', ''),
                ],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                theme: ThemeData(
                  primaryColor: Color(0xFF00ABBE),
                  accentColor: Color(0xFF19769F),
                  fontFamily: 'hk-grotesk',
                ),
                navigatorObservers: <NavigatorObserver>[observer],
                home: SplashScreen(
                  image: Image.asset(
                    'assets/images/GIF.gif',
                    fit: BoxFit.fill,
                    repeat: ImageRepeat.repeat,
                  ),
                  mSeconds: 5000,
                  navigateAfterSeconds:
                  LifeCycleWidget(
                    onInit: () {},
                    onDispose: () {},
                    child: _getStartupScreen(),
                    // analytics: analytics,
                    // observer: observer,
                  ),
                ),
                routes: {
                  '/homeScreen': (context) => HomeScreen(),
                  '/langScreen': (context) => LangScreen(),
                  '/settingsScreen': (context) => SettingsScreen(),
//                '/checkoutScreen': (context) => CheckOutScreen(),
                  '/medicalAdviceScreen': (context) => MedicalAdviceScreen(),
                  '/signUpScreen': (context) => SignUpScreen(),
                  '/logInScreen': (context) => SignInScreen(),
                  '/profileScreen': (context) => ProfileScreen(),
                  '/notificationsScreen': (context) => NotificationsScreen(),
                  '/favoriteClinicsScreen': (context) => FavoriteClinicsScreen(),
                  '/clinicsScreen': (context) => ClinicsScreen(),
                  '/forgetPasswordScreen': (context) => ForgetPasswordScreen(),
                  '/clinicJoinUsScreen': (context) => ClinicJoinUsScreen(),
                  '/aboutScreen': (context) => AboutScreen(),
                  '/historyScreen': (context) => HistoryScreen(),
                  '/clinicSectionsScreen': (context) => ClinicSectionsScreen(),
                  '/clinicSectionDetailsScreen': (context) => ClinicSectionDetailsScreen(),
                  '/contactUsScreen': (context) => ContactUsScreen(),
                  '/ourClinicsScreen': (context) => OurClinicsScreen(),
                  '/adsScreen': (context) => AdsScreen(),
                });
          },
        ),
      ),
    );
  }

  Widget _getStartupScreen() {
    var prefsService = locator<PrefsService>();

    // if (!prefsService.hasSignedUp) {
    //   return SignUpScreen();
    // }

    //  if(!prefsService.hasLoggedIn) {
    //    return LoginScreen();
    //  }

    if (!prefsService.hasChosenLanguage) {
      return LangScreen();
    }
//    else if (!prefsService.hasLoggedIn) {
//      return SignInScreen();
//    }

    return AdsScreen();
    //HomeScreen();
  }
}
////////////////////////////////////////////////////////////////////////////////

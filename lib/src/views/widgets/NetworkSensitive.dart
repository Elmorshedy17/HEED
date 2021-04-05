import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/aboutUs_bloc.dart';
import 'package:heed/src/blocs/api_bloc/clinics_bloc.dart';
import 'package:heed/src/blocs/api_bloc/favorites_bloc.dart';
import 'package:heed/src/blocs/api_bloc/home_bloc.dart';
import 'package:heed/src/blocs/api_bloc/medicalAdviceDetails_bloc.dart';
import 'package:heed/src/blocs/api_bloc/medicalAdvice_bloc.dart';
import 'package:heed/src/blocs/api_bloc/notification_bloc.dart';
import 'package:heed/src/blocs/api_bloc/ourClinics_bloc.dart';
import 'package:heed/src/blocs/api_bloc/settings_bloc.dart';
import 'package:heed/src/services/connection_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/ads_screen.dart';
import 'package:heed/src/views/screens/home_screen.dart';
import 'package:heed/src/views/widgets/LifeCycle_widget.dart';
import 'package:heed/theme_setting.dart';
import 'package:provider/provider.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  NetworkSensitive({
    this.child,
  });

//   @override
//   _NetworkSensitiveState createState() => _NetworkSensitiveState();
// }

// class _NetworkSensitiveState extends State<NetworkSensitive> {
  // Future<void> refreshScreen(BuildContext context, screen) async {
  //   await Future.delayed(Duration.zero, () {
  //     screen.refreshScreen(context);
  //   }).then((_) {
  //     locator<PrefsService>().isBackToOnline = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<InternetStatus>(context);
    bool hasConnection;

    switch (connectionStatus) {
      case InternetStatus.Online:
        hasConnection = true;
        // locator<PrefsService>().hasConnection = true;
        break;
      case InternetStatus.Offline:
        hasConnection = false;
        // locator<PrefsService>().hasConnection = false;
        break;
      default:
        hasConnection = true;
        // locator<PrefsService>().hasConnection = true;
        break;
    }

    if (hasConnection) {
      if (locator<PrefsService>().isBackToOnline) {
        locator<PrefsService>().isBackToOnline = false;
        locator<NotificationsBloc>()
            .inLang
            .add(locator<PrefsService>().appLanguage);
        locator<HomeBloc>().inLang.add(locator<PrefsService>().appLanguage);
        ClinicsBloc().inLang.add(locator<PrefsService>().appLanguage);
        MedicalAdviceDetailsBloc()
            .inLang
            .add(locator<PrefsService>().appLanguage);
        locator<MedicalAdviceBloc>()
            .inLang
            .add(locator<PrefsService>().appLanguage);
        locator<NotificationsBloc>()
            .inLang
            .add(locator<PrefsService>().appLanguage);
        locator<SettingsBloc>().inLang.add(locator<PrefsService>().appLanguage);
        locator<AboutBloc>().inLang.add(locator<PrefsService>().appLanguage);
        locator<OurClinicsBloc>()
            .inLang
            .add(locator<PrefsService>().appLanguage);
        locator<FavoritesBloc>()
            .inLang
            .add(locator<PrefsService>().appLanguage);
        print('BACE TO ONLINE');
      }
      return child;
    } else {
      return AbsorbPointer(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // widget.child,
              child,
              InternetAlert(),
            ],
          ),
        ),
      );
    }
  }
}

class InternetAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    locator<PrefsService>().isBackToOnline = true;

    return Scaffold(
      backgroundColor: Colors.black12.withOpacity(0.3),
      body: Center(
        child: AlertDialog(
          content: Container(
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFFFFFF),
              borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            ),
            height: locator<PrefsService>().appLanguage == 'en' ? 120 : 130,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/no-wifi.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('noWifiTitle_str'),
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )
                  ],
                ),
                Container(
                    child: Text(
                  AppLocalizations.of(context).translate('noWifiContent_str'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, height: 1.5),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_language.dart';
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
import 'package:heed/src/models/api_models/GET/setting_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/privacy&termsConditions_screen.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool languageFlag;
  // bool notificationFlag = true;

  bool isAlertOnScreen = false;

//  @override
//  void initState() {
//    super.initState();
//    setState(() {
//      locator<ConnectionCheckerService>().getConnectionStatus$.listen((state) {
//        if (state == InternetStatus.Offline) {
//          showInternetAlert(context);
//          isAlertOnScreen = true;
//        } else {
//          if (isAlertOnScreen) {
//            Navigator.pop(context);
//          }
//        }
//      });
//    });
//  }

  @override
  void dispose() {
    // locator<PrefsService>().isOnline = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    if (locator<PrefsService>().appLanguage == 'en') {
      languageFlag = false;
    } else {
      languageFlag = true;
    }
//    setState(() {
//      locator<ConnectionCheckerService>().getConnectionStatus$.listen((state) {
//        if (state == InternetStatus.Offline) {
//          showInternetAlert(context);
//          isAlertOnScreen = true;
//        } else {
//          if (isAlertOnScreen) {
//            Navigator.pop(context);
//          }
//        }
//      });
//    });
//    locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
//      if (status == InternetStatus.Offline &&
//          !locator<PrefsService>().isOnline) {
//        locator<PrefsService>().isOnline = true;
//        // Navigator.push(context, InternetAlert());
//        showInternetAlert(context);
//        isAlertOnScreen = true;
//      } else if (status == InternetStatus.Online &&
//          locator<PrefsService>().isOnline) {
//        locator<PrefsService>().isOnline = false;
//        if (isAlertOnScreen) {
//          Navigator.pop(context);
//        }
//      }
//    });
    return NetworkSensitive(
      child: WillPopScope(
        onWillPop: () async {
          locator<TextEditingController>().clear();
          return true;
        },
        child: RootApp(
          child: ListView(
            children: <Widget>[
              // Screen title
              ListTile(
                leading:
                    Text(AppLocalizations.of(context).translate('settings_str'),
                        style: TextStyle(
                          fontSize: MainFont,
                          color: Theme.of(context).primaryColor,
                        )),
              ),
              Divider(
                endIndent: 15,
                indent: 15,
                height: 5,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              // Switch for language
              ListTile(
                onTap: () {
                  locator<TextEditingController>().clear();
                  setState(() {
                    languageFlag = !languageFlag;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/homeScreen', (Route<dynamic> route) => false);
                  });
                  if (languageFlag) {
                    appLanguage.changeLanguage(Locale('ar'));
                    locator<HomeBloc>().inLang.add('ar');
                    ClinicsBloc().inLang.add('ar');
                    MedicalAdviceDetailsBloc().inLang.add('ar');
                    locator<MedicalAdviceBloc>().inLang.add('ar');
                    locator<NotificationsBloc>().inLang.add('ar');
                    locator<SettingsBloc>().inLang.add('ar');
                    locator<AboutBloc>().inLang.add('ar');
                    locator<OurClinicsBloc>().inLang.add('ar');
                    locator<FavoritesBloc>().inLang.add('ar');
                  } else {
                    appLanguage.changeLanguage(Locale('en'));
                    locator<HomeBloc>().inLang.add('en');
                    ClinicsBloc().inLang.add('en');
                    MedicalAdviceDetailsBloc().inLang.add('en');
                    locator<MedicalAdviceBloc>().inLang.add('en');
                    locator<NotificationsBloc>().inLang.add('en');
                    locator<SettingsBloc>().inLang.add('en');
                    locator<AboutBloc>().inLang.add('en');
                    locator<OurClinicsBloc>().inLang.add('en');
                    locator<FavoritesBloc>().inLang.add('en');
                  }
                },
                leading: Text(
                  AppLocalizations.of(context).translate('language_str'),
                  style: TextStyle(
                    fontSize: PrimaryFont,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                trailing: FittedBox(
                  child: Row(
                    children: <Widget>[
                      Text(
                        'English',
                        style: TextStyle(
                          fontSize: PrimaryFont,
                          fontWeight: FontWeight.bold,
                          color: midGrey,
                        ),
                      ),
                      CupertinoSwitch(
                        dragStartBehavior: DragStartBehavior.down,
                        activeColor: Theme.of(context).primaryColor,
                        value: languageFlag,
                        onChanged: (bool flag) {
                          locator<TextEditingController>().clear();
                          setState(() {
                            languageFlag = flag;
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/homeScreen', (Route<dynamic> route) => false);
                          });
//                      languageFlag
//                          ? appLanguage.changeLanguage(Locale('ar'))
//                          : appLanguage.changeLanguage(Locale('en'));
                          if (languageFlag) {
                            appLanguage.changeLanguage(Locale('ar'));
                            locator<HomeBloc>().inLang.add('ar');
                            ClinicsBloc().inLang.add('ar');
                            MedicalAdviceDetailsBloc().inLang.add('ar');
                            locator<MedicalAdviceBloc>().inLang.add('ar');
                            locator<NotificationsBloc>().inLang.add('ar');
                            locator<SettingsBloc>().inLang.add('ar');
                            locator<AboutBloc>().inLang.add('ar');
                            locator<OurClinicsBloc>().inLang.add('ar');
                            locator<FavoritesBloc>().inLang.add('ar');
                          } else {
                            appLanguage.changeLanguage(Locale('en'));
                            locator<HomeBloc>().inLang.add('en');
                            ClinicsBloc().inLang.add('en');
                            MedicalAdviceDetailsBloc().inLang.add('en');
                            locator<MedicalAdviceBloc>().inLang.add('en');
                            locator<NotificationsBloc>().inLang.add('en');
                            locator<SettingsBloc>().inLang.add('en');
                            locator<AboutBloc>().inLang.add('en');
                            locator<OurClinicsBloc>().inLang.add('en');
                            locator<FavoritesBloc>().inLang.add('en');
                          }
                        },
                      ),
                      Text(
                        'عربي',
                        style: TextStyle(
                          fontSize: PrimaryFont,
                          fontWeight: FontWeight.bold,
                          color: midGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                endIndent: 15,
                indent: 15,
                height: 1,
                color: dividerColor,
              ),
              // Switch for notifications
              ListTile(
                onTap: () {
                  setState(() {
                    locator<PrefsService>().notificationFlag =
                        !locator<PrefsService>().notificationFlag;
                  });
                },
                leading: Text(
                  AppLocalizations.of(context).translate('notifications_str'),
                  style: TextStyle(
                    fontSize: PrimaryFont,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                trailing: FittedBox(
                  child: Row(
                    children: <Widget>[
                      Text(
                        'OFF',
                        style: TextStyle(
                          fontSize: PrimaryFont,
                          fontWeight: FontWeight.bold,
                          color: midGrey,
                        ),
                      ),
                      CupertinoSwitch(
                        dragStartBehavior: DragStartBehavior.down,
                        activeColor: Theme.of(context).primaryColor,
                        value: locator<PrefsService>().notificationFlag,
                        onChanged: (bool flag) {
                          setState(() {
                            locator<PrefsService>().notificationFlag = flag;
                          });
                        },
                      ),
                      Text(
                        'ON',
                        style: TextStyle(
                          fontSize: PrimaryFont,
                          fontWeight: FontWeight.bold,
                          color: midGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                endIndent: 15,
                indent: 15,
                height: 1,
                color: dividerColor,
              ),

              CustomObserver<SettingModel>(
                stream: locator<SettingsBloc>().setting$,
                onSuccess: (context, SettingModel data) {
                  List<Pages> pages = data.data.pages;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ListView.builder(
                        itemCount: pages.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                  onTap: () {
                                    locator<TextEditingController>().clear();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PrivacyTermsTemplate(
                                          title: pages[index].title,
                                          content: pages[index].content,
                                        ),
                                      ),
                                    );
                                  },
                                  leading: Text(
                                    pages[index].title,
                                    style: TextStyle(
                                      fontSize: PrimaryFont,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right,
                                    color: Colors.blueAccent,
                                  )),
                              Divider(
                                endIndent: 15,
                                indent: 15,
                                height: 1,
                                color: dividerColor,
                              ),
                            ],
                          );
                        }),
                  );
                },
              ),

              SizedBox(
                height: 10,
              ),
              CustomObserver<SettingModel>(
                stream: locator<SettingsBloc>().setting$,
                onSuccess: (context, SettingModel data) {
                  List<SocialMedia> content = data.data.socialMedia;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView.builder(
                        itemExtent: 50,
                        padding: EdgeInsets.all(15),
                        scrollDirection: Axis.horizontal,
                        itemCount: content.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              switch (content[index].name) {
                                case 'twitter':
                                  await canLaunch("https://www.twitter.com")
                                      ? await launch("https://www.twitter.com")
                                      : throw 'Link cannot be handled';
                                  break;
                                case 'youtube':
                                  await canLaunch("https://www.youtube.com")
                                      ? await launch("https://www.youtube.com")
                                      : throw 'Link cannot be handled';
                                  break;
                                case 'instagram':
                                  await canLaunch("https://www.instagram.com")
                                      ? await launch("https://www.instagram.com")
                                      : throw 'Link cannot be handled';
                                  break;
                                case 'google':
                                  await canLaunch("https://www.google.com")
                                      ? await launch("https://www.google.com")
                                      : throw 'Link cannot be handled';
                                  break;
                                case 'whatsapp':
                                  var whatsappUrl =
                                      "whatsapp://send?phone=${content[4].link}&text=";

                                  await canLaunch(whatsappUrl)
                                      ? await launch(whatsappUrl)
                                      : throw 'Link cannot be handled';
                                  break;
                              }
//                          await canLaunch(content[index].link)
//                              ? await launch(content[index].link)
//                              : throw 'Link cannot be handled';
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  content[index].image,
                                  width: 35,
                                ),
                              ),
                            ),
//                            Text(content[index].name),
                          );
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

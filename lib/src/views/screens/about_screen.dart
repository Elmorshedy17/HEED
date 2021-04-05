import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/aboutUs_bloc.dart';
import 'package:heed/src/models/api_models/GET/about_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool isAlertOnScreen = false;
  @override
  void dispose() {
    // locator<PrefsService>().isOnline = false;
    super.dispose();
  }
//
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
  Widget build(BuildContext context) {
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
        child: Scaffold(
          body: RootApp(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // To home screen
//                    Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),
                      // CustomObserver(
                      //   stream: locator<AboutBloc>().about$,
                      //   onSuccess: (context, AboutModel data) {
                      //     About content = data.data.about;
                      //     return
                      Text(
                        // content.title,
                        AppLocalizations.of(context).translate('aboutUs_str'),
                        style: TextStyle(
                          fontSize: MainFont,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                      //   },
                      // ),
                    ],
                  ),
                  trailing:
                      Image.asset('assets/images/small-logo2.png', height: 20),
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
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/about_us.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: CustomObserver(
                      stream: locator<AboutBloc>().about$,
                      onSuccess: (context, AboutModel data) {
                        About content = data.data.about;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Html(
                            data: content.content,
                            // customTextAlign: (data) {
                            //   return TextAlign.justify;
                            // },
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/theme_setting.dart';

class PrivacyTermsTemplate extends StatefulWidget {
  final String title;
  final String content;

  const PrivacyTermsTemplate({Key key, this.title, this.content})
      : super(key: key);

  @override
  _PrivacyTermsTemplateState createState() => _PrivacyTermsTemplateState();
}

class _PrivacyTermsTemplateState extends State<PrivacyTermsTemplate> {
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
                      },
                    ),
                    Text(widget.title,
//                      AppLocalizations.of(context)
//                          .translate('terms&conditions_str'),
                        style: TextStyle(
                          fontSize: MainFont,
                          color: Theme.of(context).primaryColor,
                        )),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Html(
                        data: widget.content,
                        // customTextAlign: (data) {
                        //   return TextAlign.justify;
                        // },
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/notification_bloc.dart';
import 'package:heed/src/models/api_models/GET/notifications_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool isAlertOnScreen = false;
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
//
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
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),

                    Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('notifications_str'),
                        style: TextStyle(
                            fontWeight: semiFont,
                            fontSize: MainFont,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Divider(
                      endIndent: 15.0,
                      indent: 15.0,
                      height: 1.0,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    //  noNotifications(),
                    haveNotifications(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////////////
  Widget haveNotifications(BuildContext context) {
    return CustomObserver(
      stream: locator<NotificationsBloc>().notifications$,
      onSuccess: (context, NotificationsModel data) {
        List<Notifications> content = data.data.notifications;
        return content.length > 0
            ? Container(
                padding: EdgeInsets.all(15.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: content.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        key: Key(content[index].id.toString()),
                        padding: EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: littleGrey))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 5,
                              child: Container(
                                child: Text(
                                  content[index].message,
                                  style: TextStyle(
                                    fontSize: PrimaryFont,
                                    color: darkGrey,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  content[index].date,
                                  style: TextStyle(
                                    fontSize: SecondaryFont,
                                    color: midGrey,
                                  ),
                                ),
                                alignment: Alignment.bottomRight,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            : noNotifications(context);
      },
    );
  }

////////////////////////////////////////////////////////////////////////////////////
  Widget noNotifications(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Image.asset(
              "assets/images/notification.png",
              height: 150,
              width: 125,
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)
                    .translate('notificationMessage_str'),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: PrimaryFont),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

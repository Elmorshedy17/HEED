import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

///[(0)FlutterLocalNotificationsPlugin]///***********************************
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//****************************************************************************
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/home_bloc.dart';
import 'package:heed/src/blocs/firebase_token.dart';
import 'package:heed/src/blocs/local_firebase_bloc.dart';
import 'package:heed/src/blocs/searchHome_bloc.dart';
import 'package:heed/src/models/api_models/GET/homeScreen_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/clinics_screen.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/ads_carousel.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class HomeScreen extends StatefulWidget {
  static _HomeScreenState of(BuildContext context) => context.findAncestorStateOfType();

  static void refreshScreen(BuildContext context) {
    context.findAncestorStateOfType<_HomeScreenState>().refreshScreen();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Key key = UniqueKey();

  void refreshScreen() {
    setState(() {
      key = UniqueKey();
    });
  }

  bool isQueryEmpty = true;
  bool isAlertOnScreen = false;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  bool isFirstDialog = true;

  String tokenStr;
  String token;

  ///[(1)FlutterLocalNotificationsPlugin]///
  /////// local notifications ///////////////////
  ///[start]//****************************************************
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//**************************************************************
  ///[end]//

  //////local notifications ////////////////////



  @override
  Future<void> initState() {
    super.initState();



    // initialize();
    ///[(2)FlutterLocalNotificationsPlugin]///
    ///////////////////// local notification ///////////////////////////
//     initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    ///[start]//*********************************************************************************
    ///
    var initializationSettingsAndroid = new AndroidInitializationSettings("app_icon");
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(iOS: initializationSettingsIOS,android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);

    ///[end]//*************************************************************************************************
    //////////////////// local notification ////////////////////////////

     _fcm.requestPermission(
        alert: true, badge: true, sound: true);

    // _fcm.getToken().then((token) {
    //   print(token);
    //   setState(() {
    //     tokenStr = token.toString();
    //     locator<FirebaseTokenBloc>().firebaseTokenSink.add(tokenStr);
    //   });
    // });



    //////////////////////local notifications ///////////////////////////////

    if (locator<PrefsService>().notificationFlag) {
      ////// firebase/////

      FirebaseMessaging.onMessage.listen((remoteMessage) {
        // var message =  remoteMessage;



        // showNotification(remoteMessage);
        print(remoteMessage);
        var action = remoteMessage.notification.body;
        var title = remoteMessage.notification.title;
        print("messi print this is messi datat/action $action");
        locator<LocalFirebaseBloc>().localFirebaseSink.add(action);
        locator<LocalFirebaseBloc>().localFirebaseSinkTitle.add(title);

            ///[(4)FlutterLocalNotificationsPlugin]///
            ///[start]//******************************************
            _showNotificationWithDefaultSound();
            ///[End]//*******************************************
      });



      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      });
      // _messaging.configure(
      //   onMessage: (Map<String, dynamic> message) async {
      //     showNotification(message);
      //     print(message);
      //     var action = message['notification']['body'];
      //     var title = message['notification']['title'];
      //     print("messi print this is messi datat/action $action");
      //     locator<LocalFirebaseBloc>().localFirebaseSink.add(action);
      //     locator<LocalFirebaseBloc>().localFirebaseSinkTitle.add(title);
      //
      //     ///[(4)FlutterLocalNotificationsPlugin]///
      //     ///[start]//******************************************
      //     // _showNotificationWithDefaultSound();
      //     ///[End]//*******************************************
      //   },
      //   onLaunch: (Map<String, dynamic> message) async {
      //     showNotification(message);
      //     print(message);
      //   },
      //   onResume: (Map<String, dynamic> message) async {
      //     showNotification(message);
      //     print(message);
      //   },
      // );
      //
      // _messaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
      //
      // _messaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      //   print("Settings registered: $settings");
      // });
      //

      ////// firebase/////
    }
  }

  void showNotification(Map<String, dynamic> payload) {
    final notification = payload["data"];
    final action = notification["action"];
    final message = notification["message"];
  }

  bool isFirstAlert = true;

  @override
  void dispose() {
    // locator<PrefsService>().isOnline = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    locator<HomeSearchBloc>().query$.listen((value) => value.isEmpty ? isQueryEmpty = true : isQueryEmpty = false);
    print("tokenStr${locator<FirebaseTokenBloc>().currentFirebaseToken}");
    return NetworkSensitive(
      child: WillPopScope(
        onWillPop: () async {
          locator<TextEditingController>().clear();
          return true;
        },
        child: Scaffold(
          body: RootApp(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(flex: 1, child: CarouselWidgetHome()),
                Flexible(
                  flex: 6,
                  child: isQueryEmpty
                      ? CustomObserver<HomeScreenModel>(
                          stream: locator<HomeBloc>().home$,
                          onSuccess: (context, data) {
                            List<Categories> content = data.data.categories;
                            locator<HomeSearchBloc>().inHome.add(content);
                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: content.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      locator<TextEditingController>().clear();
                                      Navigator.pushNamed(context, '/clinicsScreen',
                                          arguments: ClinicsScreenArguments(content[index].id));
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => ClinicsScreen(
//                                  id: content[index].id,
//                                ),
//                              ),
//                            );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),

                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        elevation: 5,
                                        child: Container(
                                          height: 160.0,
                                          decoration: BoxDecoration(
                                            borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                                            image: DecorationImage(
                                              image: NetworkImage(content[index].image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.network(
                                                content[index].icon,
                                                width: 50.0,
                                                height: 50.0,
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                content[index].name,
                                                style: TextStyle(
                                                    fontSize: PrimaryFont, color: Colors.white, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                        )
                      :
                      ////////////////////////////////////////////////////////////////////////
                      // Search
                      ///////////////////////////////////////////////////////////////
                      CustomObserver(
                          stream: locator<HomeSearchBloc>().filteredHome$,
                          onSuccess: (context, List<Categories> data) {
                            List<Categories> searchContent = data;
                            return searchContent.isNotEmpty
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: searchContent.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          locator<TextEditingController>().clear();
                                          Navigator.pushNamed(context, '/clinicsScreen',
                                              arguments: ClinicsScreenArguments(searchContent[index].id));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
                                          height: 160.0,
                                          decoration: BoxDecoration(
                                            borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                                            image: DecorationImage(
                                              image: NetworkImage(searchContent[index].image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.network(
                                                searchContent[index].icon,
                                                width: 50.0,
                                                height: 50.0,
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                searchContent[index].name,
                                                style: TextStyle(
                                                    fontSize: PrimaryFont, color: Colors.white, fontWeight: semiFont),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Text(AppLocalizations.of(context).translate('noSearchResult_str')),
                                  );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///[(3)FlutterLocalNotificationsPlugin]///
  ///[start]//**************************************************************
  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        color: Theme.of(context).primaryColor
        // importance: Importance.Max, priority: Priority.High
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(android:androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      '${locator<LocalFirebaseBloc>().currentlocalFirebaseTitle}',
      '${locator<LocalFirebaseBloc>().currentlocalFirebase}',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  ///[end]//*****************************************************************************

//***************************************************************
  Future onSelectNotification(String payload) async {
//    showDialog(
//      context: context,
//      builder: (_) {
//        return new AlertDialog(
//          title: Text("PayLoad"),
//          content: Text("Payload : $payload"),
//        );
//      },
//    );
  }
//********************************************************************
}

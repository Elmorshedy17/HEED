import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/notification_bloc.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/ourClinics_screen.dart';
import 'package:heed/src/views/widgets/appBar_widget.dart';
import 'package:heed/theme_setting.dart';
import 'package:heed/zendesk_key.dart';
// import 'package:zendesk_plugin/zendesk_plugin.dart';
// import 'package:zendesk/zendesk.dart';

class RootApp extends StatefulWidget {
  final Widget child;

  RootApp({@required this.child});

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  /////////////////////////////////////////////////////////////////////////////
  ///////////////////////ZenDesk Setup/////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////
  // final Zendesk zenDesk = Zendesk();

  // ZenDesk is asynchronous, so we initialize in an async method.
  Future<void> initZenDesk() async {
    // Zendesk.initialize(ZendeskAccountKey, 'Heed').then((r) {
    //   print('init finished');
    // }).catchError((e) {
    //   print('failed with error $e');
    // });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // But we aren't calling setState, so the above point is rather moot now.
  }

  @override
  void initState() {
    super.initState();
    initZenDesk();
  }

  //////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////
  bool languageFlag;
  /////////////////////////////////////////////////////////////////////////////
  //  Current State of InnerDrawerState
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

  void _toggleDrawer() {
    _innerDrawerKey.currentState.toggle(
        // direction is optional
        // if not set, the last direction will be used
        //InnerDrawerDirection.start OR InnerDrawerDirection.end
        direction: InnerDrawerDirection.start);
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////////////
    if (locator<PrefsService>().appLanguage == 'en') {
      languageFlag = false;
    } else {
      languageFlag = true;
    }
    ////////////////////////////////////////////////////
    // locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
    //   if (status == InternetStatus.Offline &&
    //       !locator<PrefsService>().isOnline) {
    //     locator<PrefsService>().isOnline = true;
    //     Navigator.push(context, InternetAlert());

    //     // locator<OfflineOnlineBloc>().flag$.listen((flag) {
    //     //   if (flag) {
    //     //     locator<OfflineOnlineBloc>().inFlag.add(false);
    //     //      Navigator.push(context, InternetAlert());
    //     //   }
    //     // });
    //     // locator<OfflineOnlineBloc>().inFlag.add(false);
    //   }
    // });
    // connectionChecker(context);
    /////////////////////////////////////////////////////////////////////
    return
//      NetworkSensitive(
//      child:
        InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true, // default false
      swipe: true, // default true
      colorTransitionChild: primaryColor, // default Color.black54
      innerDrawerCallback: (a) => print(a), // return bool
      // leftOffset: 0.4, // default 0.4
      // rightOffset: 0.4, // default 0.4
      // leftScale: 1.0, // default 1
      // rightScale: 1.0, // default 1
      borderRadius: 0, // default 0
      leftAnimationType: InnerDrawerAnimation.quadratic, // default static
//      rightAnimationType: InnerDrawerAnimation.quadratic,
      boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 0)],

      //when a pointer that is in contact with the screen and moves to the right or left
      onDragUpdate: (double val, InnerDrawerDirection direction) {
        // return values between 1 and 0
        print(val);
        // check if the swipe is to the right or to the left
        print(direction == InnerDrawerDirection.start);
      },
//    innerDrawerCallback: (a) => print(a), // return  true (open) or false (close)
      leftChild: Material(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(languageFlag ? "assets/images/drawer_icons/menu-ar.png" : "assets/images/drawer_icons/menu-en.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  physics: new ClampingScrollPhysics(),

                  // primary: true,
                  // physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    // Home.
                    ListTile(
                        onTap: () {
                          _toggleDrawer();
                          locator<TextEditingController>().clear();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/homeScreen", (route) => route.isCurrent ? route.settings.name == "/homeScreen" ? false : true : true);
                        },
                        leading: Image.asset(
                          "assets/images/drawer_icons/Home.png",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          AppLocalizations.of(context).translate('home_str'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                          ),
                        )),
                    // Profile or SignIn / SignUp.
                    ListTile(
                      onTap: () {
                        _toggleDrawer();
                        locator<TextEditingController>().clear();
                        if (locator<PrefsService>().hasSignedUp && locator<PrefsService>().hasLoggedIn) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/profileScreen", (route) => route.isCurrent ? route.settings.name == "/profileScreen" ? false : true : true);
                        }
                        //  else if (!locator<PrefsService>().hasSignedUp) {
                        //   Navigator.of(context).pushNamedAndRemoveUntil(
                        //       "/signUpScreen",
                        //       (route) => route.isCurrent
                        //           ? route.settings.name == "/signUpScreen"
                        //               ? false
                        //               : true
                        //           : true);
                        // }
                        else if (!locator<PrefsService>().hasLoggedIn) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/logInScreen", (route) => route.isCurrent ? route.settings.name == "/logInScreen" ? false : true : true);
                        }
                      },
                      leading: Image.asset(
                        "assets/images/drawer_icons/profile.png",
                        height: 30,
                        width: 30,
                      ),
                      title: Text(
                        locator<PrefsService>().hasSignedUp && locator<PrefsService>().hasLoggedIn
                            ? AppLocalizations.of(context).translate('profile_str')
                            : AppLocalizations.of(context).translate('signin/signup_str'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                        ),
                      ),
                    ),
                    // Our Clinics.
                    ListTile(
                      onTap: () {
                        _toggleDrawer();
                        locator<TextEditingController>().clear();
                        // ourClinicsScreen
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/ourClinicsScreen", (route) => route.isCurrent ? route.settings.name == "/ourClinicsScreen" ? false : true : true,
                            arguments: OurClinicsScreenArguments(isQueryEmptyFromOutside: true));
                      },
                      leading: Image.asset(
                        "assets/images/drawer_icons/clinic.png",
                        height: 30,
                        width: 30,
                      ),
                      title: Text(
                        AppLocalizations.of(context).translate('ourClinics_str'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                        ),
                      ),
                    ),
                    // Medical Advice.
                    ListTile(
                      leading: Image.asset(
                        "assets/images/drawer_icons/medical.png",
                        height: 30,
                        width: 30,
                      ),
                      title: Text(
                        AppLocalizations.of(context).translate('medicalAdvice_str'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                        ),
                      ),
                      onTap: () {
                        _toggleDrawer();
                        locator<TextEditingController>().clear();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/medicalAdviceScreen", (route) => route.isCurrent ? route.settings.name == "/medicalAdviceScreen" ? false : true : true);
                      },
                    ),
                    // My Favorite.
                    ListTile(
                      onTap: () {
                        _toggleDrawer();
                        locator<TextEditingController>().clear();
                        // favoriteClinicsScreen
                        Navigator.of(context).pushNamedAndRemoveUntil("/favoriteClinicsScreen",
                            (route) => route.isCurrent ? route.settings.name == "/favoriteClinicsScreen" ? false : true : true);
                      },
                      leading: Image.asset(
                        "assets/images/drawer_icons/fav.png",
                        height: 30,
                        width: 30,
                      ),
                      title: Text(
                        AppLocalizations.of(context).translate('favourite_str'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                        ),
                      ),
                    ),
                    // About Us.
                    ListTile(
                      leading: Image.asset(
                        "assets/images/drawer_icons/about.png",
                        height: 30,
                        width: 30,
                      ),
                      title: Text(
                        AppLocalizations.of(context).translate('aboutUs_str'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                        ),
                      ),
                      onTap: () {
                        _toggleDrawer();
                        locator<TextEditingController>().clear();
                        // aboutScreen
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/aboutScreen", (route) => route.isCurrent ? route.settings.name == "/aboutScreen" ? false : true : true);
                      },
                    ),
                    // Contact Us
                    ListTile(
                      leading: Icon(
                        Icons.email,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: Text(
                        AppLocalizations.of(context).translate('contactUs_str'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                        ),
                      ),
                      onTap: () {
                        _toggleDrawer();
                        locator<TextEditingController>().clear();
                        // aboutScreen
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/contactUsScreen", (route) => route.isCurrent ? route.settings.name == "/contactUsScreen" ? false : true : true);
                      },
                    ),
                    // Settings.
                    ListTile(
                      leading: Image.asset(
                        "assets/images/drawer_icons/settings.png",
                        height: 30,
                        width: 30,
                      ),
                      title: Text(
                        AppLocalizations.of(context).translate('settings_str'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                        ),
                      ),
                      onTap: () {
                        _toggleDrawer();
                        locator<TextEditingController>().clear();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/settingsScreen", (route) => route.isCurrent ? route.settings.name == "/settingsScreen" ? false : true : true);
                      },
                    ),
                    // Support Chat.
                    ListTile(
                      onTap: () async {
                        _toggleDrawer();
                        locator<TextEditingController>().clear();
                        // if (locator<PrefsService>().userObj != null) {
                        //   Zendesk.setVisitorInfo(
                        //     name: locator<PrefsService>().userObj.name,
                        //     email: locator<PrefsService>().userObj.email,
                        //     phoneNumber: locator<PrefsService>().userObj.phone,
                        //   )
                        //       .then((_) {
                        //     print('setVisitorInfo finished');
                        //   }).catchError((e) {
                        //     print('error $e');
                        //   });
                        //
                        //   Zendesk.startChat().then((_) {
                        //     print('startChat finished');
                        //   }).catchError((e) {
                        //     print('error $e');
                        //   });
                        // } else {
                        //   Zendesk.setVisitorInfo(name: 'Visitor').then((_) {
                        //     print('setVisitorInfo finished');
                        //   }).catchError((e) {
                        //     print('error $e');
                        //   });
                        //
                        //   Zendesk.startChat().then((_) {
                        //     print('startChat finished');
                        //   }).catchError((e) {
                        //     print('error $e');
                        //   });
                        // }
                      },
                      leading: Image.asset(
                        "assets/images/drawer_icons/chat.png",
                        height: 30,
                        width: 30,
                      ),
                      title: Text(
                        AppLocalizations.of(context).translate('supportChat_str'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                        ),
                      ),
                    ),
                    // History.
                    ListTile(
                      onTap: () {
                        _toggleDrawer();
                        locator<TextEditingController>().clear();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/historyScreen", (route) => route.isCurrent ? route.settings.name == "/historyScreen" ? false : true : true);
                      },
                      leading: Image.asset(
                        "assets/images/drawer_icons/history.png",
                        height: 30,
                        width: 30,
                      ),
                      title: Text(
                        AppLocalizations.of(context).translate('history_str'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),

              ///////////////////////////////
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                        ),
                        onPressed: () {
                          //Change method to _toggle instead of Navigator.pop(context).
                          _toggleDrawer();
                        },
                        child: Image.asset(
                          "assets/images/drawer_icons/close.png",
                          fit: BoxFit.cover,
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        AppLocalizations.of(context).translate('close_str'),
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: PrimaryFont),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Powered by line",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //  A Scaffold is generally used but you are free to use other widgets
      // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
      scaffold: Scaffold(
        appBar: PreferredSize(
            child: AppBarWidget(
              onPressedMenu: _toggleDrawer,
              onPressedNotifications: () {
                locator<TextEditingController>().clear();
                // notificationsScreen
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/notificationsScreen", (route) => route.isCurrent ? route.settings.name == "/notificationsScreen" ? false : true : true);
                locator<NotificationsBloc>()..inClicked.add(true)..inLang.add(locator<PrefsService>().appLanguage);
              },
            ),
            preferredSize: Size.fromHeight(200)),
        body: widget.child,
      ),
//      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////
  void _showPleaseLoginDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            // title: Text(
            //   AppLocalizations.of(context).translate('CONGRATS!_str'),
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //       fontSize: MediumFont, color: Theme.of(context).primaryColor),
            // ),
            content: Container(
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
              ),
              height: locator<PrefsService>().appLanguage == 'en' ? 90 : 100,
              // height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top: 15.0, bottom: 30.0),
                  //   height: 55.0,
                  //   width: 85.0,
                  //   child: Image.asset("assets/images/hand.png"),
                  // ),
                  Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        AppLocalizations.of(context).translate('PleaseLoginFirst_str'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            // fontSize: SecondaryFont,
                            // color: Theme.of(context).primaryColor,
                            height: 1.5),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 100.0,
                        height: 30.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context).translate('ok_str'),
                            style: TextStyle(color: Colors.white, fontSize: SecondaryFont),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, '/logInScreen');
                          },
                          color: greyBlue,
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 100.0,
                        height: 30.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context).translate('notNow_str'),
                            style: TextStyle(color: Colors.white, fontSize: SecondaryFont),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigator.pushReplacementNamed(
                            //     context, '/logInScreen');
                          },
                          color: greyBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            titlePadding: EdgeInsets.only(top: 35.0),
//            actions: <Widget>[
//              ,
//            ],
          );
        });
  }
/////////////////////////////////////////////////////////////////////////////////
}

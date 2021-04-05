import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/login_bloc.dart';
import 'package:heed/src/blocs/signIn_bloc.dart';
import 'package:heed/src/models/api_models/POST/login_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

// import 'package:heed/src/views/screens/signup.dart';
// import 'package:heed/src/views/widgets/appRoot_widget.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var signinBloc = locator<SignInBloc>();
  String email;
  String password;
  int codeStatus = 0;
  bool loginClicked = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode passwordFocusNode = new FocusNode();

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
    return
//      NetworkSensitive(
//      child:
        WillPopScope(
      onWillPop: () async {
        locator<TextEditingController>().clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          //  title: Text("Receipt"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            // call this method here to hide soft keyboard
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/signup.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),),
              ListView(
                children: <Widget>[
                  Container(
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage(
                    //       'assets/images/signup.png',
                    //     ),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .22,
                            ),
                            Card(
                              elevation: 4.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .8,
                                padding: EdgeInsets.only(
                                    top: 20.0,
                                    right: 20.0,
                                    left: 20.0,
                                    bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('login_str'),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: LargeFont,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    mobileField(),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    Form(
                                      child: Wrap(
                                        children: <Widget>[
                                          passwordField(),
                                          forgetPassword(),
                                        ],
                                      ),
                                    ),
                                    signInButton(context),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    signupLink(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Center(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('ifClinic_str'),
                                      style: TextStyle(
                                          fontSize: MediumFont, color: greyBlue),
                                    ),
                                    SizedBox(
                                      width: 25.0,
                                    ),
                                    RaisedButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 7.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/clinicJoinUsScreen');
                                      },
                                      color: midGrey,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('joinUs_str'),
                                            style: TextStyle(
                                                fontSize: MediumFont,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Image.asset(
                                              "assets/images/mainIcons1X/heart.png"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) /* add child content here */,
                  ),
                ],
              ),
            ],
          ),
        ),
//      ),
      ),
    );
  }

  /////////////////////////////////////// widgets////////////////////////////

  Widget mobileField() {
    return StreamBuilder(
      stream: signinBloc.mobileOrEmail,
      builder: (context, snapshot) {
        return Container(
//          height: 50,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            controller: emailController,
            onFieldSubmitted: (value) {
              email = value;
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            onChanged: signinBloc.changeMobileOrEmail,
//            (newValue){
//bloc.changeEmail(newValue);
//        },
            //   keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                prefixIcon: Container(
                  padding: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: Image.asset(
                    "assets/images/msg18.png",
                    width: 10,
                    height: 10,
                  ),
                ),
                hintText:
                    '${AppLocalizations.of(context).translate('mail_str')} / ${AppLocalizations.of(context).translate('mobileNumber_str')}',
                labelText:
                    '${AppLocalizations.of(context).translate('mail_str')} / ${AppLocalizations.of(context).translate('mobileNumber_str')}',
                errorText: snapshot.error,
                border: OutlineInputBorder()),
          ),
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: signinBloc.password,
      builder: (context, snapshot) {
        return Container(
//          height: 50,
          child: TextFormField(
            focusNode: passwordFocusNode,
            controller: passwordController,
            onFieldSubmitted: (value) {
              password = value;
            },
//          key: passKey,
            onChanged: signinBloc.changePassword,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Container(
                padding: EdgeInsets.only(left: 7.0, right: 7.0),
                child: Image.asset(
                  "assets/images/lock18.png",
                  width: 10,
                  height: 10,
                ),
              ),
              hintText: AppLocalizations.of(context).translate('password_str'),
              labelText: AppLocalizations.of(context).translate('password_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }

  Widget signInButton(BuildContext context) {
    return StreamBuilder<Object>(
        stream: signinBloc.registerValid,
        builder: (context, snapshot) {
          return Center(
            child: ButtonTheme(
              minWidth: 280.0,
              height: 45.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                child: Text(
                  AppLocalizations.of(context).translate('signIn_str'),
                  style: TextStyle(color: Colors.white, fontSize: MainFont),
                ),
                onPressed: snapshot.hasData
                    ? () async {
                        bool result =
                            await DataConnectionChecker().hasConnection;
                        print("hello mohamed");
                        print(
                            "Email:${emailController.text} - Password:${passwordController.text}");
                        if (result == true) {
                          // locator<PrefsService>().hasLoggedIn = true;
                          // locator<PrefsService>().hasSignedUp = true;
                          locator<LoginBloc>()
                              .inEmail
                              .add(emailController.text);
                          locator<LoginBloc>()
                              .inPassword
                              .add(passwordController.text);
                          locator<LoginBloc>().inClick.add(!loginClicked);

                          // locator<PrefsService>().isOnline = false;

                          _showMaterialDialog(context);
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: const Color(0xFFFFFF),
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(32.0)),
                                    ),
                                    height:
                                        locator<PrefsService>().appLanguage ==
                                                'en'
                                            ? 150
                                            : 145,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
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
                                              AppLocalizations.of(context)
                                                  .translate('noWifiTitle_str'),
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            )
                                          ],
                                        ),
                                        Container(
                                            child: Text(
                                          AppLocalizations.of(context)
                                              .translate('noWifiContent_str'),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16, height: 1.5),
                                        )),
                                        ButtonTheme(
                                          minWidth: 100.0,
                                          height: 30.0,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      25.0),
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('ok_str'),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: SecondaryFont),
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              Navigator.pop(context);
                                              // Navigator.pushReplacementNamed(Dia
                                              //     context, '/logInScreen');
                                            },
                                            color: greyBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }

//                         showDialog(
//                             context: context,
//                             builder: (context) {
//                               return Container(
//                                 height: 50,
//                                 child: ConstrainedBox(
//                                   constraints: BoxConstraints(maxHeight: 100.0),
//                                   child: AlertDialog(
//                                     content: CustomObserver(
//                                       stream: locator<LoginBloc>().login$,
//                                       onSuccess: (context, LoginModel data) {
//                                         User user = data.data.user;

//                                         String msg = data.message;
//                                         if (data.status == 1) {
//                                           locator<PrefsService>().loginUser =
//                                               user;
//                                           locator<PrefsService>().userAuth =
//                                               user.authorization;
//                                           locator<PrefsService>().userName =
//                                               user.name;
//                                           locator<PrefsService>().userEmail =
//                                               user.email;
//                                           locator<PrefsService>().userPhone =
//                                               user.phone;
//                                           locator<PrefsService>().userPassword =
//                                               passwordController.text;
//                                           codeStatus = 1;
//                                           return Text(msg);
//                                         }
//                                         codeStatus = 0;
// //                                    return Text('$msg\n${user.authorization}');
//                                         return Text(msg);
//                                       },
//                                       onError: (context, error) {
//                                         return Wrap(
//                                           children: <Widget>[
//                                             Text('$error'),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).timeout(Duration(seconds: 1), onTimeout: () {
//                           if (codeStatus == 1) {
//                             Navigator.pushReplacementNamed(
//                                 context, '/homeScreen');
//                           }
//                         }).whenComplete(() {
//                           if (codeStatus == 1) {
//                             Navigator.pushReplacementNamed(
//                                 context, '/homeScreen');
//                           }
//                         });

//                        if (codeStatus == 1) {
//                          Navigator.pushReplacementNamed(
//                              context, '/homeScreen');
//                        }
                      }
                    : null,
              ),
            ),
          );
        });
  }

  Widget signupLink() {
    return Material(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('doNotHaveAnAccount_str'),
              style: TextStyle(color: lightGrey),
            ),
            FlatButton(
              child: Text(
                AppLocalizations.of(context).translate('register_str'),
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signUpScreen');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget forgetPassword() {
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: FlatButton(
        child: Text(
          AppLocalizations.of(context).translate('forgotPassword_str'),
          style: TextStyle(color: lightGrey, fontSize: PrimaryFont),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/forgetPasswordScreen');
        },
      ),
    );
  }

  void _showMaterialDialog(BuildContext context) {
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
              height: 50,
              // MediaQuery.of(context).size.height * 0.29,
              width: MediaQuery.of(context).size.width * 0.5,
              // child: Column(
              // children: <Widget>[
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: CustomObserver(
                    stream: locator<LoginBloc>().login$,
                    onSuccess: (context, LoginModel data) {
                      User user = data.data.user;
                      String msg = data.message;
                      if (data.status == 1) {
                        locator<PrefsService>().userObj = user;
                        // locator<PrefsService>().userAuth = user.authorization;
                        // locator<PrefsService>().userName = user.name;
                        // locator<PrefsService>().userEmail = user.email;
                        // locator<PrefsService>().userPhone = user.phone;
                        locator<PrefsService>().userPassword =
                            passwordController.text;

                        codeStatus = 1;
                        locator<PrefsService>().hasLoggedIn = true;
                        locator<PrefsService>().hasSignedUp = true;
                        return Text(
                          // AppLocalizations.of(context).translate('CONGRATS!_str')
                          msg,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              // fontSize: SecondaryFont,
                              // color: Theme.of(context).primaryColor,
                              height: 1.5),
                        );
                      }
                      codeStatus = 0;
//                                    return Text('$msg\n${user.authorization}');
                      return Text(
                        // AppLocalizations.of(context).translate('CONGRATS!_str')
                        msg,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            // color: Theme.of(context).primaryColor,
                            height: 1.5),
                      );
                    },
                  ),
                ),
              ),
            ),
            titlePadding: EdgeInsets.only(top: 35.0),
//            actions: <Widget>[
//              ,
//            ],
          );
        }).timeout(Duration(seconds: 1),
        onTimeout: () {
      if (codeStatus == 1) {
        // Navigator.pushReplacementNamed(context, '/homeScreen');
        // locator<PrefsService>().isOnline = false;
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/homeScreen', (Route<dynamic> route) => false);
      }
    }).whenComplete(() {
      if (codeStatus == 1) {
        // locator<PrefsService>().isOnline = false;
        // Navigator.pushReplacementNamed(context, '/homeScreen');
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/homeScreen', (Route<dynamic> route) => false);
      }
    });
  }
}

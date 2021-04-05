import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/register_bloc.dart';
import 'package:heed/src/blocs/signUp_bloc.dart';
import 'package:heed/src/models/api_models/POST/login_model.dart';
import 'package:heed/src/models/api_models/POST/register_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var signUpBloc = locator<SignUpBloc>();
  String email;
  String password;
  String passwordConfirmation;
  String name;
  String phone;
  int codeStatus = 0;
  bool isRegisterClicked = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  FocusNode emailFocusNode = new FocusNode();

  FocusNode mobileFocusNode = new FocusNode();

  FocusNode passFocusNode = new FocusNode();

  FocusNode conPassFocusNode = new FocusNode();

  bool monVal = false;

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
                  ),
                ),
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
                                height: MediaQuery.of(context).size.height * .25,
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
                                            .translate('signup_str'),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: LargeFont,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Form(
                                        child: Wrap(
                                          children: <Widget>[
                                            nameField(),
                                            Container(
                                              height: 10.0,
                                            ),
                                            emailField(),
                                            Container(
                                              height: 10.0,
                                            ),
                                            mobileField(),
                                            Container(
                                              height: 10.0,
                                            ),
                                            passwordField(),
                                            Container(
                                              height: 10.0,
                                            ),
                                            confirmPasswordField(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      acceptTermsCheck(),
//                    SizedBox(height: 10.0,),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              signUpButton(context),
                              SizedBox(
                                height: 10.0,
                              ),
                              loginLink(),
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

  Widget nameField() {
    return StreamBuilder(
      stream: signUpBloc.name,
      builder: (context, snapshot) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (String value) {
            FocusScope.of(context).requestFocus(emailFocusNode);
          },
          controller: nameController,
          onChanged: signUpBloc.changeName,
//            (newValue){
//bloc.changeEmail(newValue);
////        },
//          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText: AppLocalizations.of(context).translate('name_str'),
              labelText: AppLocalizations.of(context).translate('name_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget emailField() {
    return StreamBuilder(
      stream: signUpBloc.email,
      builder: (context, snapshot) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          focusNode: emailFocusNode,
          controller: emailController,
          onChanged: signUpBloc.changeEmail,
          onFieldSubmitted: (String v) {
            FocusScope.of(context).requestFocus(mobileFocusNode);
          },
//            (newValue){
//bloc.changeEmail(newValue);
//        },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText: AppLocalizations.of(context).translate('mail_str'),
              labelText: AppLocalizations.of(context).translate('mail_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget mobileField() {
    return StreamBuilder(
      stream: signUpBloc.mobile,
      builder: (context, snapshot) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          focusNode: mobileFocusNode,
          onFieldSubmitted: (String va) {
            FocusScope.of(context).requestFocus(passFocusNode);
          },
          controller: phoneController,
          onChanged: signUpBloc.changeMobile,
//            (newValue){
//bloc.changeEmail(newValue);
//        },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText:
              AppLocalizations.of(context).translate('mobileNumber_str'),
              labelText:
              AppLocalizations.of(context).translate('mobileNumber_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: signUpBloc.password,
      builder: (context, snapshot) {
        return TextFormField(
          focusNode: passFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (String val) {
            FocusScope.of(context).requestFocus(conPassFocusNode);
          },
          controller: passwordController,
          onChanged: signUpBloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            hintText: AppLocalizations.of(context).translate('password_str'),
            labelText: AppLocalizations.of(context).translate('password_str'),
            errorText: snapshot.error,
            border: OutlineInputBorder(),
          ),
        );
      },
    );
  }

  Widget confirmPasswordField() {
    return StreamBuilder(
      stream: signUpBloc.confirmPassword,
      builder: (context, snapshot) {
        return TextFormField(
          focusNode: conPassFocusNode,
          controller: passwordConfirmationController,
          onChanged: signUpBloc.changePasswordConfirmation,
          obscureText: true,
          decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText:
              AppLocalizations.of(context).translate('confirmPassword_str'),
              labelText:
              AppLocalizations.of(context).translate('confirmPassword_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget signUpButton(BuildContext context) {
    return StreamBuilder<Object>(
        stream: signUpBloc.registerValid,
        builder: (context, snapshot) {
          return Center(
            child: ButtonTheme(
              minWidth: 280.0,
              height: 45.0,
              child: monVal
                  ? RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                child: Text(
                  AppLocalizations.of(context).translate('signup_str'),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: snapshot.hasData
                    ? () async {
                  bool result =
                  await DataConnectionChecker().hasConnection;
                  print("hello mohamed");
                  // if (codeStatus != 0) {
                  // locator<PrefsService>().hasSignedUp = true;
                  // locator<PrefsService>().hasLoggedIn = true;
                  if (result == true) {
                    locator<RegisterBloc>()
                        .inEmail
                        .add(emailController.text);
                    locator<RegisterBloc>()
                        .inPassword
                        .add(passwordController.text);
                    locator<RegisterBloc>()
                        .inPasswordConfirmation
                        .add(passwordConfirmationController.text);
                    locator<RegisterBloc>()
                        .inPhone
                        .add(phoneController.text);
                    locator<RegisterBloc>()
                        .inName
                        .add(nameController.text);
                    // }
                    locator<RegisterBloc>()
                        .inClick
                        .add(!isRegisterClicked);

                    // setState(() {});
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
                              height: locator<PrefsService>()
                                  .appLanguage ==
                                  'en'
                                  ? 150
                                  : 145,
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.5,
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
                                            .translate(
                                            'noWifiTitle_str'),
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 25),
                                      )
                                    ],
                                  ),
                                  Container(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate(
                                            'noWifiContent_str'),
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
                                        new BorderRadius
                                            .circular(25.0),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('ok_str'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                            SecondaryFont),
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
                }
                    : null,
              )
                  : RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                ),
                child: Text(
                  AppLocalizations.of(context).translate('signup_str'),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: null,
              ),
            ),
          );
        });
  }

  Widget acceptTermsCheck() {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: monVal,
            onChanged: (bool value) {
              setState(() {
                monVal = value;
              });
            },
          ),

//          StreamBuilder<Object>(
//        //  initialData: true,
//              stream: signUpBloc.checkBoxStream,
//              builder: (context, snapshot) {
//                bool checkval = snapshot.data;
//                locator<SignUpCheckBoxBloc>().SignUpCheckSink.add(checkval);
//                print(checkval);
//                print(locator<SignUpCheckBoxBloc>().currentSignUpCheck);
//
//
//                return Checkbox(
//              //    value: snapshot.hasData ? snapshot.data : false,
//                value: snapshot.data,
//                  onChanged: (bool value) {
////                            setState(() {
////                              acceptTerms = value;
////
////                            });
//                    signUpBloc.changeCheckBoxController();
//                  },
//                );
//              }),
          Text(
            AppLocalizations.of(context).translate('byAccept_str'),
            style: TextStyle(color: lightGrey),
          ),
          FlatButton(
            child: FittedBox(
              child: Text(
                AppLocalizations.of(context).translate('terms&conditions_str'),
                style: TextStyle(
                    decoration: TextDecoration.underline, color: greyBlue),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/termsScreen');
            },
          ),
        ],
      ),
    );
  }

  Widget loginLink() {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      child: Material(
        child: Container(
//          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('haveAccount_str'),
                style: TextStyle(color: lightGrey, fontSize: PrimaryFont),
              ),
              FlatButton(
                child: Text(
                  AppLocalizations.of(context).translate('login_str'),
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).primaryColor,
                      fontSize: PrimaryFont),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/logInScreen');
                },
              ),
            ],
          ),
        ),
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
                  child: CustomObserver<RegisterModel>(
                    stream: locator<RegisterBloc>().register$,
                    onSuccess: (context, RegisterModel data) {
                      User user = data.data.user;
                      String msg = data.message;
                      if (data.status == 1) {
                        locator<PrefsService>().userObj = user;
                        locator<PrefsService>().userPassword =
                            passwordController.text;
                        locator<PrefsService>().hasSignedUp = true;
                        locator<PrefsService>().hasLoggedIn = true;
                        // locator<RegisterBloc>()
                        //     .inEmail
                        //     .add(emailController.text);
                        // locator<RegisterBloc>()
                        //     .inPassword
                        //     .add(passwordController.text);
                        // locator<RegisterBloc>()
                        //     .inPasswordConfirmation
                        //     .add(passwordConfirmationController.text);
                        // locator<RegisterBloc>()
                        //     .inPhone
                        //     .add(phoneController.text);
                        // locator<RegisterBloc>().inName.add(nameController.text);
                        // locator<RegisterBloc>().inClick.add(!isRegisterClicked);

                        // setState(() {
                        codeStatus = 1;
                        // });
                        return Text(
                          msg,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, height: 1.5),
                        );
                      }

                      // setState(() {
                      codeStatus = 0;
                      // });
                      return Text(
                        msg,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(fontSize: 12, height: 1.5),
                      );
                    },
                  ),
                ),
              ),
            ),
            titlePadding: EdgeInsets.only(top: 35.0),
          );
        }).timeout(Duration(seconds: 1), onTimeout: () {
      if (codeStatus == 1) {
        Navigator.pushReplacementNamed(context, '/homeScreen');
      }
    }).whenComplete(() {
      if (codeStatus == 1) {
        Navigator.pushReplacementNamed(context, '/homeScreen');
      }
    });
  }
}

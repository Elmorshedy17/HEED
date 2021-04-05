import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/forgetPassword_bloc.dart';
import 'package:heed/src/blocs/forgetPassword_bloc.dart';
import 'package:heed/src/models/api_models/POST/forgetPassword_model.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final forgetBloc = locator<ForgetPasswordBloc>();

  bool isPasswordBtnClicked = false;

  int codeStatus = 0;

  final emailController = TextEditingController();

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
    return NetworkSensitive(
      child: WillPopScope(
        onWillPop: () async {
          locator<TextEditingController>().clear();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            //  title: Text("Receipt"),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 25.0,
                color: Colors.blue,
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
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // SizedBox(height: 200.0,),
                      Text(
                        AppLocalizations.of(context)
                            .translate('forgetPasswordScreen_str'),
                        style: TextStyle(
                            fontSize: MainFont,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('resetPasswordMessage_str'),
                        style: TextStyle(fontSize: PrimaryFont, color: midGrey),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      emailForgetPassword(),
                      SizedBox(
                        height: 50.0,
                      ),
                      resetPasswordButton(),
                      SizedBox(
                        height: 50.0,
                      ),
                      logInHave(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailForgetPassword() {
    return StreamBuilder(
      stream: forgetBloc.emailForget,
      builder: (context, snapshot) {
        return TextField(
          controller: emailController,
          onChanged: forgetBloc.changeEmail,
//            (newValue){
//bloc.changeEmail(newValue);
//        },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              prefixIcon: Container(
                  padding: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: Image.asset("assets/images/msg218.png")),
              hintText: AppLocalizations.of(context).translate('mail_str'),
              labelText: AppLocalizations.of(context).translate('mail_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget resetPasswordButton() {
    return StreamBuilder<Object>(
        stream: forgetBloc.emailForget,
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
                  AppLocalizations.of(context).translate('resetPassword_str'),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: snapshot.hasData
                    ? () {
                        print("hello mohamed");
                        locator<ForgetPasswordApiBloc>()
                            .inEmail
                            .add(emailController.value.text);
                        locator<ForgetPasswordApiBloc>()
                            .inClick
                            .add(!isPasswordBtnClicked);
                        _showMaterialDialog(context);
                        // Navigator.pushReplacementNamed(context, '/logInScreen');
                      }
                    : null,
              ),
            ),
          );
        });
  }

  Widget logInHave(BuildContext context) {
    return Material(
      child: Center(
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
                    color: accentColor,
                    fontSize: PrimaryFont),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/logInScreen');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMaterialDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
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
              height: 115,
              // MediaQuery.of(context).size.height * 0.29,
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
                    child: CustomObserver(
                      stream: locator<ForgetPasswordApiBloc>().forgetPassword$,
                      onSuccess: (context, ForgetPasswordModel data) {
                        String msg = data.message;
                        if (data.status == 1) {
                          codeStatus = 1;
                        } else {
                          codeStatus = 0;
                        }
                        return Text(
                          // AppLocalizations.of(context).translate('CONGRATS!_str')
                          msg,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              // fontSize: SecondaryFont,
                              // color: Theme.of(context).primaryColor,
                              height: 1.5),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ButtonTheme(
                      minWidth: 100.0,
                      height: 30.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('continue_str'),
                          style: TextStyle(
                              color: Colors.white, fontSize: SecondaryFont),
                        ),
                        onPressed: () {
                          if (codeStatus == 1) {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/logInScreen');
                          } else {
                            Navigator.pop(context);
                          }
                          // Navigator.pushReplacementNamed(
                          //     context, '/homeScreen');
                        },
                        color: greyBlue,
                      ),
                    ),
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
}

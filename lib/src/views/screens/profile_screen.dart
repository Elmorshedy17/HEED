import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/profileInfo_bloc.dart';
import 'package:heed/src/blocs/api_bloc/profileUpdate_bloc.dart';
import 'package:heed/src/blocs/editProfile_bloc.dart';
import 'package:heed/src/models/api_models/GET/profileInfo_model.dart';
import 'package:heed/src/models/api_models/POST/login_model.dart';
import 'package:heed/src/models/api_models/POST/profileUpdate_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var editProfile = locator<EditProfileBloc>();

  int codeStatus = 0;
  bool isUpdateClicked = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  bool _enableName = false;
  bool _enableMail = false;
  bool _enableMobile = false;

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
                        AppLocalizations.of(context).translate('profile_str'),
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
                      color: Theme.of(context).primaryColor.withOpacity(.5),
                    ),
                    //  noNotifications(),
                    //   haveNotifications()

                    SizedBox(
                      height: 25.0,
                    ),
                    CustomObserver<ProfileInfoModel>(
                      stream: locator<ProfileInfoBloc>().profileInfo$,
                      onSuccess: (context, ProfileInfoModel data) {
                        User userInfo = data.data.user;
                        return ExpansionTile(
                          onExpansionChanged: (v) {
                            locator<ProfileInfoBloc>()
                                .inLang
                                .add(locator<PrefsService>().appLanguage);
                          },
                          title: Text(
                            AppLocalizations.of(context)
                                .translate('editMyProfile_str'),
                            style: TextStyle(
                                fontSize: PrimaryFont, fontWeight: semiFont),
                          ),
                          children: <Widget>[
                            _nameField(data.status == 1 ? userInfo.name : ''),
                            _emailField(data.status == 1 ? userInfo.email : ''),
                            _phoneField(data.status == 1 ? userInfo.phone : ''),
                            SizedBox(
                              height: 30.0,
                            ),
                            _editButton(),
                            SizedBox(
                              height: 40.0,
                            )
                          ],
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        AppLocalizations.of(context).translate('history_str'),
                        style: TextStyle(
                            fontSize: PrimaryFont, fontWeight: semiFont),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () {
                        locator<TextEditingController>().clear();
                        Navigator.pushNamed(context, '/historyScreen');
                      },
                    ),
                    Divider(
                      endIndent: 15,
                      indent: 15,
                      height: 5,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              locator<PrefsService>().removeUserObj();
                              locator<PrefsService>().hasLoggedIn = false;
                              locator<PrefsService>().hasSignedUp = false;
                              locator<TextEditingController>().clear();
                              Navigator.of(context)
                                  .pushReplacementNamed('/homeScreen');
                              //  Navigator.of(context).pushNamedAndRemoveUntil(
                              //     '/logInScreen', (Route<dynamic> route) => false);
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('logout_str'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: PrimaryFont,
//                    fontFamily: 'hk-grotesk',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField(String name) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 12,
              child: StreamBuilder(
                  stream: editProfile.name,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: nameController,
                      onChanged: editProfile.changeName,
                      style: TextStyle(
                          fontSize: PrimaryFont,
                          color: Theme.of(context).primaryColor),
                      enabled: _enableName,
                      decoration: InputDecoration(
                          errorText: snapshot.error, hintText: name
                          // hintText: locator<PrefsService>().userName
                          //  locator<PrefsService>().registerUser?.name ??
                          //     locator<PrefsService>().loginUser.name,
                          ),
                    );
                  }),
            ),
            Flexible(
              flex: 2,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _enableName = !_enableName;
                  });
                },
                icon: Icon(
                  Icons.mode_edit,
                  color: _enableName ? Theme.of(context).primaryColor : midGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailField(String email) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 12,
              child: StreamBuilder(
                  stream: editProfile.email,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: emailController,
                      onChanged: editProfile.changeEmail,
                      style: TextStyle(
                          fontSize: PrimaryFont,
                          color: Theme.of(context).primaryColor),
                      enabled: _enableMail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          errorText: snapshot.error, hintText: email
                          // hintText: locator<PrefsService>().userEmail
                          // locator<PrefsService>().registerUser?.email ??
                          //     locator<PrefsService>().loginUser.email,
                          ),
                    );
                  }),
            ),
            Flexible(
              flex: 2,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _enableMail = !_enableMail;
                  });
                },
                icon: Icon(
                  Icons.mode_edit,
                  color: _enableMail ? Theme.of(context).primaryColor : midGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _phoneField(String phone) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 12,
              child: StreamBuilder(
                  stream: editProfile.mobile,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: phoneController,
                      onChanged: editProfile.changeMobile,
                      style: TextStyle(
                          fontSize: PrimaryFont,
                          color: Theme.of(context).primaryColor),
                      enabled: _enableMail,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          errorText: snapshot.error, hintText: phone
                          // hintText: locator<PrefsService>().userPhone
                          // locator<PrefsService>().registerUser?.phone ??
                          //     locator<PrefsService>().loginUser.phone,
                          ),
                    );
                  }),
            ),
            Flexible(
              flex: 2,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _enableMobile = !_enableMobile;
                  });
                },
                icon: Icon(
                  Icons.mode_edit,
                  color:
                      _enableMobile ? Theme.of(context).primaryColor : midGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editButton() {
    return StreamBuilder<Object>(
        stream: editProfile.registerValid,
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
                  AppLocalizations.of(context).translate('update_str'),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: snapshot.hasData
                    ? () {
                        print("Profile updated");
                        emailController.text.isNotEmpty
                            ? locator<ProfileUpdateBloc>()
                                .inEmail
                                .add(emailController.text)
                            : locator<ProfileUpdateBloc>()
                                .inEmail
                                .add(locator<PrefsService>().userObj.email);
                        // .add(locator<PrefsService>().userEmail);
                        nameController.text.isNotEmpty
                            ? locator<ProfileUpdateBloc>()
                                .inName
                                .add(nameController.text)
                            : locator<ProfileUpdateBloc>()
                                .inName
                                .add(locator<PrefsService>().userObj.name);
                        // .add(locator<PrefsService>().userName);
                        phoneController.text.isNotEmpty
                            ? locator<ProfileUpdateBloc>()
                                .inPhone
                                .add(phoneController.text)
                            : locator<ProfileUpdateBloc>()
                                .inPhone
                                .add(locator<PrefsService>().userObj.phone);
                        // .add(locator<PrefsService>().userPhone);

                        locator<ProfileUpdateBloc>()
                            .inPassword
                            .add(locator<PrefsService>().userPassword);
                        locator<ProfileUpdateBloc>()
                            .inClick
                            .add(!isUpdateClicked);
                        // locator<ProfileInfoBloc>()
                        //     .inLang
                        //     .add(locator<PrefsService>().appLanguage);

                        if (nameController.text.isNotEmpty ||
                            emailController.text.isNotEmpty ||
                            phoneController.text.isNotEmpty) {
                          _showMaterialDialog(context);
                        }
                      }
                    : null,
              ),
            ),
          );
        });
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
              height: 90,
              // MediaQuery.of(context).size.height * 0.29,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Wrap(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: CustomObserver<ProfileUpdateModel>(
                        stream: locator<ProfileUpdateBloc>().profileUpdate$,
                        onSuccess: (context, ProfileUpdateModel data) {
                          User userUpdate = data.data.user;
                          String msg = data.message;
                          if (data.status == 1) {
                            locator<PrefsService>().userObj = userUpdate;
                            // locator<PrefsService>().userAuth =
                            //     userUpdate.authorization;
                            // locator<PrefsService>().userName = userUpdate.name;
                            // locator<PrefsService>().userEmail = userUpdate.email;
                            // locator<PrefsService>().userPhone = userUpdate.phone;

                            codeStatus = 1;
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
                          }
                          codeStatus = 0;
//                                    return Text('$msg\n${user.authorization}');
                          return Text(
                            // AppLocalizations.of(context).translate('CONGRATS!_str')
                            msg,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                // color: Theme.of(context).primaryColor,
                                height: 1.5),
                          );
                        },
                      ),
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
                          locator<TextEditingController>().clear();
                          Navigator.pop(context);
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

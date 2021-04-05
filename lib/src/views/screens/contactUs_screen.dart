import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/ContactInfo_bloc.dart';
import 'package:heed/src/blocs/api_bloc/contactAction_bloc.dart';
import 'package:heed/src/blocs/contactUs_bloc.dart';
import 'package:heed/src/models/api_models/GET/contactInfo_model.dart';
import 'package:heed/src/models/api_models/POST/contactAction_model.dart';
import 'package:heed/src/services/launchMaps_service.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var contactUsBloc = locator<ContactUsBloc>();

  String email;

  String password;

  int codeStatus = 0;

  bool isSendClicked = false;

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final mobileController = TextEditingController();

  final messageController = TextEditingController();

  FocusNode mailFocusNode = new FocusNode();
  FocusNode mobFocusNode = new FocusNode();
  FocusNode messageFocusNode = new FocusNode();

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
        appBar: AppBar(
          elevation: 0.0,
          title: Text(AppLocalizations.of(context).translate('contactUs_str')),
        ),
        body: GestureDetector(
          onTap: () {
            // call this method here to hide soft keyboard
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/images/signup2.png',
                    fit: BoxFit.cover,
//                color: Color.fromRGBO(255, 255, 255, 0.6),
//                colorBlendMode: BlendMode.modulate
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15
//                    MediaQuery.of(context).size.height * 0.15,
                        ),
                    Card(
                      elevation: 4.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .8,
                        padding: EdgeInsets.only(
                            top: 20.0, right: 20.0, left: 20.0, bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)
                                  .translate('contactUs_str'),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: LargeFont,
                                  fontWeight: semiFont),
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
                                  mailField(),
                                  Container(
                                    height: 10.0,
                                  ),
                                  mobileField(),
                                  Container(
                                    height: 10.0,
                                  ),
                                  messageField(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            sendButton(context),
                            SizedBox(
                              height: 10.0,
                            ),
                            contactDetails(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameField() {
    return StreamBuilder(
//      stream: clinicBloc.nameClinic,
      stream: contactUsBloc.nameClinic,
      builder: (context, snapshot) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (String vo) {
            FocusScope.of(context).requestFocus(mailFocusNode);
          },
          controller: nameController,
//          onChanged: clinicBloc.changeNameClinic,
          onChanged: contactUsBloc.changeNameClinic,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText: AppLocalizations.of(context).translate('name_str'),
//                  AppLocalizations.of(context).translate('clinicName_str'),
              labelText: AppLocalizations.of(context).translate('name_str'),
//                  AppLocalizations.of(context).translate('clinicName_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget mailField() {
    return StreamBuilder(
//      stream: clinicBloc.nameClinicRep,
      stream: contactUsBloc.nameClinicRep,
      builder: (context, snapshot) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          focusNode: mailFocusNode,
          onFieldSubmitted: (String va) {
            FocusScope.of(context).requestFocus(mobFocusNode);
          },
          controller: emailController,
//          onChanged: clinicBloc.changeNameClinicRep,
          onChanged: contactUsBloc.changeNameClinicRep,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText: AppLocalizations.of(context).translate('mail_str'),
//              AppLocalizations.of(context)
//                  .translate('representativeName_str'),
              labelText: AppLocalizations.of(context).translate('mail_str'),
//              AppLocalizations.of(context)
//                  .translate('representativeName_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget mobileField() {
    return StreamBuilder(
      stream: contactUsBloc.mobileClinic,
      builder: (context, snapshot) {
        return TextFormField(
          focusNode: mobFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (String vv) {
            FocusScope.of(context).requestFocus(messageFocusNode);
          },
          controller: mobileController,
          onChanged: contactUsBloc.changeMobileClinic,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText:
                  AppLocalizations.of(context).translate('mobileNumber_str'),
//              AppLocalizations.of(context).translate('mobileNumber_str'),
              labelText:
                  AppLocalizations.of(context).translate('mobileNumber_str'),
//              AppLocalizations.of(context).translate('mobileNumber_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget messageField() {
    return StreamBuilder(
//      stream: clinicBloc.locationClinic,
      stream: contactUsBloc.locationClinic,
      builder: (context, snapshot) {
        return TextFormField(
          focusNode: messageFocusNode,
          textInputAction: TextInputAction.newline,
          controller: messageController,
          maxLines: 6,
          minLines: 3,
//          onChanged: clinicBloc.changeLocationClinic,
          onChanged: contactUsBloc.changeLocationClinic,
          obscureText: false,
          decoration: InputDecoration(
              alignLabelWithHint: true,
              hintText: AppLocalizations.of(context).translate('message_str'),
//              AppLocalizations.of(context).translate('location_str'),
              labelText: AppLocalizations.of(context).translate('message_str'),
//              AppLocalizations.of(context).translate('location_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget sendButton(BuildContext context) {
    return StreamBuilder<Object>(
        stream: contactUsBloc.registerValid,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(top: 40.0, bottom: 35.0),
            child: Center(
              child: ButtonTheme(
                minWidth: 280.0,
                height: 45.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('send_str'),
//                    AppLocalizations.of(context).translate('signup_str'),
                    style: TextStyle(color: Colors.white, fontSize: MainFont),
                  ),
                  onPressed: snapshot.hasData
                      ? () {
                          print("hello mohamed");

                          locator<ContactActionBloc>()
                              .inName
                              .add(nameController.text);
                          locator<ContactActionBloc>()
                              .inEmail
                              .add(emailController.text);
                          locator<ContactActionBloc>()
                              .inPhone
                              .add(mobileController.text);
                          locator<ContactActionBloc>()
                              .inMessage
                              .add(messageController.text);
                          locator<ContactActionBloc>()
                              .inClick
                              .add(!isSendClicked);
                          // locator<ConnectionCheckerService>()
                          //     .getConnectionStatus$
                          //     .listen((status) async {
                          //   if (status == InternetStatus.Offline) {
                          //     await showDialog(
                          //         context: context,
                          //         barrierDismissible: false,
                          //         builder: (context) {
                          //           return AlertDialog(
                          //             content: Container(
                          //               decoration: new BoxDecoration(
                          //                 shape: BoxShape.rectangle,
                          //                 color: const Color(0xFFFFFF),
                          //                 borderRadius: new BorderRadius.all(
                          //                     new Radius.circular(32.0)),
                          //               ),
                          //               height: locator<PrefsService>()
                          //                           .appLanguage ==
                          //                       'en'
                          //                   ? 120
                          //                   : 130,
                          //               width:
                          //                   MediaQuery.of(context).size.width *
                          //                       0.5,
                          //               child: Column(
                          //                 children: <Widget>[
                          //                   Row(
                          //                     children: <Widget>[
                          //                       Image.asset(
                          //                         'assets/images/no-wifi.png',
                          //                         height: 30,
                          //                         width: 30,
                          //                       ),
                          //                       SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Text(
                          //                         AppLocalizations.of(context)
                          //                             .translate(
                          //                                 'noWifiTitle_str'),
                          //                         style: TextStyle(
                          //                             color: primaryColor,
                          //                             fontWeight:
                          //                                 FontWeight.bold,
                          //                             fontSize: 25),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   Container(
                          //                       child: Text(
                          //                     AppLocalizations.of(context)
                          //                         .translate(
                          //                             'noWifiContent_str'),
                          //                     textAlign: TextAlign.center,
                          //                     style: TextStyle(
                          //                         fontSize: 18, height: 1.5),
                          //                   )),
                          //                 ],
                          //               ),
                          //             ),
                          //           );
                          //         });
                          //   } else {
                          //     _showMaterialDialog(context);
                          //   }
                          // });
                          _showMaterialDialog(context);
                        }
                      : null,
                ),
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
            title: Text(
              AppLocalizations.of(context).translate('CONGRATS!_str'),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediumFont, color: Theme.of(context).primaryColor),
            ),
            content: Container(
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
              ),
              height: 90,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(top: 15.0, bottom: 30.0),
//                    height: 55.0,
//                    width: 85.0,
//                    child: Image.asset("assets/images/hand.png"),
//                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: CustomObserver(
                      stream: locator<ContactActionBloc>().contactAction$,
                      onSuccess: (context, ContactActionModel data) {
                        String msg = data.message;
                        return Text(
                          // AppLocalizations.of(context).translate('CONGRATS!_str')
                          msg,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: SecondaryFont,
                              color: Theme.of(context).primaryColor,
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
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, '/homeScreen');
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

  Widget contactDetails(BuildContext context) {
    return CustomObserver(
      stream: locator<ContactInfoBloc>().contactInfo$,
      onSuccess: (context, ContactInfoModel data) {
        Info info = data.data.info;
        return Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                launch('mailto:${info.email}?subject=News&body=New%20message');
              },
              leading: Icon(Icons.email),
              title: Text(info.email),
            ),
            ListTile(
              onTap: () {
                if (Platform.isAndroid) {
                  launch('tel:${info.phone}');
                } else if (Platform.isIOS) {
                  launch("tel://${info.phone}");
                }
              },
              leading: Icon(Icons.phone),
              title: Text(info.phone),
            ),
            ListTile(
              onTap: () {
                if (Platform.isAndroid) {
                  launch('tel:${info.mobile}');
                } else if (Platform.isIOS) {
                  launch('tel://${info.mobile}');
                }
              },
              leading: Icon(Icons.phone),
              title: Text(info.mobile),
            ),
            ListTile(
              onTap: () {
                String lat = info.lat;
                String lng = info.lng;
                LaunchMap.launchMap(lat, lng);
              },
              leading: Icon(Icons.my_location),
              title: Text(
                  AppLocalizations.of(context).translate('ourLocation_str')),
            ),
          ],
        );
      },
    );
  }
}

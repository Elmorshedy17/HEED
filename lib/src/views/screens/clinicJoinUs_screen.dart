import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/joinUs_bloc.dart';
import 'package:heed/src/blocs/clinicJoinUs_bloc.dart';
import 'package:heed/src/models/api_models/POST/joinRequest_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class ClinicJoinUsScreen extends StatefulWidget {
  @override
  _ClinicJoinUsScreenState createState() => _ClinicJoinUsScreenState();
}

class _ClinicJoinUsScreenState extends State<ClinicJoinUsScreen> {
  var clinicBloc = locator<ClinicJoinUsBloc>();

  int codeStatus = 0;
  bool isJoinClicked = false;
  final clinicController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  FocusNode repFocusNode = new FocusNode();
  FocusNode mobiFocusNode = new FocusNode();
  FocusNode locationFocusNode = new FocusNode();

  bool isAlertOnScreen = false;

  @override
  void dispose() {
    // locator<PrefsService>().isOnline = false;
    super.dispose();
  }
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
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: -80.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/images/signup.png',
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .15,
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
                                  .translate('joinUs_str'),
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
                                  nameClinicField(),
                                  Container(
                                    height: 10.0,
                                  ),
                                  nameClinicRepField(),
                                  Container(
                                    height: 10.0,
                                  ),
                                  mobileClinicField(),
                                  Container(
                                    height: 10.0,
                                  ),
                                  clinicLocationField(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            clinicJoinUpButton(),
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

  Widget nameClinicField() {
    return StreamBuilder(
      stream: clinicBloc.nameClinic,
      builder: (context, snapshot) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (String name) {
            FocusScope.of(context).requestFocus(repFocusNode);
          },
          controller: clinicController,
          onChanged: clinicBloc.changeNameClinic,
          decoration: InputDecoration(
              hintText:
                  AppLocalizations.of(context).translate('clinicName_str'),
              labelText:
                  AppLocalizations.of(context).translate('clinicName_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget nameClinicRepField() {
    return StreamBuilder(
      stream: clinicBloc.nameClinicRep,
      builder: (context, snapshot) {
        return TextFormField(
          focusNode: repFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (String rep) {
            FocusScope.of(context).requestFocus(mobiFocusNode);
          },
          controller: nameController,
          onChanged: clinicBloc.changeNameClinicRep,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context)
                  .translate('representativeName_str'),
              labelText: AppLocalizations.of(context)
                  .translate('representativeName_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget mobileClinicField() {
    return StreamBuilder(
      stream: clinicBloc.mobileClinic,
      builder: (context, snapshot) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          focusNode: mobiFocusNode,
          onFieldSubmitted: (String mobil) {
            FocusScope.of(context).requestFocus(locationFocusNode);
          },
          controller: phoneController,
          onChanged: clinicBloc.changeMobileClinic,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
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

  Widget clinicLocationField() {
    return StreamBuilder(
      stream: clinicBloc.locationClinic,
      builder: (context, snapshot) {
        return TextFormField(
          focusNode: locationFocusNode,
          controller: addressController,
          onChanged: clinicBloc.changeLocationClinic,
          obscureText: true,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context).translate('location_str'),
              labelText: AppLocalizations.of(context).translate('location_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  Widget clinicJoinUpButton() {
    return StreamBuilder<Object>(
        stream: clinicBloc.registerValid,
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
                    AppLocalizations.of(context).translate('joinUs_str'),
                    style: TextStyle(color: Colors.white, fontSize: MainFont),
                  ),
                  onPressed: snapshot.hasData
                      ? () {
                          print("hello mohamed");
                          locator<JoinUsBloc>()
                              .inName
                              .add(nameController.value.text);
                          locator<JoinUsBloc>()
                              .inAddress
                              .add(addressController.value.text);
                          locator<JoinUsBloc>()
                              .inClinic
                              .add(clinicController.value.text);
                          locator<JoinUsBloc>()
                              .inPhone
                              .add(phoneController.value.text);
                          locator<JoinUsBloc>().inClick.add(!isJoinClicked);
                          _showMaterialDialog();
                        }
                      : null,
                ),
              ),
            ),
          );
        });
  }

  void _showMaterialDialog() {
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
              height: MediaQuery.of(context).size.height * 0.29,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15.0, bottom: 30.0),
                    height: 55.0,
                    width: 85.0,
                    child: Image.asset("assets/images/hand.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: CustomObserver(
                      stream: locator<JoinUsBloc>().joinUs$,
                      onSuccess: (context, JoinUsModel data) {
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
}

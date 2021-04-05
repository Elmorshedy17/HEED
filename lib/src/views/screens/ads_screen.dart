import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/home_bloc.dart';
import 'package:heed/src/models/api_models/GET/homeScreen_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/clinicSections_screen.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class AdsScreen extends StatefulWidget {
  static _AdsScreenState of(BuildContext context) =>
      context.findAncestorStateOfType();
  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  var x = Colors.red;
  bool isAlertOnScreen = false;
  @override
  void dispose() {
    // locator<PrefsService>().isOnline = false;
    super.dispose();
  }
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
//          setState(() {});
//        }
//      }
//    });

    return NetworkSensitive(
      child: Scaffold(
        body: Container(
            child:
//          CustomObserver<HomeScreenModel>(
//              stream: locator<HomeBloc>().home$,
//              onSuccess: (context, data) {
//                var content = data.data;
//                return
                Stack(
          children: <Widget>[
            CustomObserver<HomeScreenModel>(
                stream: locator<HomeBloc>().home$,
                onSuccess: (context, data) {
                  var content = data.data;
                  return InkWell(
                    onTap: () {
                      /*Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ClinicSectionsScreen(
      id: carouselList[index].clinicId,
      );*/

                      if (content.ads.clinicId != 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) {
                            return ClinicSectionsScreen(
                              id: content.ads.clinicId,
                            );
                          }),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(content.ads.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
//                    child: FlatButton(
//                      onPressed: () {
//                        /*Navigator.push(context, MaterialPageRoute(builder: (_) {
//    return ClinicSectionsScreen(
//    id: carouselList[index].clinicId,
//    );*/
//
//
//                        if( content.ads.clinicId != 0 ){
//                          Navigator.push(context, MaterialPageRoute(builder: (_) {
//                            return ClinicSectionsScreen(
//                              id: content.ads.clinicId,
//                            );
//                          }),);
//                        }
//
//
//                        },
//                    ),
                    ),
                  );
                }
//                      child: InkWell(
//                        onTap: () {
//                          /*Navigator.push(context, MaterialPageRoute(builder: (_) {
//      return ClinicSectionsScreen(
//      id: carouselList[index].clinicId,
//      );*/
//
//                          if (content.ads.clinicId != 0) {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (_) {
//                                return ClinicSectionsScreen(
//                                  id: content.ads.clinicId,
//                                );
//                              }),
//                            );
//                          }
//                        },
//                        child: Container(
//                          decoration: BoxDecoration(
//                            image: DecorationImage(
//                              image: NetworkImage(content.ads.image),
//                              fit: BoxFit.cover,
//                            ),
//                          ),
//                          width: MediaQuery.of(context).size.width,
//                          height: MediaQuery.of(context).size.height,
////                    child: FlatButton(
////                      onPressed: () {
////                        /*Navigator.push(context, MaterialPageRoute(builder: (_) {
////    return ClinicSectionsScreen(
////    id: carouselList[index].clinicId,
////    );*/
////
////
////                        if( content.ads.clinicId != 0 ){
////                          Navigator.push(context, MaterialPageRoute(builder: (_) {
////                            return ClinicSectionsScreen(
////                              id: content.ads.clinicId,
////                            );
////                          }),);
////                        }
////
////
////                        },
////                    ),
//                        ),
//                      ),
                ),
            Positioned(
              top: 40.0,
              right: 30.0,
              child: ButtonTheme(
                height: 40.0,
                minWidth: 100.0,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100.0)),
                  color: Colors.black38,
                  child: FittedBox(
                    child: Text(
                      AppLocalizations.of(context).translate('skip_ads'),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: bolFont,
                          fontSize: PrimaryFont),
                    ),
                  ),
                  onPressed: () {
                    // locator<PrefsService>().isOnline = false;
                    Navigator.pushReplacementNamed(context, '/homeScreen');
                  },
                ),
              ),
            ),
          ],
        )
//              }),
            ),
      ),
    );
  }
}

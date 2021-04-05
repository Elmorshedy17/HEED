import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/favoriteAction_bloc.dart';
import 'package:heed/src/blocs/api_bloc/favorites_bloc.dart';
import 'package:heed/src/blocs/api_bloc/ourClinics_bloc.dart';
import 'package:heed/src/blocs/searchClinics_bloc.dart';
import 'package:heed/src/models/api_models/GET/category_model.dart';
import 'package:heed/src/models/api_models/GET/favorites_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/clinicSections_screen.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class FavoriteClinicsScreen extends StatefulWidget {
  static _FavoriteClinicsScreenState of(BuildContext context) =>
      context.findAncestorStateOfType();
  @override
  _FavoriteClinicsScreenState createState() => _FavoriteClinicsScreenState();
}

class _FavoriteClinicsScreenState extends State<FavoriteClinicsScreen> {
  bool isDeleteBtnClicked = false;
  int codeStatus = 0;
  int id;
  bool isQueryEmpty = true;

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
    ///////
    locator<ClinicsSearchBloc>().query$.listen(
        (value) => value.isEmpty ? isQueryEmpty = true : isQueryEmpty = false);
    ////////

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
                        AppLocalizations.of(context).translate('favorite_str'),
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
                    SizedBox(
                      height: 15.0,
                    ),
                    locator<PrefsService>().userObj != null
                        ? isQueryEmpty
                            ? CustomObserver(
                                stream: locator<FavoritesBloc>().favorites$,
                                onSuccess: (context, FavoritesModel data) {
                                  List<Clinics> content = data.data.clinics;
                                  locator<ClinicsSearchBloc>()
                                      .inClinics
                                      .add(content);
                                  return data.status == 1
                                      ? Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: ListView.builder(
                                              itemCount: content.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  // key: Key(favoriteItems[index].id.toString()),
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    locator<TextEditingController>()
                                                        .clear();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ClinicSectionsScreen(
                                                          id: content[index].id,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.0,
                                                            horizontal: 6.0),
                                                    height: 160.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          new BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            content[index]
                                                                .image),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                          bottom: 0,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  content[index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize: 16,
                                                                      // fontSize: MediumFont,
                                                                      color: Colors.white,
                                                                      fontWeight: semiFont),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.0,
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      100,
                                                                  child: Text(
                                                                      content[index]
                                                                          .address,
                                                                      style: TextStyle(
                                                                          fontSize: 16,
                                                                          // fontSize: MediumFont,
                                                                          color: Colors.white,
                                                                          fontWeight: semiFont)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        locator<PrefsService>()
                                                                    .appLanguage ==
                                                                'en'
                                                            ? Positioned(
                                                                bottom: 10.0,
                                                                right: 0.0,
                                                                child:
                                                                    FlatButton(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/images/mainIcons1X/delete.png",
                                                                    height:
                                                                        25.0,
                                                                    width: 22.0,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    // id = content[index].id;
                                                                    FavoriteActionBloc(
                                                                        id: content[index]
                                                                            .id)
                                                                      ..inAction
                                                                          .add(
                                                                              'delete')
                                                                      ..inClick.add(
                                                                          !isDeleteBtnClicked);
                                                                    // locator<FavoritesBloc>().inLang.add(
                                                                    //     locator<PrefsService>()
                                                                    //                 .appLanguage ==
                                                                    //             'en'
                                                                    //         ? 'ar'
                                                                    //         : 'en');
                                                                    locator<FavoritesBloc>()
                                                                        .inLang
                                                                        .add(locator<PrefsService>()
                                                                            .appLanguage);
                                                                    locator<OurClinicsBloc>()
                                                                        .inLang
                                                                        .add(locator<PrefsService>()
                                                                            .appLanguage);
                                                                    // _showMaterialDialog();
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                ),
                                                              )
                                                            : Positioned(
                                                                bottom: 10.0,
                                                                left: 0.0,
                                                                child:
                                                                    FlatButton(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/images/mainIcons1X/delete.png",
                                                                    height:
                                                                        25.0,
                                                                    width: 22.0,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    // id = content[index].id;
                                                                    FavoriteActionBloc(
                                                                        id: content[index]
                                                                            .id)
                                                                      ..inAction
                                                                          .add(
                                                                              'delete')
                                                                      ..inClick.add(
                                                                          !isDeleteBtnClicked);
                                                                    // locator<FavoritesBloc>().inLang.add(
                                                                    //     locator<PrefsService>()
                                                                    //                 .appLanguage ==
                                                                    //             'en'
                                                                    //         ? 'ar'
                                                                    //         : 'en');
                                                                    locator<FavoritesBloc>()
                                                                        .inLang
                                                                        .add(locator<PrefsService>()
                                                                            .appLanguage);
                                                                    locator<OurClinicsBloc>()
                                                                        .inLang
                                                                        .add(locator<PrefsService>()
                                                                            .appLanguage);
                                                                    // _showMaterialDialog();
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )
                                      : Center(
                                          child: Text(
                                            locator<PrefsService>().appLanguage == 'en' ?'Please login first': 'برجاء تسجيل الدخول اولا',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.deepOrange),
                                          ),
                                        );
                                },
                              )
                            :
                            ////////////////////////////////////////////////////////////////////////
                            // Search
                            ///////////////////////////////////////////////////////////////
                            CustomObserver(
                                stream: locator<ClinicsSearchBloc>()
                                    .filteredClinics$,
                                onSuccess: (context, List<Clinics> data) {
                                  List<Clinics> searchContent = data;
                                  return searchContent.isNotEmpty
                                      ? Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: ListView.builder(
                                              itemCount: searchContent.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  // key: Key(favoriteItems[index].id.toString()),
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    locator<TextEditingController>()
                                                        .clear();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ClinicSectionsScreen(
                                                          id: searchContent[
                                                                  index]
                                                              .id,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.0,
                                                            horizontal: 6.0),
                                                    height: 160.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          new BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            searchContent[index]
                                                                .image),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                          bottom: 0,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  searchContent[
                                                                          index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize: 16,
                                                                      // fontSize: MediumFont,
                                                                      color: Colors.white,
                                                                      fontWeight: semiFont),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.0,
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      100,
                                                                  child: Text(
                                                                      searchContent[
                                                                              index]
                                                                          .address,
                                                                      style: TextStyle(
                                                                          fontSize: 16,
                                                                          // fontSize: MediumFont,
                                                                          color: Colors.white,
                                                                          fontWeight: semiFont)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        locator<PrefsService>()
                                                                    .appLanguage ==
                                                                'en'
                                                            ? Positioned(
                                                                bottom: 10.0,
                                                                right: 0.0,
                                                                child:
                                                                    FlatButton(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/images/mainIcons1X/delete.png",
                                                                    height:
                                                                        25.0,
                                                                    width: 22.0,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            new FocusNode());
                                                                    // id = content[index].id;
                                                                    FavoriteActionBloc(
                                                                        id: searchContent[index]
                                                                            .id)
                                                                      ..inAction
                                                                          .add(
                                                                              'delete')
                                                                      ..inClick.add(
                                                                          !isDeleteBtnClicked);
                                                                    // locator<FavoritesBloc>().inLang.add(
                                                                    //     locator<PrefsService>()
                                                                    //                 .appLanguage ==
                                                                    //             'en'
                                                                    //         ? 'ar'
                                                                    //         : 'en');
                                                                    locator<FavoritesBloc>()
                                                                        .inLang
                                                                        .add(locator<PrefsService>()
                                                                            .appLanguage);
                                                                    locator<OurClinicsBloc>()
                                                                        .inLang
                                                                        .add(locator<PrefsService>()
                                                                            .appLanguage);
                                                                    // _showMaterialDialog();
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                ),
                                                              )
                                                            : Positioned(
                                                                bottom: 10.0,
                                                                left: 0.0,
                                                                child:
                                                                    FlatButton(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/images/mainIcons1X/delete.png",
                                                                    height:
                                                                        25.0,
                                                                    width: 22.0,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            new FocusNode());
                                                                    // id = content[index].id;
                                                                    FavoriteActionBloc(
                                                                        id: searchContent[index]
                                                                            .id)
                                                                      ..inAction
                                                                          .add(
                                                                              'delete')
                                                                      ..inClick.add(
                                                                          !isDeleteBtnClicked);
                                                                    // locator<FavoritesBloc>().inLang.add(
                                                                    //     locator<PrefsService>()
                                                                    //                 .appLanguage ==
                                                                    //             'en'
                                                                    //         ? 'ar'
                                                                    //         : 'en');
                                                                    locator<FavoritesBloc>()
                                                                        .inLang
                                                                        .add(locator<PrefsService>()
                                                                            .appLanguage);
                                                                    locator<OurClinicsBloc>()
                                                                        .inLang
                                                                        .add(locator<PrefsService>()
                                                                            .appLanguage);
                                                                    // _showMaterialDialog();
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )
                                      : Center(
                                          child: Text(AppLocalizations.of(
                                                  context)
                                              .translate('noSearchResult_str')),
                                        );
                                },
                              )
                        /////////////////////////////////////////////////////////////////
                        ////////////////////////////////////////////////////////////////
                        : Center(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('PleaseLoginFirst_str'),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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

  //////////////////////////////////////////////////////////
//  void _showMaterialDialog() {
//    showDialog(
//        barrierDismissible: false,
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            contentPadding: EdgeInsets.all(15.0),
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(20.0))),
//            title: Text(
//              AppLocalizations.of(context).translate('CONGRATS!_str'),
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                  fontSize: MediumFont, color: Theme.of(context).primaryColor),
//            ),
//            content: Container(
//              decoration: new BoxDecoration(
//                shape: BoxShape.rectangle,
//                color: const Color(0xFFFFFF),
//                borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
//              ),
//              height: MediaQuery.of(context).size.height * 0.29,
//              width: MediaQuery.of(context).size.width * 0.5,
//              child: Column(
//                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(top: 15.0, bottom: 30.0),
//                    height: 55.0,
//                    width: 85.0,
//                    child: Image.asset("assets/images/hand.png"),
//                  ),
//                  Container(
//                    margin: EdgeInsets.only(bottom: 15.0),
//                    child: CustomObserver(
//                      stream: FavoriteActionBloc(id: id).favoriteAction$,
//                      onSuccess: (context, FavoritesActionsModel data) {
//                        String msg = data.message;
//                        return Text(
//                          // AppLocalizations.of(context).translate('CONGRATS!_str')
//                          msg,
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                              fontSize: SecondaryFont,
//                              color: Theme.of(context).primaryColor,
//                              height: 1.5),
//                        );
//                      },
//                    ),
//                  ),
//                  Center(
//                    child: ButtonTheme(
//                      minWidth: 100.0,
//                      height: 30.0,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                          borderRadius: new BorderRadius.circular(25.0),
//                        ),
//                        child: Text(
//                          AppLocalizations.of(context)
//                              .translate('continue_str'),
//                          style: TextStyle(
//                              color: Colors.white, fontSize: SecondaryFont),
//                        ),
//                        onPressed: () {
//                          Navigator.pop(context);
//                          // Navigator.pushReplacementNamed(
//                          //     context, '/homeScreen');
//                        },
//                        color: greyBlue,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            titlePadding: EdgeInsets.only(top: 35.0),
////            actions: <Widget>[
////              ,
////            ],
//          );
//        });
//  }
}

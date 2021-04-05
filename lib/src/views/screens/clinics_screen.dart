import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/clinics_bloc.dart';
import 'package:heed/src/blocs/api_bloc/favoriteAction_bloc.dart';
import 'package:heed/src/blocs/api_bloc/favorites_bloc.dart';
import 'package:heed/src/blocs/api_bloc/ourClinics_bloc.dart';
import 'package:heed/src/blocs/searchClinics_bloc.dart';
import 'package:heed/src/models/api_models/GET/category_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/clinicSections_screen.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class ClinicsScreenArguments {
  final int id;

  ClinicsScreenArguments(this.id);
}

class ClinicsScreen extends StatefulWidget {
  static _ClinicsScreenState of(BuildContext context) =>
      context.findAncestorStateOfType();

  // final int id;

  // const ClinicsScreen({Key key, this.id}) : super(key: key);

  @override
  _ClinicsScreenState createState() => _ClinicsScreenState();
}

class _ClinicsScreenState extends State<ClinicsScreen> {
  bool isFavoriteBtnClicked = false;
  bool isQueryEmpty = true;
  ClinicsScreenArguments args;
  bool isAlertOnScreen = false;
  // bool isFavoriteIconClicked=false;
  // int codeStatus = 0;
  // int clinicId;
//  bool isAlertOnScreen = false;
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
    /////////
    locator<ClinicsSearchBloc>().query$.listen(
        (value) => value.isEmpty ? isQueryEmpty = true : isQueryEmpty = false);
    ///////
    args = ModalRoute.of(context).settings.arguments;
    ////////
//
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
            floatingActionButton: FloatingActionButton(
              // child: Icon(Icons.filter),
              child: Icon(FontAwesomeIcons.filter),
              // child: Icon(FontAwesomeIcons.filter),
              backgroundColor: primaryColor,
              onPressed: () {
                locator<TextEditingController>().clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/homeScreen', (Route<dynamic> route) => false);
                // Navigator.pushNamed(context, '/homeScreen');
                // // onFloatingActionButtonPressed();
                // FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
            body: RootApp(
              child: isQueryEmpty
                  ? CustomObserver<CategoryModel>(
                      stream: ClinicsBloc(id: args.id).clinics$,
//            stream: ClinicsBloc(id: widget.id).clinics$,
                      onSuccess: (context, data) {
                        List<Clinics> content = data.data.clinics;
                        locator<ClinicsSearchBloc>().inClinics.add(content);

                        return ListView.builder(
                            itemCount: content.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  //     Navigator.pushNamed(context, '/clinicSectionsScreen');
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  locator<TextEditingController>().clear();
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
                                  margin: EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 6.0),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Container(
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(5.0)),
                                        image: DecorationImage(
                                          image: NetworkImage(content[index].image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
////////////////////////////////////////////////////////////////////////////////////////////////////
                                          locator<PrefsService>().appLanguage ==
                                                  'en'
                                              ? Positioned(
                                                  right: 0,
                                                  child: Container(
                                                    padding: EdgeInsets.all(15.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: content[index]
                                                                      .favourite ==
                                                                  'yes'
                                                              ? Icon(
                                                                  Icons.favorite,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 35.0,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .favorite_border,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 35.0,
                                                                ),
                                                          onPressed: () {
                                                            FocusScope.of(context)
                                                                .requestFocus(
                                                                    new FocusNode());
                                                            if (locator<PrefsService>()
                                                                    .userObj !=
                                                                null) {
                                                              FavoriteActionBloc(
                                                                  id: content[index]
                                                                      .id)
                                                                ..inAction.add(
                                                                    content[index]
                                                                                .favourite ==
                                                                            'yes'
                                                                        ? 'delete'
                                                                        : 'add')
                                                                ..inClick.add(
                                                                    !isFavoriteBtnClicked);
                                                              locator<FavoritesBloc>()
                                                                  .inLang
                                                                  .add('en');
                                                              // ClinicsBloc(id: widget.id)
                                                              //     .inLang
                                                              //     .add(locator<PrefsService>()
                                                              //                 .appLanguage ==
                                                              //             'en'
                                                              //         ? 'ar'
                                                              //         : 'en');
                                                              ClinicsBloc(
                                                                      id: args.id)
                                                                  .inLang
                                                                  .add('en');
                                                              locator<OurClinicsBloc>()
                                                                  .inLang
                                                                  .add('en');
                                                              setState(() {});
                                                            } else {
                                                              _showPleaseLoginDialog();
                                                            }
                                                          },
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              top: 40.0),
                                                          child: content[index]
                                                                      .s24Hours ==
                                                                  'yes'
                                                              ? Image.asset(
//                                                              "assets/images/mainIcons1X/delivery.png",
                                                                  "assets/images/1.55x/delivery@2x.png",
                                                                  width: 60,
                                                                  height: 60,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                )
                                                              : null,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Positioned(
                                                  left: 0,
                                                  child: Container(
                                                    padding: EdgeInsets.all(15.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: content[index]
                                                                      .favourite ==
                                                                  'yes'
                                                              ? Icon(
                                                                  Icons.favorite,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 35.0,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .favorite_border,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 35.0,
                                                                ),
                                                          onPressed: () {
                                                            FocusScope.of(context)
                                                                .requestFocus(
                                                                    new FocusNode());
                                                            if (locator<PrefsService>()
                                                                    .userObj !=
                                                                null) {
                                                              FavoriteActionBloc(
                                                                  id: content[index]
                                                                      .id)
                                                                ..inAction.add(
                                                                    content[index]
                                                                                .favourite ==
                                                                            'yes'
                                                                        ? 'delete'
                                                                        : 'add')
                                                                ..inClick.add(
                                                                    !isFavoriteBtnClicked);
                                                              locator<FavoritesBloc>()
                                                                  .inLang
                                                                  .add('ar');
                                                              // ClinicsBloc(id: widget.id)
                                                              //     .inLang
                                                              //     .add(locator<PrefsService>()
                                                              //                 .appLanguage ==
                                                              //             'ar'
                                                              //         ? 'en'
                                                              //         : 'ar');
                                                              ClinicsBloc(
                                                                      id: args.id)
                                                                  .inLang
                                                                  .add('ar');
                                                              locator<OurClinicsBloc>()
                                                                  .inLang
                                                                  .add('ar');
                                                              setState(() {});
                                                            } else {
                                                              _showPleaseLoginDialog();
                                                            }
                                                          },
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              top: 40.0),
                                                          child: content[index]
                                                                      .s24Hours ==
                                                                  'yes'
                                                              ? Image.asset(
//                                                          "assets/images/mainIcons1X/delivery.png",
                                                                  "assets/images/1.55x/delivery@2x.png",
                                                                  width: 60,
                                                                  height: 60,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                )
                                                              : null,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
////////////////////////////////////////////////////////////////////////////////////////////
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    content[index].name,
                                                    style: TextStyle(
                                                        fontSize: PrimaryFont, color: Colors.white, fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        100,
                                                    child: Text(
                                                        content[index].address,
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
                      stream: locator<ClinicsSearchBloc>().filteredClinics$,
                      onSuccess: (context, List<Clinics> data) {
                        List<Clinics> searchContent = data;
                        return searchContent.isNotEmpty
                            ? ListView.builder(
                                itemCount: searchContent.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      //     Navigator.pushNamed(context, '/clinicSectionsScreen');
                                      locator<TextEditingController>().clear();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ClinicSectionsScreen(
                                            id: searchContent[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 6.0),
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(5.0)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              searchContent[index].image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
////////////////////////////////////////////////////////////////////////////////////////////////////
                                          locator<PrefsService>().appLanguage ==
                                                  'en'
                                              ? Positioned(
                                                  right: 0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(15.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: searchContent[
                                                                          index]
                                                                      .favourite ==
                                                                  'yes'
                                                              ? Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 35.0,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .favorite_border,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 35.0,
                                                                ),
                                                          onPressed: () {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    new FocusNode());
                                                            if (locator<PrefsService>()
                                                                    .userObj !=
                                                                null) {
                                                              FavoriteActionBloc(
                                                                  id: searchContent[
                                                                          index]
                                                                      .id)
                                                                ..inAction.add(
                                                                    searchContent[index].favourite ==
                                                                            'yes'
                                                                        ? 'delete'
                                                                        : 'add')
                                                                ..inClick.add(
                                                                    !isFavoriteBtnClicked);
                                                              locator<FavoritesBloc>()
                                                                  .inLang
                                                                  .add('en');
                                                              // ClinicsBloc(id: widget.id)
                                                              //     .inLang
                                                              //     .add(locator<PrefsService>()
                                                              //                 .appLanguage ==
                                                              //             'en'
                                                              //         ? 'ar'
                                                              //         : 'en');
                                                              ClinicsBloc(
                                                                      id: args
                                                                          .id)
                                                                  .inLang
                                                                  .add('en');
                                                              locator<OurClinicsBloc>()
                                                                  .inLang
                                                                  .add('en');
                                                              setState(() {});
                                                            } else {
                                                              _showPleaseLoginDialog();
                                                            }
                                                          },
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 40.0),
                                                          child: searchContent[
                                                                          index]
                                                                      .s24Hours ==
                                                                  'yes'
                                                              ? Image.asset(
//                                                              'assets/images/1.55x/delivery@2x.png'
//                                                              "assets/images/mainIcons1X/delivery.png",
                                                                  "assets/images/1.55x/delivery@2x.png",
                                                                  width: 60,
                                                                  height: 60,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                )
                                                              : null,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Positioned(
                                                  left: 0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(15.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: searchContent[
                                                                          index]
                                                                      .favourite ==
                                                                  'yes'
                                                              ? Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 35.0,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .favorite_border,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  size: 35.0,
                                                                ),
                                                          onPressed: () {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    new FocusNode());
                                                            if (locator<PrefsService>()
                                                                    .userObj !=
                                                                null) {
                                                              FavoriteActionBloc(
                                                                  id: searchContent[
                                                                          index]
                                                                      .id)
                                                                ..inAction.add(
                                                                    searchContent[index].favourite ==
                                                                            'yes'
                                                                        ? 'delete'
                                                                        : 'add')
                                                                ..inClick.add(
                                                                    !isFavoriteBtnClicked);
                                                              locator<FavoritesBloc>()
                                                                  .inLang
                                                                  .add('ar');
                                                              // ClinicsBloc(id: widget.id)
                                                              //     .inLang
                                                              //     .add(locator<PrefsService>()
                                                              //                 .appLanguage ==
                                                              //             'ar'
                                                              //         ? 'en'
                                                              //         : 'ar');
                                                              ClinicsBloc(
                                                                      id: args
                                                                          .id)
                                                                  .inLang
                                                                  .add('ar');
                                                              locator<OurClinicsBloc>()
                                                                  .inLang
                                                                  .add('ar');
                                                              setState(() {});
                                                            } else {
                                                              _showPleaseLoginDialog();
                                                            }
                                                          },
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 40.0),
                                                          child: searchContent[
                                                                          index]
                                                                      .s24Hours ==
                                                                  'yes'
                                                              ? Image.asset(
//                                                              "assets/images/mainIcons1X/delivery.png",
                                                                  "assets/images/1.55x/delivery@2x.png",
                                                                  width: 60,
                                                                  height: 60,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                )
                                                              : null,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
////////////////////////////////////////////////////////////////////////////////////////////
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    searchContent[index].name,
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            100,
                                                    child: Text(
                                                        searchContent[index]
                                                            .address,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            // fontSize: MediumFont,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                semiFont)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Center(
                                child: Text(AppLocalizations.of(context)
                                    .translate('noSearchResult_str')),
                              );
                      },
                    ),
            )),
      ),
    );
  }

  void _showPleaseLoginDialog() {
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
                        AppLocalizations.of(context)
                            .translate('PleaseLoginFirst_str'),
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
                            style: TextStyle(
                                color: Colors.white, fontSize: SecondaryFont),
                          ),
                          onPressed: () {
                            locator<TextEditingController>().clear();
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, '/logInScreen');
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
                            AppLocalizations.of(context)
                                .translate('notNow_str'),
                            style: TextStyle(
                                color: Colors.white, fontSize: SecondaryFont),
                          ),
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Navigator.pop(context);
                            // Navigator.pushReplacementNamed(Dia
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

  //////////////////////////////////////////////////////////////////////////////////////
  // void onFloatingActionButtonPressed() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           color: Color(0xFF737373),
  //           height: 180,
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: primaryColor,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: const Radius.circular(10),
  //                 topRight: const Radius.circular(10),
  //               ),
  //             ),
  //             child: Column(
  //               children: <Widget>[
  //                 ListTile(
  //                   leading: Icon(
  //                     FontAwesomeIcons.commentDollar,
  //                     color: Colors.white,
  //                   ),
  //                   title: Text(
  //                     AppLocalizations.of(context).translate('lowPrice_str'),
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   onTap: () {
  //                     selectFilter('low_price');
  //                     // ClinicsScreen.of(context).setState(() {});
  //                   },
  //                 ),
  //                 ListTile(
  //                   leading: Icon(
  //                     FontAwesomeIcons.commentDollar,
  //                     color: Colors.white,
  //                   ),
  //                   title: Text(
  //                     AppLocalizations.of(context).translate('highPrice_str'),
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   onTap: () => selectFilter('high_price'),
  //                 ),
  //                 ListTile(
  //                   leading: Icon(
  //                     FontAwesomeIcons.handHoldingUsd,
  //                     color: Colors.white,
  //                   ),
  //                   title: Text(
  //                     AppLocalizations.of(context).translate('offers_str'),
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   onTap: () => selectFilter('offer'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // void selectFilter(String filter) {
  //   Navigator.pop(context);
  //   setState(() {
  //     ClinicsBloc(id: args.id)
  //       ..inFilter.add(filter)
  //       ..inLang.add(locator<PrefsService>().appLanguage);
  //   });
  // }
}

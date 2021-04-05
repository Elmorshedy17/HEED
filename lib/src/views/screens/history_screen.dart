import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/reservations_bloc.dart';
import 'package:heed/src/blocs/searchHistory_bloc.dart';
import 'package:heed/src/models/api_models/GET/reservations_model.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class HistoryScreen extends StatefulWidget {
  static _HistoryScreenState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isQueryEmpty = true;

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
    ///////
    locator<HistorySearchBloc>().query$.listen(
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
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // To home screen
//                    Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),
                      Text(
                          AppLocalizations.of(context).translate('history_str'),
                          style: TextStyle(
                            fontSize: MainFont,
                            color: Theme.of(context).primaryColor,
                          )),
                    ],
                  ),
                ),
                Divider(
                  endIndent: 15,
                  indent: 15,
                  height: 5,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: isQueryEmpty
                        ? CustomObserver<ReservationsModel>(
                            stream: locator<ReservationsBloc>().reservations$,
                            onSuccess: (context, ReservationsModel data) {
                              List<Reservations> reservations =
                                  data.data.reservations;
                              locator<HistorySearchBloc>()
                                  .inHistory
                                  .add(reservations);
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: reservations.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return FittedBox(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'clinicName:_str'),
                                                      style: TextStyle(
                                                          fontSize:
                                                              SecondaryFont,
                                                          color: Colors.black,
                                                          fontWeight: bolFont),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      reservations[index]
                                                          .clinic,
                                                      style: TextStyle(
                                                          fontSize: PrimaryFont,
                                                          fontWeight: medFont,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                    SizedBox(
                                                      height: 15.0,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'dateOfVisit:_str'),
                                                      style: TextStyle(
                                                          fontSize:
                                                              SecondaryFont,
                                                          color: Colors.black,
                                                          fontWeight: bolFont),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      reservations[index].date,
                                                      style: TextStyle(
                                                          fontSize: PrimaryFont,
                                                          fontWeight: medFont,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                    SizedBox(
                                                      height: 15.0,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          'doctorName:_str'),
                                                  style: TextStyle(
                                                      fontSize: SecondaryFont,
                                                      color: Colors.black,
                                                      fontWeight: bolFont),
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  reservations[index].doctor,
                                                  style: TextStyle(
                                                      fontSize: PrimaryFont,
                                                      fontWeight: medFont,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: Divider(
                                        endIndent: 15,
                                        indent: 15,
                                        color: Colors.black54,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        :
                        ////////////////////////////////////////////////////////////////////////
                        // Search
                        ///////////////////////////////////////////////////////////////,
                        CustomObserver(
                            stream:
                                locator<HistorySearchBloc>().filteredHistory$,
                            onSuccess: (context, List<Reservations> data) {
                              List<Reservations> reservationsSearch = data;
                              return reservationsSearch.isNotEmpty
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: reservationsSearch.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return FittedBox(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'clinicName:_str'),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    SecondaryFont,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    bolFont),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text(
                                                            reservationsSearch[
                                                                    index]
                                                                .clinic,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    PrimaryFont,
                                                                fontWeight:
                                                                    medFont,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                          ),
                                                          SizedBox(
                                                            height: 15.0,
                                                          ),
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'dateOfVisit:_str'),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    SecondaryFont,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    bolFont),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text(
                                                            reservationsSearch[
                                                                    index]
                                                                .date,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    PrimaryFont,
                                                                fontWeight:
                                                                    medFont,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                          ),
                                                          SizedBox(
                                                            height: 15.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'doctorName:_str'),
                                                        style: TextStyle(
                                                            fontSize:
                                                                SecondaryFont,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                bolFont),
                                                      ),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        reservationsSearch[
                                                                index]
                                                            .doctor,
                                                        style: TextStyle(
                                                            fontSize:
                                                                PrimaryFont,
                                                            fontWeight: medFont,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15.0),
                                            child: Divider(
                                              endIndent: 15,
                                              indent: 15,
                                              color: Colors.black54,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Text(AppLocalizations.of(context)
                                          .translate('noSearchResult_str')),
                                    );
                            },
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

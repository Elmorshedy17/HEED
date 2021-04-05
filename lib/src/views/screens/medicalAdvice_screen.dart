import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/medicalAdvice_bloc.dart';
import 'package:heed/src/blocs/searchMedicalAdvice_bloc.dart';
import 'package:heed/src/models/api_models/GET/medicalAdvice_model.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

import 'medicalAdviceDetails_screen.dart';

class MedicalAdviceScreen extends StatefulWidget {
  static _MedicalAdviceScreenState of(BuildContext context) =>
      context.findAncestorStateOfType();
  @override
  _MedicalAdviceScreenState createState() => _MedicalAdviceScreenState();
}

class _MedicalAdviceScreenState extends State<MedicalAdviceScreen> {
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
    locator<MedicalSearchBloc>().query$.listen(
        (value) => value.isEmpty ? isQueryEmpty = true : isQueryEmpty = false);

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
                  title: Text(
                      AppLocalizations.of(context)
                          .translate('medicalAdvice_str'),
                      style: TextStyle(
                        fontSize: MainFont,
                        color: Theme.of(context).primaryColor,
                      )),
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
                      ? CustomObserver(
                          stream: locator<MedicalAdviceBloc>().medicalAdvice$,
                          onSuccess: (context, MedicalAdviceModel data) {
                            List<MedicalAdvice> content =
                                data.data.medicalAdvice;
                            locator<MedicalSearchBloc>().inMedical.add(content);
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: content.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    locator<TextEditingController>().clear();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MedicalAdviceDetailsScreen(
                                                id: content[index].id),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            width: 110,
                                            // MediaQuery.of(context).size.width * 0.25,
                                            height: 110,
                                            //  MediaQuery.of(context).size.width * 0.25,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    content[index].image),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: ListTile(
                                            title: Text(
                                              content[index].title,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: PrimaryFont),
                                            ),
                                            subtitle: Text(
                                              content[index].desc,
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                            ),
                                            // onTap: () {
                                            //   Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           MedicalAdviceDetailsScreen(
                                            //         id: content[index].id,
                                            //       ),
                                            //     ),
                                            //   );
                                            // },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      :
                      ////////////////////////////////////////////////////////////////////////
                      // Search
                      ///////////////////////////////////////////////////////////////
                      CustomObserver(
                          stream: locator<MedicalSearchBloc>().filteredMedical$,
                          onSuccess: (context, List<MedicalAdvice> data) {
                            List<MedicalAdvice> searchContent = data;
                            return searchContent.isNotEmpty
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: searchContent.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          locator<TextEditingController>()
                                              .clear();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MedicalAdviceDetailsScreen(
                                                      id: searchContent[index]
                                                          .id),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  width: 110,
                                                  // MediaQuery.of(context).size.width * 0.25,
                                                  height: 110,
                                                  //  MediaQuery.of(context).size.width * 0.25,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          searchContent[index]
                                                              .image),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0)),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: ListTile(
                                                  title: Text(
                                                    searchContent[index].title,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: PrimaryFont),
                                                  ),
                                                  subtitle: Text(
                                                    searchContent[index].desc,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  // onTap: () {
                                                  //   Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           MedicalAdviceDetailsScreen(
                                                  //         id: searchContent[index].id,
                                                  //       ),
                                                  //     ),
                                                  //   );
                                                  // },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(AppLocalizations.of(context)
                                        .translate('noSearchResult_str')),
                                  );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

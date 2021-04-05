import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/notification_bloc.dart';
import 'package:heed/src/blocs/searchClinics_bloc.dart';
import 'package:heed/src/blocs/searchDoctors_bloc.dart';
import 'package:heed/src/blocs/searchHistory_bloc.dart';
import 'package:heed/src/blocs/searchHome_bloc.dart';
import 'package:heed/src/blocs/searchMedicalAdvice_bloc.dart';
import 'package:heed/src/models/api_models/GET/category_model.dart';
import 'package:heed/src/services/api/api.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/clinicSectionDetails_screen.dart';
import 'package:heed/src/views/screens/clinics_screen.dart';
import 'package:heed/src/views/screens/favoriteClinics_screen.dart';
import 'package:heed/src/views/screens/history_screen.dart';
import 'package:heed/src/views/screens/home_screen.dart';
import 'package:heed/src/views/screens/medicalAdvice_screen.dart';
import 'package:heed/src/views/screens/ourClinics_screen.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';

class AppBarWidgetWithBackBtn extends StatefulWidget {
  final int notificationCounter;
  final Function onPressedBackBtn;
  final Function onPressedNotifications;

  AppBarWidgetWithBackBtn({
    Key key,
    this.notificationCounter,
    this.onPressedBackBtn,
    this.onPressedNotifications,
  }) : super(key: key);

  @override
  _AppBarWidgetWithBackBtnState createState() => _AppBarWidgetWithBackBtnState();
}

class _AppBarWidgetWithBackBtnState extends State<AppBarWidgetWithBackBtn> {
  String searchQuery = '';
  String get query => searchQuery;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String textFieldHint() {
      if (ModalRoute.of(context).settings.name == '/clinicsScreen') {
        return AppLocalizations.of(context).translate('SearchClinics_str');
      } else if (ModalRoute.of(context).settings.name == '/' || ModalRoute.of(context).settings.name == '/homeScreen') {
        return AppLocalizations.of(context).translate('SearchDepartments_str');
      } else if (ModalRoute.of(context).settings.name == '/ourClinicsScreen') {
        return AppLocalizations.of(context).translate('SearchClinics_str');
      } else if (ModalRoute.of(context).settings.name == '/historyScreen') {
        return AppLocalizations.of(context).translate('SearchHistory_str');
      } else if (ModalRoute.of(context).settings.name == '/medicalAdviceScreen') {
        return AppLocalizations.of(context).translate('SearchMedicalAdvice_str');
      } else if (ModalRoute.of(context).settings.name == '/favoriteClinicsScreen') {
        return AppLocalizations.of(context).translate('SearchFavorites_str');
      } else if (ModalRoute.of(context).settings.name == '/clinicSectionDetailsScreen') {
        return AppLocalizations.of(context).translate('SearchDoctors_str');
      } else {
        return AppLocalizations.of(context).translate('SearchClinics_str');
      }
    }

    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                // spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/Header.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(19.0)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child:
//            ModalRoute.of(context).settings.name == '/clinicsScreen' ||
//                    ModalRoute.of(context).settings.name == '/' ||
//                    ModalRoute.of(context).settings.name == '/homeScreen' ||
//                    ModalRoute.of(context).settings.name ==
//                        '/ourClinicsScreen' ||
//                    ModalRoute.of(context).settings.name == '/historyScreen' ||
//                    ModalRoute.of(context).settings.name ==
//                        '/medicalAdviceScreen' ||
//                    ModalRoute.of(context).settings.name ==
//                        '/favoriteClinicsScreen' ||
//                    ModalRoute.of(context).settings.name ==
//                        '/clinicSectionDetailsScreen'
//                ?
                  TextField(
                controller: locator<TextEditingController>(),
                onChanged: (value) {
                  searchQuery = value;

                  if (ModalRoute.of(context).settings.name == '/clinicsScreen') {
                    locator<ClinicsSearchBloc>().inQuery.add(searchQuery);
                    ClinicsScreen.of(context).setState(() {});
                  } else if (ModalRoute.of(context).settings.name == '/' ||
                      ModalRoute.of(context).settings.name == '/homeScreen') {
                    locator<HomeSearchBloc>().inQuery.add(searchQuery);
                    HomeScreen.of(context).setState(() {});
                  } else if (ModalRoute.of(context).settings.name == '/ourClinicsScreen') {
                    locator<ClinicsSearchBloc>().inQuery.add(searchQuery);
                    OurClinicsScreen.of(context).setState(() {});
                  } else if (ModalRoute.of(context).settings.name == '/historyScreen') {
                    locator<HistorySearchBloc>().inQuery.add(searchQuery);
                    HistoryScreen.of(context).setState(() {});
                  } else if (ModalRoute.of(context).settings.name == '/medicalAdviceScreen') {
                    locator<MedicalSearchBloc>().inQuery.add(searchQuery);
                    MedicalAdviceScreen.of(context).setState(() {});
                  } else if (ModalRoute.of(context).settings.name == '/favoriteClinicsScreen') {
                    locator<ClinicsSearchBloc>().inQuery.add(searchQuery);
                    FavoriteClinicsScreen.of(context).setState(() {});
                  } else if (ModalRoute.of(context).settings.name == '/clinicSectionDetailsScreen') {
                    locator<DoctorsSearchBloc>().inQuery.add(searchQuery);
                    ClinicSectionDetailsScreen.of(context).setState(() {});
                  } else {
//                    locator<ClinicsSearchBloc>().inQuery.add(searchQuery);
//                    OurClinicsScreen.of(context).setState(() {});
                  }
                },
                onSubmitted: (value) async {
                  searchQuery = value;
                  print(ModalRoute.of(context).settings.name);

                  if (searchQuery.isNotEmpty) {
                    if (ModalRoute.of(context).settings.name != '/clinicsScreen' &&
                        ModalRoute.of(context).settings.name != '/' &&
                        ModalRoute.of(context).settings.name != '/homeScreen' &&
                        ModalRoute.of(context).settings.name != '/ourClinicsScreen' &&
                        ModalRoute.of(context).settings.name != '/historyScreen' &&
                        ModalRoute.of(context).settings.name != '/medicalAdviceScreen' &&
                        ModalRoute.of(context).settings.name != '/favoriteClinicsScreen' &&
                        ModalRoute.of(context).settings.name != '/clinicSectionDetailsScreen') {
                      await ApiService.getOurClinicsModel(locator<PrefsService>().appLanguage).then((data) {
                        List<Clinics> content = data.data.clinics;
                        locator<ClinicsSearchBloc>().inClinics.add(content);
                      });
                      Navigator.of(context).pushNamed("/ourClinicsScreen",
                          arguments: OurClinicsScreenArguments(isQueryEmptyFromOutside: false));
//                    _searchController.text = value;
                      locator<ClinicsSearchBloc>().inQuery.add(value);
                      OurClinicsScreen.of(context).setState(() {});
                    }
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: textFieldHint(),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              )
//                : InkWell(
//                    child: Container(
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        borderRadius: BorderRadius.vertical(
//                            bottom: Radius.circular(19.0),
//                            top: Radius.circular(19.0)),
//                      ),
//                      padding: const EdgeInsets.symmetric(
//                          horizontal: 10, vertical: 5),
//                      height: 50,
//                      width: MediaQuery.of(context).size.width,
//                      child: Row(
//                        children: <Widget>[
//                          Icon(
//                            Icons.search,
//                            color: Theme.of(context).primaryColor,
//                          ),
//                          Padding(
//                            padding:
//                                const EdgeInsets.symmetric(horizontal: 10.0),
//                            child: Text(
//                              AppLocalizations.of(context)
//                                  .translate('SearchClinics_str'),
//                              style: TextStyle(
//                                color: Theme.of(context).primaryColor,
//                                fontSize: 13,
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
              ),
        ),
        Positioned(
          top: 35,
          right: 0,
          left: 0,
          child: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        setState(() {
                          _searchController.clear();
                          searchQuery = '';
                          locator<HomeSearchBloc>().inQuery.add(searchQuery);
                          locator<ClinicsSearchBloc>().inQuery.add(searchQuery);
                          locator<HistorySearchBloc>().inQuery.add(searchQuery);
                          locator<MedicalSearchBloc>().inQuery.add(searchQuery);
                          locator<DoctorsSearchBloc>().inQuery.add(searchQuery);
                        });
                        widget.onPressedBackBtn();
                      },
                    ),
                    Stack(
                      children: <Widget>[
                        // Notification icon.
                        IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              setState(() {
                                _searchController.clear();
                                searchQuery = '';
                                locator<HomeSearchBloc>().inQuery.add(searchQuery);
                                locator<ClinicsSearchBloc>().inQuery.add(searchQuery);
                                locator<HistorySearchBloc>().inQuery.add(searchQuery);
                                locator<MedicalSearchBloc>().inQuery.add(searchQuery);
                                locator<DoctorsSearchBloc>().inQuery.add(searchQuery);
                              });
                              widget.onPressedNotifications();
                            }),
                        CustomObserver(
                          stream: locator<NotificationsBloc>().count$,
                          onError: (context, error) => Container(),
                          onSuccess: (context, int data) {
                            return data != 0
                                ? Positioned(
                                    right: 7,
                                    top: 5,
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 14,
                                        minHeight: 14,
                                      ),
                                      child: Text(
                                        '$data',
                                        style:
                                            TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                          onWaiting: (context) => Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

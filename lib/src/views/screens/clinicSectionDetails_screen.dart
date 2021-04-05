import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/checkOut_bloc.dart';
import 'package:heed/src/blocs/api_bloc/checkTime_bloc.dart';
import 'package:heed/src/blocs/api_bloc/clinic_sections_bloc.dart';
import 'package:heed/src/blocs/clinic_data_bloc.dart';
import 'package:heed/src/blocs/currency_bloc.dart';
import 'package:heed/src/blocs/dialog_test_bloc.dart';
import 'package:heed/src/blocs/patient_reserve_bloc.dart';
import 'package:heed/src/blocs/searchDoctors_bloc.dart';
import 'package:heed/src/blocs/time_date_bridge_bloc.dart';
import 'package:heed/src/models/api_models/GET/clinic_model.dart';
import 'package:heed/src/models/api_models/POST/checkTime_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/screens/check_out.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';
import 'package:intl/intl.dart';

class ClinicSectionDetailsScreenArguments {
  final int id;
  final content;

  ClinicSectionDetailsScreenArguments(this.id, this.content);
}

class ClinicSectionDetailsScreen extends StatefulWidget {
  static _ClinicSectionDetailsScreenState of(BuildContext context) =>
      context.findAncestorStateOfType();

//  @override
//  void dispose() {
//    locator<TimeDateBridge>().timeDateSink.add(false);
//  }

//  int id;
//  int ido;
//  var content;
//
//  ClinicSectionDetailsScreen(this.content, this.ido
//      //this.currency,
//      // this.SliderBanner
//      );

  @override
  _ClinicSectionDetailsScreenState createState() =>
      _ClinicSectionDetailsScreenState();
}

int radioGroup = 1;
var val;
bool carsIsClicked = false;

class _ClinicSectionDetailsScreenState
    extends State<ClinicSectionDetailsScreen> {
  @override
  void dispose() {
    // locator<PrefsService>().isOnline = false;
    super.dispose();
    print(
        "----------------------------------------------------------------------");
    locator<TimeDateBridge>().timeDateSink.add(false);
  }

  /////////////////////////////////////////////
  ClinicSectionDetailsScreenArguments args;
  List filteredList;
  bool isQueryEmpty = true;

  ///////////////////////////////////////////////
  var patientBloc = locator<PatientReserveBloc>();

  final radioval = locator<CheckOutBloc>().currentPayment;

  bool _isList = true;

  String id;
  String date;
  String time;
  int codeStatus = 0;
  bool checkTimeClicked = false;

  int doctorId;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  FocusNode phoneFocusNode = new FocusNode();

  var insuranceID;
  var insuranceData;

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
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    locator<DoctorsSearchBloc>().query$.listen(
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
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      //   padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_left,
                                  size: 25.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  args.content.name,
                                  style: TextStyle(
                                      fontWeight: semiFont,
                                      fontSize: PrimaryFont,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _isList = !_isList;
                              });
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(seconds: 1),
                              transitionBuilder: (Widget child, animation) =>
                                  ScaleTransition(
                                child: child,
                                scale: animation,
                              ),
                              child: _isList
                                  ? Image.asset(
                                      "assets/images/mainIcons1X/menu2.png",
                                      height: 20.0,
                                      width: 20.0,
                                    )
                                  : Image.asset(
                                      "assets/images/mainIcons1X/menu3.png",
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: Duration(milliseconds: 1000),
                      firstChild:
                          isQueryEmpty ? _listScreen() : _searchListScreen(),
                      secondChild:
                          isQueryEmpty ? _gridScreen() : _searchGridScreen(),
                      crossFadeState: _isList
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
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

  Widget _radioList() {
    return StreamBuilder<Object>(
        initialData: 100,
        stream: patientBloc.radioCtrl,
        builder: (BuildContext context, snapshot) {
          print("this is radio snapshpt ${snapshot.data}");
          return CustomObserver(
              stream: locator<CheckTimeBloc>().checkTime$,
              onWaiting: (context) => Container(
                    child: Text(
                        AppLocalizations.of(context)
                            .translate('check_time_first'),
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: semiFont,
                            fontSize: PrimaryFont)),
                  ),
              onSuccess: (context, CheckTimeModel data) {
                String msg = data.message;
                int timeStatus = data.status;
// please dont forgite to change this to == 1
                // keep it ==1 if its already ==1
                return timeStatus == 1
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            locator<ClinicDataBloc>()
                                    .currentClinicDataKnet
                                    .toString()
                                    .contains("yes")
                                // when you finish back it to yes olease ====> no is just for test
                                ? Container(
                                    child: Row(
                                      children: <Widget>[
                                        Radio(
                                          value: 1,
                                          groupValue: snapshot.data,
                                          onChanged: patientBloc.setValue,
                                        ),
                                        SizedBox(
                                          width: 0.5,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('KNet_str'),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            locator<ClinicDataBloc>()
                                    .currentClinicDataCash
                                    .toString()
                                    .contains("yes")
                                ? Container(
                                    child: Row(
                                      children: <Widget>[
                                        Radio(
                                          value: 2,
                                          groupValue: snapshot.data,
                                          onChanged: patientBloc.setValue,
                                        ),
                                        SizedBox(
                                          width: 0.5,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('cash_str'),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Radio(
                                    value: 3,
                                    groupValue: snapshot.data,
                                    onChanged: patientBloc.setValue,
                                  ),
                                  SizedBox(
                                    width: 0.5,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('insurance_str'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    :
                    //Text(AppLocalizations.of(context).translate('check_time'),
                    Text(msg,
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: semiFont,
                            fontSize: PrimaryFont));
              });
        });
  }

  void _showDialogReserve(content, parentContent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Material(
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 25.0,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .10,
                    ),
                    _patientText(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Form(
                      child: Wrap(
                        children: <Widget>[
                          _nameField(),
                          Container(
                            height: 20.0,
                          ),
                          _mobileField(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _appointmentDate(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 6,
                          child: _BasicDateField(content),
                        ),
//                        SizedBox(
//                          width: 15.0,
//                        ),
                        Flexible(
                          flex: 4,
                          child: _timeInput(content),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
//                    testaa(content),
                    SizedBox(
                      height: 20.0,
                    ),
                    _paymentSelect(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _radioList(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _confirmButton(parentContent, content),
                    SizedBox(
                      height: 40.0,
                    ),
//                    closeDialog(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _gridScreen() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: args.content.doctors.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (BuildContext context, int index) {
          var content = args.content.doctors[index];
          var parentContent = args.content;
          // int content = index;
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              key: Key(args.content.doctors[index].toString()),
              child: Card(
                elevation: 0,
                color: lightGrey.withOpacity(.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: FittedBox(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: new BorderRadius.circular(8.0),
                          child: Image.network(
                            args.content.doctors[index].image,
                            height: 120.0,
                            width: 120.0,
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),

                        Text(
                          args.content.doctors[index].specialist,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: semiFont,
                              fontSize: PrimaryFont),
                        ),
                        //SizedBox(height: 15.0,),
                        Text(
                          args.content.doctors[index].name,
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: semiFont,
                              fontSize: SecondaryFont),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "${args.content.doctors[index].price.toString()}"
                              //" ${widget.currency}"
                              ,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: semiFont,
                                  fontSize: SecondaryFont),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              locator<CurrencyBloc>().currentCurrency,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: semiFont,
                                  fontSize: SecondaryFont),
                            ),
//                            CustomObserver<ClinicModel>(
//                                stream: ClinicSectionsBloc(id: args.id)
//                                    .clinicStream$,
//                                onSuccess: (context, data) {
//                            //      var content = data.data.currency;
//                                 var clinic = data.data.clinic;
////                                  locator<CurrencyBloc>()
////                                      .currencySink
////                                      .add(content);
////
//                                  locator<ClinicDataBloc>()
//                                      .clinicDataSink
//                                      .add(clinic.name);
//                                  locator<ClinicDataBloc>()
//                                      .clinicDataCashSink
//                                      .add(clinic.cash);
//                                  locator<ClinicDataBloc>()
//                                      .clinicDataKnetSink
//                                      .add(clinic.knet);
//
//
//                                  return Text(
//                                    locator<CurrencyBloc>()
//                                        .currentCurrency,
//                                    style: TextStyle(
//                                        color: Colors.black45,
//                                        fontWeight: semiFont,
//                                        fontSize: SecondaryFont),
//                                  );
//                                })
                          ],
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 7.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                            //                          side: BorderSide(color: Colors.red)
                          ),
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            locator<PrefsService>().userObj != null
                                ? _showDialogReserve(content, parentContent)
                                : _showPleaseLoginDialog();
                          },
                          color: Colors.blue,
                          elevation: 7.0,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('reserve_str'),
                            style: TextStyle(
                                fontSize: SecondaryFont,
                                fontWeight: medFont,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _searchGridScreen() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return CustomObserver(
      stream: locator<DoctorsSearchBloc>().filteredDoctors$,
      onSuccess: (context, List<Doctors> data) {
        List<Doctors> searchContent = data;
        return searchContent.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: searchContent.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: (itemWidth / itemHeight),
                ),
                itemBuilder: (BuildContext context, int index) {
                  var content = searchContent[index];
                  var parentContent = args.content;
                  // int content = index;
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Container(
                      key: Key(searchContent[index].toString()),
                      child: Card(
                        elevation: 0,
                        color: lightGrey.withOpacity(.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: FittedBox(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  child: Image.network(
                                    searchContent[index].image,
                                    height: 120.0,
                                    width: 120.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),

                                Text(
                                  searchContent[index].specialist,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: semiFont,
                                      fontSize: PrimaryFont),
                                ),
                                //SizedBox(height: 15.0,),
                                Text(
                                  searchContent[index].name,
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: semiFont,
                                      fontSize: SecondaryFont),
                                ),

                                Row(
                                  children: <Widget>[
                                    Text(
                                      "${searchContent[index].price.toString()}"
                                      //" ${widget.currency}"
                                      ,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: semiFont,
                                          fontSize: SecondaryFont),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      locator<CurrencyBloc>().currentCurrency,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: semiFont,
                                          fontSize: SecondaryFont),
                                    ),
//                                    CustomObserver<ClinicModel>(
//                                        stream: ClinicSectionsBloc(id: args.id)
//                                            .clinicStream$,
//                                        onSuccess: (context, data) {
//                                          var content = data.data.currency;
//                                          locator<CurrencyBloc>()
//                                              .currencySink
//                                              .add(content);
//                                          return Text(
//                                            content,
//                                            style: TextStyle(
//                                                color: Colors.black45,
//                                                fontWeight: semiFont,
//                                                fontSize: SecondaryFont),
//                                          );
//                                        })
                                  ],
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                RaisedButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.0, vertical: 7.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0),
                                    //                          side: BorderSide(color: Colors.red)
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    print(
                                        "  this is widget.content.doctors[index].id ${searchContent[index].id}.");
                                    locator<PrefsService>().userObj != null
                                        ? _showDialogReserve(
                                            content, parentContent)
                                        : _showPleaseLoginDialog();

//                          setState(() {
//                         //   doctorId = widget.content.doctors[index].id;
//                          });

//                          print("this is doctorId ${doctorId}");
                                  },
                                  color: Colors.blue,
                                  elevation: 7.0,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('reserve_str'),
                                    style: TextStyle(
                                        fontSize: SecondaryFont,
                                        fontWeight: medFont,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : Center(
                child: Text(
                  AppLocalizations.of(context).translate('noSearchResult_str'),
                ),
              );
      },
    );
  }

  Widget _searchListScreen() {
    return CustomObserver(
      stream: locator<DoctorsSearchBloc>().filteredDoctors$,
      onSuccess: (context, List<Doctors> data) {
        List<Doctors> searchContent = data;
        return searchContent.isNotEmpty
            ? Container(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: searchContent.length,
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black.withOpacity(.2),
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      var content = searchContent[index];
                      var parentContent = args.content;
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        child: locator<PrefsService>().userObj != null
                            ? ExpansionTile(
                                trailing: Container(
                                  key: Key(searchContent[index].toString()),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(50.0),
                                    ),
                                    color: Colors.blue,
                                    elevation: 7.0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('reserve_str'),
                                        style: TextStyle(
                                            fontSize: SecondaryFont,
                                            fontWeight: medFont,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              ClipRRect(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          50.0),
                                                  child: Image.network(
                                                    searchContent[index].image,
                                                    height: 70.0,
                                                    width: 70.0,
                                                  )),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        searchContent[index]
                                                            .specialist,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                semiFont,
                                                            fontSize:
                                                                PrimaryFont),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        searchContent[index]
                                                            .name,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontWeight:
                                                                semiFont,
                                                            fontSize:
                                                                SecondaryFont),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            "${searchContent[index].price.toString()}"
                                                            //" ${widget.currency}"
                                                            ,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                                fontWeight:
                                                                    semiFont,
                                                                fontSize:
                                                                    SecondaryFont),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text(
                                                            locator<CurrencyBloc>()
                                                                .currentCurrency,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                                fontWeight:
                                                                    semiFont,
                                                                fontSize:
                                                                    SecondaryFont),
                                                          ),
//                                                    CustomObserver<ClinicModel>(
//                                                        stream:
//                                                            ClinicSectionsBloc(
//                                                                    id: args.id)
//                                                                .clinicStream$,
//                                                        onSuccess:
//                                                            (context, data) {
//                                                          var content = data
//                                                              .data.currency;
//                                                          return Text(
//                                                            content,
//                                                            style: TextStyle(
//                                                                color: Colors
//                                                                    .black45,
//                                                                fontWeight:
//                                                                    semiFont,
//                                                                fontSize:
//                                                                    SecondaryFont),
//                                                          );
//                                                        })
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                children: <Widget>[
                                  _patientText(),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Form(
                                    child: Wrap(
                                      children: <Widget>[
                                        _nameField(),
                                        Container(
                                          height: 20.0,
                                        ),
                                        _mobileField(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  _appointmentDate(),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 6,
                                        child: _BasicDateField(content),
                                      ),
//                                SizedBox(
//                                  width: 15.0,
//                                ),
                                      Flexible(
                                        flex: 4,
                                        child: _timeInput(content),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  _paymentSelect(),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  _radioList(),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  _confirmButton(parentContent, content),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              )
                            : ListTile(
                                onTap: () {
                                  _showPleaseLoginDialog();
                                },
                                trailing: Container(
                                  key: Key(searchContent[index].toString()),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(50.0),
                                    ),
                                    color: Colors.blue,
                                    elevation: 7.0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('reserve_str'),
                                        style: TextStyle(
                                            fontSize: SecondaryFont,
                                            fontWeight: medFont,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              ClipRRect(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          50.0),
                                                  child: Image.network(
                                                    searchContent[index].image,
                                                    height: 70.0,
                                                    width: 70.0,
                                                  )),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        searchContent[index]
                                                            .specialist,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                semiFont,
                                                            fontSize:
                                                                PrimaryFont),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        searchContent[index]
                                                            .name,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontWeight:
                                                                semiFont,
                                                            fontSize:
                                                                SecondaryFont),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            "${searchContent[index].price.toString()}"
                                                            //" ${widget.currency}"
                                                            ,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                                fontWeight:
                                                                    semiFont,
                                                                fontSize:
                                                                    SecondaryFont),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text(
                                                            //content,
                                                            locator<CurrencyBloc>()
                                                                .currentCurrency,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                                fontWeight:
                                                                    semiFont,
                                                                fontSize:
                                                                    SecondaryFont),
                                                          ),
//                                                    CustomObserver<ClinicModel>(
//                                                        stream:
//                                                        ClinicSectionsBloc(
//                                                            id: args.id)
//                                                            .clinicStream$,
//                                                        onSuccess:
//                                                            (context, data) {
//                                                          var content = data
//                                                              .data.currency;
//                                                          return Text(
//                                                            //content,
//                                                            locator<CurrencyBloc>()
//                                                                .currentCurrency,
//                                                            style: TextStyle(
//                                                                color: Colors
//                                                                    .black45,
//                                                                fontWeight:
//                                                                semiFont,
//                                                                fontSize:
//                                                                SecondaryFont),
//                                                          );
//                                                        })
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      );
                    }),
              )
            : Center(
                child: Text(AppLocalizations.of(context)
                    .translate('noSearchResult_str')),
              );
      },
    );
  }

  Widget _listScreen() {
    return Container(
      child: ListView.separated(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: args.content.doctors.length,
          separatorBuilder: (context, index) => Divider(
                color: Colors.black.withOpacity(.2),
              ),
          itemBuilder: (BuildContext context, int index) {
            var content = args.content.doctors[index];
            var parentContent = args.content;
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
//                  if (locator<PrefsService>().userObj == null) {
//                    _showPleaseLoginDialog();
//                  }
                },
                child: locator<PrefsService>().userObj != null
                    ? ExpansionTile(
                        trailing: Container(
                          key: Key(args.content.doctors[index].toString()),
                          child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            color: Colors.blue,
                            elevation: 7.0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('reserve_str'),
                                style: TextStyle(
                                    fontSize: SecondaryFont,
                                    fontWeight: medFont,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        title: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(50.0),
                                          child: Image.network(
                                            args.content.doctors[index].image,
                                            height: 70.0,
                                            width: 70.0,
                                          )),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                args.content.doctors[index]
                                                    .specialist,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: semiFont,
                                                    fontSize: PrimaryFont),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                args.content.doctors[index]
                                                    .name,
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontWeight: semiFont,
                                                    fontSize: SecondaryFont),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    "${args.content.doctors[index].price.toString()}"
                                                    //" ${widget.currency}"
                                                    ,
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontWeight: semiFont,
                                                        fontSize:
                                                            SecondaryFont),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    locator<CurrencyBloc>()
                                                        .currentCurrency,
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontWeight: semiFont,
                                                        fontSize:
                                                            SecondaryFont),
                                                  ),
//                                            CustomObserver<ClinicModel>(
//                                                stream: ClinicSectionsBloc(
//                                                        id: args.id)
//                                                    .clinicStream$,
//                                                onSuccess: (context, data) {
//                                                  var content =
//                                                      data.data.currency;
//                                                  return Text(
//                                                      locator<CurrencyBloc>()
//                                                          .currentCurrency,
//                                                    style: TextStyle(
//                                                        color: Colors.black45,
//                                                        fontWeight: semiFont,
//                                                        fontSize:
//                                                            SecondaryFont),
//                                                  );
//                                                })
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        children: <Widget>[
//                if (locator<PrefsService>().userObj != null) {
//            if (patientBloc.currentRadio == 3) {
////                          Navigator.push(
////                              context,
////                              new MaterialPageRoute(
////                                  builder: (BuildContext context) =>
////                                      CheckOutScreen()));
//
//            _insuranceCompanies(parentContent, content);
//            } else {
//            Navigator.push(
//            context,
//            new MaterialPageRoute(
//            builder: (BuildContext context) =>
//            CheckOutScreen(parentContent, content,
//            insuranceID, insuranceData)));
//            }
//            } else {
//            _showPleaseLoginDialog();
//            }
                          _patientText(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _nameField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _mobileField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _appointmentDate(),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                flex: 6,
                                child: _BasicDateField(content),
                              ),
//                        SizedBox(
//                          width: 15.0,
//                        ),
                              Flexible(
                                flex: 4,
                                child: _timeInput(content),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          _paymentSelect(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _radioList(),
                          SizedBox(
                            height: 20.0,
                          ),
                          _confirmButton(parentContent, content),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      )
                    : ListTile(
                        onTap: () {
                          _showPleaseLoginDialog();
                        },
                        trailing: Container(
                          key: Key(args.content.doctors[index].toString()),
                          child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            color: Colors.blue,
                            elevation: 7.0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('reserve_str'),
                                style: TextStyle(
                                    fontSize: SecondaryFont,
                                    fontWeight: medFont,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        title: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(50.0),
                                          child: Image.network(
                                            args.content.doctors[index].image,
                                            height: 70.0,
                                            width: 70.0,
                                          )),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                args.content.doctors[index]
                                                    .specialist,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: semiFont,
                                                    fontSize: PrimaryFont),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                args.content.doctors[index]
                                                    .name,
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontWeight: semiFont,
                                                    fontSize: SecondaryFont),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    "${args.content.doctors[index].price.toString()}"
                                                    //" ${widget.currency}"
                                                    ,
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontWeight: semiFont,
                                                        fontSize:
                                                            SecondaryFont),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
//                                            CustomObserver<ClinicModel>(
//                                                stream: ClinicSectionsBloc(
//                                                    id: args.id)
//                                                    .clinicStream$,
//                                                onSuccess: (context, data) {
//                                                  var content =
//                                                      data.data.currency;
//                                                  return Text(
//                                                    content,
//                                                    style: TextStyle(
//                                                        color: Colors.black45,
//                                                        fontWeight: semiFont,
//                                                        fontSize:
//                                                        SecondaryFont),
//                                                  );
//                                                })
                                                  Text(
                                                    locator<CurrencyBloc>()
                                                        .currentCurrency,
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontWeight: semiFont,
                                                        fontSize:
                                                            SecondaryFont),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
          }),
    );
  }

//  Widget closeDialog() {
//    return Container(
//      child: IconButton(
//        onPressed: () {
//          Navigator.pop(context);
//        },
//        icon: Icon(
//          Icons.close,
//          size: 80.0,
//          color: Colors.grey,
//        ),
//      ),
//    );
//  }

  _patientText() {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            AppLocalizations.of(context).translate('patientInfo_str'),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: LargeFont,
            ),
          ),
        )
      ],
    );
  }

  _appointmentDate() {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            AppLocalizations.of(context).translate('appointment_str'),
            style: TextStyle(
              color: darkGrey,
              fontSize: MediumFont,
            ),
          ),
        )
      ],
    );
  }

  _paymentSelect() {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            AppLocalizations.of(context).translate('selectPaymentOptions_str'),
            style: TextStyle(
              color: darkGrey,
              fontSize: MediumFont,
            ),
          ),
        )
      ],
    );
  }

  _nameField() {
    return StreamBuilder(
      stream: patientBloc.name,
      builder: (context, snapshot) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (nameFieldValue) {
            FocusScope.of(context).requestFocus(phoneFocusNode);
          },
          onChanged: patientBloc.changeName,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText: AppLocalizations.of(context).translate('name_str'),
              labelText: AppLocalizations.of(context).translate('name_str'),
              errorText: snapshot.error,
              border: OutlineInputBorder()),
        );
      },
    );
  }

  _mobileField() {
    return StreamBuilder(
      stream: patientBloc.mobile,
      builder: (context, snapshot) {
        return TextFormField(
          focusNode: phoneFocusNode,
          onChanged: patientBloc.changeMobile,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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

  Widget _confirmButton(parentContent, content) {
    return StreamBuilder<Object>(
        stream: patientBloc.registerValid,
        builder: (context, snapshot) {
          return Center(
            child: ButtonTheme(
              minWidth: 280.0,
              height: 45.0,
              child: locator<TimeDateBridge>().currentTimeDateSubject
                  ? RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      child: Text(
                        AppLocalizations.of(context).translate('confirm_str'),
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: snapshot.hasData
                          ? () {
                              if (locator<PrefsService>().userObj != null) {
                                if (patientBloc.currentRadio == 3) {
//                          Navigator.push(
//                              context,
//                              new MaterialPageRoute(
//                                  builder: (BuildContext context) =>
//                                      CheckOutScreen()));

                                  _insuranceCompanies(parentContent, content);
                                } else {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CheckOutScreen(
                                                  parentContent,
                                                  content,
                                                  insuranceID,
                                                  insuranceData)));
                                }
                              } else {
                                _showPleaseLoginDialog();
                              }

                              // if (patientBloc.currentRadio == 3) {
// //                          Navigator.push(
// //                              context,
// //                              new MaterialPageRoute(
// //                                  builder: (BuildContext context) =>
// //                                      CheckOutScreen()));

//                           _insuranceCompanies(parentContent, content);
//                         } else {
//                           Navigator.push(
//                               context,
//                               new MaterialPageRoute(
//                                   builder: (BuildContext context) =>
//                                       CheckOutScreen(parentContent, content,
//                                           insuranceID, insuranceData)));
//                         }
                            }
                          : null,
                    )
                  : RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      child: Text(
                        AppLocalizations.of(context).translate('confirm_str'),
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: null,
                    ),
            ),
          );
        });
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
                            Navigator.pop(context);
                            // Navigator.pushReplacementNamed(
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

  _insuranceCompanies(parentContent, content) {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              content: CustomObserver<ClinicModel>(
                  stream: ClinicSectionsBloc(id: args.id).clinicStream$,
                  onSuccess: (context, data) {
                    var clinicContent = data.data.clinic;
                    return Container(
                      width: MediaQuery.of(context).size.width * .7,
                      //   padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('insuranceCompanies:_str'),
                                  style: TextStyle(
                                      fontSize: MediumFont,
                                      fontWeight: regFont,
                                      color: greyBlue),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount:
                                  clinicContent.incuranceCompanies.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      insuranceID = clinicContent
                                          .incuranceCompanies[index].id;
                                      insuranceData = clinicContent
                                          .incuranceCompanies[index];
                                    });
                                    print(clinicContent
                                        .incuranceCompanies[index].image);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                CheckOutScreen(
                                                    parentContent,
                                                    content,
                                                    insuranceID,
                                                    insuranceData)));
                                  },
                                  child: Wrap(
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        child: ListTile(
                                          leading: Image.network(
                                            clinicContent
                                                .incuranceCompanies[index]
                                                .image,
                                            height: 40.0,
                                            width: 40.0,
                                            fit: BoxFit.fill,
                                          ),
                                          title: Text(
                                            clinicContent
                                                .incuranceCompanies[index].name,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: PrimaryFont,
                                                fontWeight: semiFont),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        //  color: Colors.blue,
                                        indent: 5.0,
                                        endIndent: 5.0,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }

  Widget _timeInput(content) {
    List days = [];
    int oneTime = 0;
    List times = [];
    Map<String, dynamic> someMap = {};

    return StreamBuilder<Object>(
        stream: patientBloc.timeStream,
        builder: (BuildContext context, snapshot) {
          return StreamBuilder<Object>(
              stream: patientBloc.getDate,
              builder: (context, snapshoto) {
                return InkWell(
                  onTap: () {
                    oneTime++;
//                    print("$oneTime this is one time");

                    for (int index = 0; index < content.times.length; index++) {
                      days.add(content.times[index].times);
                      someMap["Saturday"] = content.times[0].times;
                      someMap["Sunday"] = content.times[1].times;
                      someMap["Monday"] = content.times[2].times;
                      someMap["Tuesday"] = content.times[3].times;
                      someMap["Wednesday"] = content.times[4].times;
                      someMap["Thursday"] = content.times[5].times;
                      someMap["Friday"] = content.times[6].times;
                    }

//                    print("this is nsapshoto ${snapshoto.data}");

                    var dayToString = snapshoto.data.toString();

                    DateTime date = DateTime.parse(dayToString);

                    String dateFormat = DateFormat('EEEE').format(date);

                    times.clear();
                    someMap.forEach((key, value) {
                      if (dateFormat == key) {
                        print('key: $key, value: $value');
                        times.addAll(value);
                      }
                    });

                    _showDialog(content, times);
                  },
                  child: Container(
                    height: 50.0,
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
//                      color: snapshot.hasData
//                          ? Colors.white
//                          : Colors.red.withOpacity(.5),
                      border: Border.all(color: littleGrey, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        locator<TimeDateBridge>().currentTimeDateSubject == true
                            ? Container(
                                child: Text(
                                  snapshot.hasData
                                      ? snapshot.data
                                      : AppLocalizations.of(context)
                                          .translate('time_str'),
                                  style: TextStyle(color: darkGrey),
                                ),
                              )
                            : Container(
                                child: Text(AppLocalizations.of(context)
                                    .translate('time_str')),
                              ),
                        Icon(
                          Icons.alarm,
                          color: littleGrey,
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  // user defined function
  void _showDialog(content, times) {
    // flutter defined function

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        var size = MediaQuery.of(context).size;
        /*24 is for notification bar on Android*/
        final double itemHeight = (size.height - kToolbarHeight - 24) / 7.5;
        final double itemWidth = size.width / 2;
        return AlertDialog(
          title: new Text(
            AppLocalizations.of(context).translate('selectTime_str'),
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: semiFont,
                fontSize: MediumFont),
          ),
          content: StreamBuilder<Object>(
              stream: patientBloc.getDate,
              builder: (context, snapshotDate) {
                return Container(
                  height: 320.0,
                  width: double.maxFinite,
                  child: Center(
                    child: StreamBuilder<Object>(
                        initialData: -1000,
                        stream: locator<DialogColor>().dialogColor$,
                        builder: (context, snapshot) {
                          return Scrollbar(
                            child: times.length > 0
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: times.length,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio:
                                          (itemWidth / itemHeight),
                                      mainAxisSpacing: 5.0,
                                      crossAxisSpacing: 5.0,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        focusColor:
                                            Theme.of(context).primaryColor,
                                        splashColor:
                                            Theme.of(context).primaryColor,
                                        onTap: () {
                                          locator<TimeDateBridge>()
                                              .timeDateSink
                                              .add(true);

//
//                                          print("${locator<TimeDateBridge>().currentTimeDateSubject}locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()");

                                          patientBloc.timeItem(
                                              times[index].toString());
                                          locator<DialogColor>()
                                              .dialogColorSink
                                              .add(index);
                                        },
                                        key: Key(times[index].toString()),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 6.0,
                                          //  color: Colors.red,
                                          child: Container(
                                            color: int.parse(snapshot.data
                                                        .toString()) ==
                                                    index
                                                ? Colors.blueGrey
                                                    .withOpacity(.5)
                                                : Colors.white,
                                            key: Key(times[index].toString()),
                                            //   margin: EdgeInsets.all(20.0),
                                            child: FittedBox(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'timeSlot_str'),
                                                      style: TextStyle(
                                                          fontSize:
                                                              SecondaryFont,
                                                          fontWeight: semiFont,
                                                          color: darkGrey),
                                                    ),
                                                    SizedBox(
                                                      width: 15.0,
                                                    ),
                                                    Text(
                                                        times[index].toString(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                SecondaryFont,
                                                            fontWeight: bolFont,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor)),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('avilable_clinics'),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: MainFont,
                                          fontWeight: bolFont),
                                    ),
                                  ),
                          );
                        }),
                  ),
                );
              }),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            StreamBuilder<Object>(
                stream: patientBloc.timeStream,
                builder: (context, snapshotTime) {
                  return new FlatButton(
                    child: new Text(
                      AppLocalizations.of(context).translate('ok_str'),
                      style: TextStyle(
                          fontSize: MediumFont,
                          fontWeight: bolFont,
                          color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      locator<CheckTimeBloc>().inId.add(content.id.toString());
                      ///////
                      locator<CheckTimeBloc>().inDate.add(
                          DateFormat('yyyy-MM-dd')
                              .format(patientBloc.currentDate)
                              .toString());
                      /////
                      locator<CheckTimeBloc>()
                          .inTime
                          .add(patientBloc.currentTime.toString());
                      /////////
                      locator<CheckTimeBloc>().inClick.add(!checkTimeClicked);
                      /////////
                      Navigator.pop(context);
//
//                      if(patientBloc.currentTime.toString().length < 0 ){
//                        showDialog(
//                          context: context,
//                          builder: (context) {
//                            return Container(
//                              height: 50,
//                              child: ConstrainedBox(
//                                constraints: BoxConstraints(maxHeight: 100.0),
//                                child: AlertDialog(
//                                  content: CustomObserver(
//                                    stream: locator<CheckTimeBloc>().checkTime$,
//                                    onSuccess: (context, CheckTimeModel data) {
//                                      String msg = data.message;
//                                      int timeStatus = data.status;
//                                      if (data.status == 1) {
//                                        codeStatus = 1;
//                                        return Text(msg);
//                                      }
//                                      codeStatus = 0;
////                                    return Text('$msg\n${user.authorization}');
//                                      return Text(msg);
//                                    },
//                                    onError: (context, error) {
//                                      return Wrap(
//                                        children: <Widget>[
//                                          Text('$error'),
//                                        ],
//                                      );
//                                    },
//                                  ),
//                                ),
//                              ),
//                            );
//                          });}else{
//                        showDialog(
//                            context: context,
//                            builder: (context) {
//                              return Container(
//                                height: 50,
//                                child: ConstrainedBox(
//                                  constraints: BoxConstraints(maxHeight: 100.0),
//                                  child: AlertDialog(
//                                    content: CustomObserver(
//                                      stream: locator<CheckTimeBloc>().checkTime$,
//                                      onSuccess: (context, CheckTimeModel data) {
//                                        String msg = data.message;
//                                        int timeStatus = data.status;
//                                        if (data.status == 1) {
//                                          codeStatus = 1;
//                                          return Text(msg);
//                                        }
//                                        codeStatus = 0;
////                                    return Text('$msg\n${user.authorization}');
//                                        return Text(msg);
//                                      },
//                                      onError: (context, error) {
//                                        return Wrap(
//                                          children: <Widget>[
//                                            Text('$error'),
//                                          ],
//                                        );
//                                      },
//                                    ),
//                                  ),
//                                ),
//                              );
//                            });
//                      }
                    },
                  );
                }),
          ],
        );
      },
    );
  }
}

class _BasicDateField extends StatefulWidget {
  @override
  __BasicDateFieldState createState() => __BasicDateFieldState();

  final dynamic content;

  _BasicDateField(this.content);
}

class __BasicDateFieldState extends State<_BasicDateField> {
  final format = DateFormat("yyyy-MM-dd");
  var patientBloc = locator<PatientReserveBloc>();

  //DateTime date = DateTime.now();Z

  String value = '';
  final now = new DateTime.now();

  bool isAlertOnScreen = false;

  @override
  void dispose() {
    // locator<PrefsService>().isOnline = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    return FlatButton(
      onPressed: () {
        locator<TimeDateBridge>().timeDateSink.add(false);
        print(
            "${locator<TimeDateBridge>().currentTimeDateSubject}locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()locator<TimeDateBridge>()");
      },
      child: Column(children: <Widget>[
        StreamBuilder<Object>(
            stream: patientBloc.getDate,
            builder: (BuildContext context, snapshot) {
              print(snapshot.data);
              return DateTimeField(
                readOnly: true,
                style: TextStyle(fontSize: 14.0),
                onChanged: patientBloc.setDate,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  errorText: snapshot.error,
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                  //  labelText: AppLocalizations.of(context).translate('date_str'),
                  hintText: AppLocalizations.of(context).translate('date_str'),
                ),
                format: format,
                onShowPicker: (context, currentValue) async {
                  final DateTime date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().add(Duration(days: 1)),
                      initialDate:
                          DateTime.now().add(Duration(days: 1, hours: 1)),
                      lastDate: DateTime(2100));
                  if (date != null)
                    setState(() {
                      value = date.toString();
                      locator<TimeDateBridge>().timeDateSink.add(false);
                    });
                  return date;
                },
              );
            }),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/clinic_sections_bloc.dart';
import 'package:heed/src/blocs/clinic_tabs.dart';
import 'package:heed/src/blocs/searchDoctors_bloc.dart';
import 'package:heed/src/models/api_models/GET/clinic_model.dart';
import 'package:heed/src/views/screens/clinicSectionDetails_screen.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/ads_carousel.dart';
import 'package:heed/src/views/widgets/appBarWithBackBtn.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinicSectionsScreen extends StatefulWidget {
  final int id;

  const ClinicSectionsScreen({Key key, this.id}) : super(key: key);

  @override
  _ClinicSectionsScreenState createState() => _ClinicSectionsScreenState();
}

class _ClinicSectionsScreenState extends State<ClinicSectionsScreen> with TickerProviderStateMixin {
  var clinicTabsBloc = locator<ClinicTabsBloc>();

  TabController _tabController;

  bool isAlertOnScreen = false;

  @override
  void initState() {
//    tabList.add(new Tab(text:'Overview',));
//    tabList.add(new Tab(text:'Workouts',));
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();

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
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            child: AppBarWidgetWithBackBtn(
              onPressedBackBtn: () {
                Navigator.of(context).pop();
              },
            ),
            preferredSize: Size.fromHeight(200),
          ),
          body:
//          RootApp(
//            child:
              Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CarouselWidgetClinic(widget.id),
                  clinicBanner(),
                  clinicTabs(),
                ],
              ),
            ),
          ),
        ),
      ),
//      ),
    );
  }

  Widget clinicBanner() {
    return CustomObserver<ClinicModel>(
        stream: ClinicSectionsBloc(id: widget.id).clinicStream$,
        onSuccess: (context, data) {
          var content = data.data.clinic;
          return Container(
            // margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                  // height: 160.0,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    image: DecorationImage(
                      image: NetworkImage(content.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          // "Bayan Dental Clinic"
                          content.name,
                          style: TextStyle(fontSize: MediumFont, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 14.0,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(content.address,

                                  // "Kharafi tower - Kuwait city"

                                  style: TextStyle(
                                    fontSize: SecondaryFont,
                                    color: Colors.white,
                                    fontWeight: medFont,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 14.0,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text("${AppLocalizations.of(context).translate('working_str')} : ${content.workTimes}",
                                  style: TextStyle(
                                    fontSize: SecondaryFont,
                                    color: Colors.white,
                                    fontWeight: medFont,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  Widget clinicTabs() {
    return Material(
      elevation: 0.0,
      color: Colors.white,
      child: new Column(
        // shrinkWrap: true,
        // physics: ScrollPhysics(),
        //   mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new TabBar(
            labelPadding: EdgeInsets.only(bottom: 10.0, top: 10.0),
            controller: _tabController,
            indicatorColor: Colors.blue,
            unselectedLabelColor: Colors.black54,
            labelColor: Colors.blue,
            tabs: [
              Text(
                AppLocalizations.of(context).translate('services_str'),
                style: TextStyle(
                  fontSize: MediumFont,
                  fontWeight: medFont,
                ),
              ),
              Text(
                AppLocalizations.of(context).translate('info_str'),
                style: TextStyle(
                  fontSize: MediumFont,
                  fontWeight: medFont,
                ),
              ),
            ],
          ),
          Container(
            //  color: Colors.red,
            height: MediaQuery.of(context).size.height - 230,
            child: TabBarView(
              physics: ScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                _servicesTab(),
                _infoTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _servicesTab() {
    var ido = widget.id;
    return CustomObserver<ClinicModel>(
        stream: ClinicSectionsBloc(id: ido).clinicStream$,
        onSuccess: (context, ClinicModel data) {
          List<Services> content = data.data.clinic.services;
          //     List<SliderBanner> sliderBanner = data.data.slider;
          //  var currency = data.data.currency;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 35.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: content.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      locator<DoctorsSearchBloc>().inDoctors.add(content[index].doctors);
                      Navigator.pushNamed(context, '/clinicSectionDetailsScreen',
                          arguments: ClinicSectionDetailsScreenArguments(ido, content[index]));
                      //////////
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => ClinicSectionDetailsScreen(
//                            content[index],
//                            ido,
//                          ),
//                        ),
//                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 135.0,
                          width: 135.0,
                          decoration: new BoxDecoration(
                            //   color: Colors.blue,
                            borderRadius: new BorderRadius.all(Radius.circular(500.0)
                                //      topLeft:  const  Radius.circular(40.0),
                                ),
                          ),
                          child: Image.network(
                            content[index].image, //   clinicSections[index].iconImage,
                            height: 70.0,
                            width: 70.0,
                          ),
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                          child: Text(
                            content[index].name,
                            //    clinicSections[index].title,
                            style: TextStyle(
                              fontSize: PrimaryFont,
                              fontWeight: semiFont,
                              color: Theme.of(context).primaryColor,
                              height: 1,
                            ),
                          ),
                        ),

//                        Container(
//                          height: 10.0,
//                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }

  Widget _infoTab() {
    void _launchMapsUrl(double lat, double lon) async {
      final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return CustomObserver<ClinicModel>(
        stream: ClinicSectionsBloc(id: widget.id).clinicStream$,
        onSuccess: (context, data) {
          var content = data.data.clinic;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 1,
                  color: darkGrey.withOpacity(.5),
                  width: double.infinity,
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate('clinicLocationOnMap:_str'),
                        style: TextStyle(fontSize: MediumFont, fontWeight: regFont, color: greyBlue),
                      ),
                      FlatButton(
                        onPressed: () {
                          _launchMapsUrl(double.parse(content.latitude), double.parse(content.longitude));
                        },
                        child: Image.asset(
                          "assets/images/1.55x/location2@2x.png",
                          height: 40.0,
                          width: 40.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: darkGrey.withOpacity(.6),
                  width: double.infinity,
                  //  margin: EdgeInsets.only(bottom: 20.0),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        AppLocalizations.of(context).translate('insuranceCompanies:_str'),
                        style: TextStyle(fontSize: MediumFont, fontWeight: regFont, color: greyBlue),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: content.incuranceCompanies.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(10.0),
//
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.all(Radius.circular(500.0)
                                //      topLeft:  const  Radius.circular(40.0),
                                ),
                          ),
                          child: Image.network(
                            content.incuranceCompanies[index].image,
                            height: 75.0,
                            width: 75.0,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }
}

//class ClinicInfo {
//  final int id;
//  final String iconImage;
//
//  ClinicInfo(this.id, this.iconImage);
//}

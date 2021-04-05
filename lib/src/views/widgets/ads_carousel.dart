import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/clinic_sections_bloc.dart';
import 'package:heed/src/blocs/api_bloc/home_bloc.dart';
import 'package:heed/src/blocs/clinic_data_bloc.dart';
import 'package:heed/src/blocs/currency_bloc.dart';
import 'package:heed/src/models/api_models/GET/homeScreen_model.dart';
import 'package:heed/src/models/api_models/GET/homeScreen_model.dart' as mySlider;
import 'package:heed/src/views/screens/clinicSections_screen.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';

import 'observer_widget.dart';

// Home Carousel
class CarouselWidgetHome extends StatefulWidget {
  @override
  _CarouselWidgetHomeState createState() => _CarouselWidgetHomeState();
}

class _CarouselWidgetHomeState extends State<CarouselWidgetHome> {
  @override
  Widget build(BuildContext context) {
//    Widget carouselImages() {
    return CustomObserver(
      stream: locator<HomeBloc>().home$,
      onWaiting: (context) => Container(),
      onError: (context, error) => Container(),
      onSuccess: (context, HomeScreenModel data) {
        List<mySlider.Slider> carouselList = data.data.slider;

        carouselImagesList() {
          // List<mySlider.Slider> carouselList = data.data.slider;
          List<NetworkImage> widgetCarousel = carouselList
              .map((slider) => new NetworkImage(
                    slider.image,
                  ))
              .toList();
          return widgetCarousel;
        }

        return Container(
          //  color: Colors.red,
          height: 90.0,
          width: double.infinity,
          child: Carousel(
            boxFit: BoxFit.fill,
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 1000),
            dotSize: 4.0,
            dotIncreasedColor: Theme.of(context).primaryColor,
            dotBgColor: Colors.transparent,
            dotPosition: DotPosition.bottomCenter,
            dotVerticalPadding: 2.0,
            showIndicator: data.data.slider.length < 2 ? false : true,
            indicatorBgPadding: 2.0,
            images: carouselImagesList(),
            onImageTap: (int index) {
              if (carouselList[index].clinicId != 0) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ClinicSectionsScreen(
                    id: carouselList[index].clinicId,
                  );
                }));
              }
            },
          ),
        );
      },
    );
  }
}

// Clinic Carousel

class CarouselWidgetClinic extends StatelessWidget {
  final int id;
  CarouselWidgetClinic(this.id);

  @override
  Widget build(BuildContext context) {
//    Widget carouselImages() {
    return CustomObserver(
      stream: ClinicSectionsBloc(id: id).clinicStream$,
      onWaiting: (context) => Container(),
      onSuccess: (context, data) {
        var clinic = data.data.clinic;
        locator<ClinicDataBloc>().clinicDataSink.add(clinic.name);
        locator<ClinicDataBloc>().clinicDataCashSink.add(clinic.cash);
        locator<ClinicDataBloc>().clinicDataKnetSink.add(clinic.knet);

        ////
        var clinicCurrency = data.data.currency;
        locator<CurrencyBloc>().currencySink.add(clinicCurrency);
        /////////////

        List carouselList = data.data.slider;
        carouselImagesList() {
          List<NetworkImage> widgetCarousel = carouselList
              .map((slider) => new NetworkImage(
                    slider.image,
                  ))
              .toList();
          /////
//          var clinic = data.data.clinic;
//          locator<ClinicDataBloc>().clinicDataSink.add(clinic.name);
//          locator<ClinicDataBloc>().clinicDataCashSink.add(clinic.cash);
//          locator<ClinicDataBloc>().clinicDataKnetSink.add(clinic.knet);
//
//          ////
//          var clinicCurrency = data.data.currency;
//          locator<CurrencyBloc>().currencySink.add(clinicCurrency);
          return widgetCarousel;
        }

        return carouselList.length != 0
            ? Card(
          elevation: 5,
              child: Container(
                  //  color: Colors.red,
                  height: 90.0,
                  width: double.infinity,
                  child: Carousel(
                    boxFit: BoxFit.fill,
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 4.0,
                    dotIncreasedColor: Theme.of(context).primaryColor,
                    dotBgColor: Colors.transparent,
                    dotPosition: DotPosition.bottomCenter,
                    dotVerticalPadding: 2.0,
                    showIndicator: data.data.slider.length < 2 ? false : true,
                    indicatorBgPadding: 2.0,
                    images: carouselImagesList(),
                    onImageTap: (int index) {
                      if (carouselList[index].clinicId != 0 && carouselList[index].clinicId != id) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ClinicSectionsScreen(
                            id: carouselList[index].clinicId,
                          );
                        }));
                      }
                    },
                  ),
                ),
            )
            : Container();
      },
    );
  }
}

//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/checkOut_bloc.dart';
import 'package:heed/src/blocs/api_bloc/knet_bloc.dart';
import 'package:heed/src/blocs/checkout_bloc.dart';
import 'package:heed/src/blocs/clinic_data_bloc.dart';
import 'package:heed/src/blocs/currency_bloc.dart';
import 'package:heed/src/blocs/patient_reserve_bloc.dart';
import 'package:heed/src/models/api_models/POST/checkout_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/appRoot_widget.dart';
import 'package:heed/src/views/widgets/knetPaySuccess_widget.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/src/views/widgets/payment_success.dart';
import 'package:heed/theme_setting.dart';
import 'package:intl/intl.dart';

//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class CheckOutScreen extends StatefulWidget {
//  String doctorId;
//  String date;
//  String time;
//  String payType;
//  String name;
//  String phone;
//  String insuranceId;

  dynamic parentContent;
  dynamic content;
  var insuranceID;
  var insuranceData;

//  CheckOutScreen(this.doctorId,this.date,this.time,this.payType,this.name,this.phone,this.insuranceId);

  CheckOutScreen(
      this.parentContent, this.content, this.insuranceID, this.insuranceData);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final radioval = locator<PatientReserveBloc>().currentPayment;
  int codeStatus = 0;
  bool isAlertOnScreen = false;

//  int selected;

  bool checkTimeClicked = false;

/////////////////////////////////////////////////////////////////////////////
  Widget clinicName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: littleGrey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('clinicName:_str'),
                //"Clinic Name :",
                style: TextStyle(
                    fontSize: SecondaryFont,
                    color: Colors.black,
                    fontWeight: bolFont),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                //    "Bayan Dental Clinic",
                // widget.parentContent.name,
                locator<ClinicDataBloc>().currentClinicData.toString(),
                style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: medFont,
                    color: Theme.of(context).primaryColor),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                //"Date of visit :",
                AppLocalizations.of(context).translate('dateOfVisit:_str'),
                style: TextStyle(
                    fontSize: SecondaryFont,
                    color: Colors.black,
                    fontWeight: bolFont),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                // "20 Jan - 2019",
                //DateFormat("yMd")
                DateFormat('yyyy-MM-dd')
                    .format(locator<PatientReserveBloc>().currentDate),
                //.toString(),
                style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: medFont,
                    color: Theme.of(context).primaryColor),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget doctorName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: littleGrey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                // "Doctor Name :",
                AppLocalizations.of(context).translate('doctorName:_str'),
                style: TextStyle(
                    fontSize: SecondaryFont,
                    color: Colors.black,
                    fontWeight: bolFont),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.content.name,
                style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: medFont,
                    color: Theme.of(context).primaryColor),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                //   "Time of visite :",
                AppLocalizations.of(context).translate('dateOfVisit:_str'),
                style: TextStyle(
                    fontSize: SecondaryFont,
                    color: Colors.black,
                    fontWeight: bolFont),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                locator<PatientReserveBloc>().currentTime, //  "9:00 pm",
                style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: medFont,
                    color: Theme.of(context).primaryColor),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget paymentName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                // payment_method  "Payment Method :",
                radioval == 3
                    ? AppLocalizations.of(context)
                        .translate('insurance_company_str')
                    : AppLocalizations.of(context).translate('payment_method'),
                style: TextStyle(
                    fontSize: SecondaryFont,
                    color: Colors.black,
                    fontWeight: bolFont),
              ),
              SizedBox(
                height: 10.0,
              ),
              _paymentConditions()
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('Fee_Amount'),
                //  "Fee Amount :",
                style: TextStyle(
                    fontSize: SecondaryFont,
                    color: Colors.black,
                    fontWeight: bolFont),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "${widget.content.price.toString()}"
                " "
                "${locator<CurrencyBloc>().currentCurrency.toString()}",
//                    " KWD",
                style: TextStyle(
                    fontSize: PrimaryFont,
                    fontWeight: medFont,
                    color: Theme.of(context).primaryColor),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Use to navigate to (payment successful) or (payment failed).
  // 0 => checkout screen, 1=>
  Widget payButton() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 70.0),
        child: ButtonTheme(
          minWidth: 280.0,
          height: 45.0,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              child: Text(
                //   "Pay Now",
                AppLocalizations.of(context).translate('pay_now_str'),
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () async {
                String paymentType;

                if (radioval == 1) {
                  paymentType = "knet";
                } else if (radioval == 2) {
                  paymentType = "Cash";
                } else if (radioval == 3) {
                  paymentType = "Insurance";
                }

//                setState(() {
//                  selected = 2;
//                });
//

                //1- doctor name               widget.content.id;
                //2- date  DateFormat("yMd").format(locator<PatientReserveBloc>().currentDate)
                // 3- time   locator<PatientReserveBloc>().currentTime
                // 4- paytype => paymentType
                // 5- name => locator<PatientReserveBloc>().currentName
                // 6- mobile => locator<PatientReserveBloc>().currentMobile
                // 7- insuranceid => widget.insuranceID

                locator<CheckOutBloc>().inId.add(widget.content.id.toString());
                locator<CheckOutBloc>().inDate.add(DateFormat('yyyy-MM-dd')
                    .format(locator<PatientReserveBloc>().currentDate)
                    .toString());
                locator<CheckOutBloc>()
                    .inTime
                    .add(locator<PatientReserveBloc>().currentTime.toString());
                locator<CheckOutBloc>().inPayType.add(paymentType.toString());

                locator<CheckOutBloc>()
                    .inName
                    .add(locator<PatientReserveBloc>().currentName.toString());
                locator<CheckOutBloc>().inPhone.add(
                    locator<PatientReserveBloc>().currentMobile.toString());

                locator<CheckOutBloc>()
                    .inInsurance
                    .add(widget.insuranceID.toString());

                locator<CheckOutBloc>().inClick.add(!checkTimeClicked);

                if (radioval != 1) {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              buildPaymentSuccessful()));
                } else {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => WebViewKnet()));
                }
              }),
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  Widget buildPaymentSuccessful() {
    return PaySuccess();
  }

//  Widget buildPaymentFailed() {
//    return PayFailed(
//      onPressedFailed: () {
//        setState(() {
//          selected = 2;
//        });
//      },
//    );
//  }

  Widget buildCheckoutBody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    //  "Checkout",
                    AppLocalizations.of(context).translate('Checkout_str'),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: bolFont,
                        fontSize: MediumFont),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Booking Summery:-
                  Text(
                    //   "Booking Summary :",
                    AppLocalizations.of(context)
                        .translate('Booking_Summary_str'),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: bolFont,
                        fontSize: MediumFont),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7.0),
                    width: 50.0,
                    height: 2.0,
                    color: Theme.of(context).primaryColor,
                  ),

                  clinicName(),
                  doctorName(),
                  paymentName(),
                  payButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////
  @override
  void dispose() {
    // locator<PrefsService>().isOnline = false;
    super.dispose();
  }
//  @override
//  void initState() {
//    selected = 2;
//    super.initState();
//  }
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
        body: RootApp(
          child: StreamBuilder<Object>(
              initialData: 2,
              stream: locator<ChangePageBloc>().changePage$,
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        child: child,
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                      );
                    },
                    duration: Duration(milliseconds: 500),
                    child: buildCheckoutBody());
              }),
        ),
      ),
    );
  }

  Widget _paymentConditions() {
    if (radioval == 1) {
      return Text(
        AppLocalizations.of(context).translate('KNet_str'),
        //    "K Net",
        style: TextStyle(
            fontSize: PrimaryFont,
            fontWeight: medFont,
            color: Theme.of(context).primaryColor),
      );
    } else if (radioval == 2) {
      return Text(
        AppLocalizations.of(context).translate('cash_str'),
        // "Cash",
        style: TextStyle(
            fontSize: PrimaryFont,
            fontWeight: medFont,
            color: Theme.of(context).primaryColor),
      );
    } else if (radioval == 3) {
      return Text(
        widget.insuranceData.name,
        //  AppLocalizations.of(context).translate('insurance_str'),
        //"Insurance",
        style: TextStyle(
            fontSize: PrimaryFont,
            fontWeight: medFont,
            color: Theme.of(context).primaryColor),
      );
    }
  }
}

class WebViewKnet extends StatelessWidget {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("payment_success") || url.contains("payment_fail")) {
//        flutterWebviewPlugin.close();
        locator<KnetBloc>().inUrl.add(url);
        flutterWebviewPlugin.close();
//        var response = Dio().get(url).then((value) {
//          return CheckoutModel.fromJson(value.data);
//
//
//        });
        // flutterWebviewPlugin.close();
        // Navigator.pop(context);
        // Navigator.pop(context);

        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => KnetPaySuccess()));
      }
    });

    return NetworkSensitive(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('Payment_Gateway'),
            style: TextStyle(
                fontSize: MainFont, fontWeight: semiFont, color: Colors.white),
          ),
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
        body: CustomObserver(
            stream: locator<CheckOutBloc>().checkOut$,
            onSuccess: (context, CheckoutModel data) {
              String msg = data.message;
              int status = data.status;
              String webView = data.data.url;
              return WebviewScaffold(
                ignoreSSLErrors: true,
                url: webView,
                withJavascript: true,
              );
            }),
      ),
    );
  }
}

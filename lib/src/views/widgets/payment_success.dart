import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/checkOut_bloc.dart';
import 'package:heed/src/models/api_models/POST/checkout_model.dart';
import 'package:heed/src/views/screens/home_screen.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';
import 'package:heed/theme_setting.dart';

class PaySuccess extends StatelessWidget {
//  var response;
//
//  PaySuccess(this.response);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: CustomObserver(
            stream: locator<CheckOutBloc>().checkOut$,
            onSuccess: (context, CheckoutModel data) {
              String msg = data.message;
              int status = data.status;
              return Center(
                ///padding: EdgeInsets.all(80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      status == 1? "assets/images/sucess.png": "assets/images/fail.png",
                      height: 75,
                      width: 75,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 80.0),
                      child: Text(
                        msg,
                        //    "Payment Complete Successfully",
                        style: TextStyle(
                            fontSize: MainFont,
                            fontWeight: bolFont,
                            height: 1.5,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      width: 250.0,
                    ),
                    ButtonTheme(
                      minWidth: 280.0,
                      height: 45.0,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            status ==1?  AppLocalizations.of(context).translate('home_str') :AppLocalizations.of(context).translate("try_again_str"),
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: () {
                            // Navigate directly to (home).
                   //         Navigator.of(context).popUntil((route) => route.isFirst);
//

                            status ==1?   Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen())):Navigator.pop(context);

                          }),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
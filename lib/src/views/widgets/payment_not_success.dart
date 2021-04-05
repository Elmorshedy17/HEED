import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heed/theme_setting.dart';

class PayFailed extends StatelessWidget {
  final Function onPressedFailed;

  const PayFailed({Key key, this.onPressedFailed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      ///padding: EdgeInsets.all(80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/fail.png",
            height: 75,
            width: 75,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 80.0),
            child: Text(
              "Payment inComplete Successfully",
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
                  "Try Again",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: onPressedFailed != null ? onPressedFailed : () {}),
          ),
        ],
      ),
    );
  }
}

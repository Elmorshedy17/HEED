import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomObserver<T> extends StatelessWidget {
  final Stream<T> stream;
  final Function onError;
  final Function onSuccess;
  final Function onWaiting;

  const CustomObserver(
      {this.onError,
      @required this.onSuccess,
      @required this.stream,
      this.onWaiting});

  // Function get _defaultOnWaiting =>
  //     (context) => Center(child: CircularProgressIndicator());

  Function get _defaultOnWaiting => (context) => Center(child: SpinKitCircle(
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.blue : Colors.blueAccent,
            ),
          );
        },
      ));

  Function get _defaultOnError => (context, error) => Container();
//      AlertDialog(
//        content: Container(
//          decoration: new BoxDecoration(
//            shape: BoxShape.rectangle,
//            color: const Color(0xFFFFFF),
//            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
//          ),
//          height: locator<PrefsService>().appLanguage == 'en' ? 120 : 130,
//          width: MediaQuery.of(context).size.width * 0.5,
//          child: Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Image.asset(
//                    'assets/images/no-wifi.png',
//                    height: 30,
//                    width: 30,
//                  ),
//                  SizedBox(
//                    width: 10,
//                  ),
//                  Text(
//                    AppLocalizations.of(context).translate('noWifiTitle_str'),
//                    style: TextStyle(
//                        color: primaryColor,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 25),
//                  )
//                ],
//              ),
//              Container(
//                  child: Text(
//                AppLocalizations.of(context).translate('noWifiContent_str'),
//                textAlign: TextAlign.center,
//                style: TextStyle(fontSize: 18, height: 1.5),
//              )),
//            ],
//          ),
//        ),
//      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return onError != null
              ? onError(context, snapshot.error)
              : _defaultOnError(context, snapshot.error);
        }

        if (snapshot.hasData) {
          T data = snapshot.data;
          return onSuccess(context, data);
        } else {
          return onWaiting != null
              ? onWaiting(context)
              : _defaultOnWaiting(context);
        }
      },
    );
  }
}

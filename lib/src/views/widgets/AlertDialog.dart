import 'package:flutter/material.dart';
import 'package:heed/localizations/app_localizations.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/theme_setting.dart';

// bool isAlertOnScreen = false;

void showInternetAlert(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Container(
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFFFFFF),
              borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            ),
            height: locator<PrefsService>().appLanguage == 'en' ? 120 : 130,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/no-wifi.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('noWifiTitle_str'),
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )
                  ],
                ),
                Container(
                    child: Text(
                  AppLocalizations.of(context).translate('noWifiContent_str'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, height: 1.5),
                )),
              ],
            ),
          ),
        );
      });
}

// void connectionChecker(BuildContext context) {
//   ConnectionCheckerService().getConnectionStatus$.listen((state) {
//     if (state == InternetStatus.Offline && !locator<PrefsService>().isOnline) {
//       // locator<PrefsService>().isOnline = true;
//       isAlertOnScreen = true;
//       showInternetAlert(context);
// //      print('محمممااااااا');
//       // Navigator.push(context, InternetAlert());
//     } else if (state == InternetStatus.Online &&
//         locator<PrefsService>().isOnline) {
//       // locator<PrefsService>().isOnline = false;
//       if (isAlertOnScreen) {
//         Navigator.pop(context);
//       }
//     }
//   });
// }

// class InternetAlert extends ModalRoute<void> {
//   @override
//   Color get barrierColor => Colors.white.withOpacity(0.0);

//   @override
//   bool get barrierDismissible => false;

//   @override
//   String get barrierLabel => null;

//   @override
//   bool get maintainState => true;

//   @override
//   bool get opaque => false;

//   @override
//   Duration get transitionDuration => Duration(milliseconds: 500);

//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) {
//     // This makes sure that text and other content follows the material style
//     return Material(
//       type: MaterialType.transparency,
//       // make sure that the overlay content is not cut off
//       child: SafeArea(
//           // child: _buildOverlayContent(context),
//           child: alertWidget(context)),
//     );
//   }

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     // You can add your own animations for the overlay content
//     return FadeTransition(
//       opacity: animation,
//       child: ScaleTransition(
//         scale: animation,
//         child: child,
//       ),
//     );
//   }

//   // Widget _buildOverlayContent(BuildContext context) {
//   //   return Center(
//   //     child: Column(
//   //       mainAxisSize: MainAxisSize.min,
//   //       children: <Widget>[
//   //         Text(
//   //           'This is a nice overlay',
//   //           style: TextStyle(color: Colors.white, fontSize: 30.0),
//   //         ),
//   //         RaisedButton(
//   //           onPressed: () => Navigator.pop(context),
//   //           child: Text('Dismiss'),
//   //         )
//   //       ],
//   //     ),
//   //   );
//   // }
// }

// Widget alertWidget(BuildContext context) {
//   // bool isFirstAlert = true;

//   locator<ConnectionCheckerService>().getConnectionStatus$.listen((status) {
//     if (status == InternetStatus.Online && locator<PrefsService>().isOnline) {
//       // isFirstAlert = false;
//       locator<PrefsService>().isOnline = false;
//       Navigator.pop(context);
//       // locator<OfflineOnlineBloc>().inFlag.add(true);
//     }
//   });
//   return AlertDialog(
//     content: Container(
//       decoration: new BoxDecoration(
//         shape: BoxShape.rectangle,
//         color: const Color(0xFFFFFF),
//         borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
//       ),
//       height: locator<PrefsService>().appLanguage == 'en' ? 120 : 130,
//       width: MediaQuery.of(context).size.width * 0.5,
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Image.asset(
//                 'assets/images/no-wifi.png',
//                 height: 30,
//                 width: 30,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 AppLocalizations.of(context).translate('noWifiTitle_str'),
//                 style: TextStyle(
//                     color: primaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25),
//               )
//             ],
//           ),
//           Container(
//               child: Text(
//             AppLocalizations.of(context).translate('noWifiContent_str'),
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 18, height: 1.5),
//           )),
//         ],
//       ),
//     ),
//   );
// }

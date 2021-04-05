import 'package:flutter/material.dart';
import 'package:heed/localizations/app_language.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:provider/provider.dart';

class LangScreen extends StatelessWidget {
  const LangScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/splashbg.png',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            right: 10,
            left: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Image.asset('assets/images/small-logo.png'),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Language',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        appLanguage.changeLanguage(Locale('en'));
                        locator<PrefsService>().appLanguage = 'en';
                        locator<PrefsService>().hasChosenLanguage = true;
                        Navigator.pushReplacementNamed(context, '/homeScreen');
                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            'English',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 2,
                            width: 65,
                            color: Colors.white,
//                          child: CustomPaint(painter: DrawHorizontalLine()),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        appLanguage.changeLanguage(Locale('ar'));
                        locator<PrefsService>().appLanguage = 'ar';
                        locator<PrefsService>().hasChosenLanguage = true;
                        Navigator.pushReplacementNamed(context, '/homeScreen');
                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            'عربي',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 2,
                            width: 50,
                            color: Colors.white,
//                          CustomPaint(painter: DrawHorizontalLine()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

//class DrawHorizontalLine extends CustomPainter {
//  Paint _paint;
//
//  DrawHorizontalLine() {
//    _paint = Paint()
//      ..color = Colors.white
//      ..strokeWidth = 1
//      ..strokeCap = StrokeCap.round;
//  }
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    canvas.drawLine(Offset(-45.0, 0.0), Offset(45.0, 0.0), _paint);
//  }
//
//  @override
//  bool shouldRepaint(CustomPainter oldDelegate) {
//    return false;
//  }
//}

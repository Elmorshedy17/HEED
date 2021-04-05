import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/blocs/api_bloc/medicalAdviceDetails_bloc.dart';
import 'package:heed/src/models/api_models/GET/medicalAdviceDetails_model.dart';
import 'package:heed/src/services/prefs_Service.dart';
import 'package:heed/src/views/widgets/NetworkSensitive.dart';
import 'package:heed/src/views/widgets/observer_widget.dart';

class MedicalAdviceDetailsScreen extends StatefulWidget {
  final int id;

  const MedicalAdviceDetailsScreen({Key key, this.id}) : super(key: key);

  @override
  _MedicalAdviceDetailsScreenState createState() =>
      _MedicalAdviceDetailsScreenState();
}

class _MedicalAdviceDetailsScreenState
    extends State<MedicalAdviceDetailsScreen> {
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
  void dispose() {
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
      child: CustomObserver(
        stream: MedicalAdviceDetailsBloc(id: widget.id).medicalAdviceDetails$,
        onSuccess: (context, MedicalAdviceDetailsModel data) {
          MedicalAdvice content = data.data.medicalAdvice;
          return Scaffold(
            appBar: AppBar(
              title: Text(content.title),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
                  height: 160.0,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(5.0)),
                    image: DecorationImage(
                      image: NetworkImage(content.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
//              NetworkImage(content.image),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Html(
                    // customTextAlign: (data) {
                    //   return TextAlign.justify;
                    // },
                    data: content.desc,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class LaunchMap {
//  static launchMaps(String lat, String lng) async {
//    String googleUrl = 'comgooglemaps://?center=$lat,$lng';
//    String appleUrl = 'https://maps.apple.com/?sll=$lat,$lng';
//    if (await canLaunch("comgooglemaps://")) {
//      print('launching com googleUrl');
//      await launch(googleUrl);
//    } else if (await canLaunch(appleUrl)) {
//      print('launching apple url');
//      await launch(appleUrl);
//    } else {
//      throw 'Could not launch url';
//    }
//  }

  static launchMap(lat, lng) async {
    var url = '';
    var urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = "comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving";
    if(await canLaunch(url))
    {await launch(url);}
    else if (await canLaunch(urlAppleMaps)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(urlAppleMaps)) {
      await launch(urlAppleMaps);
    } else {
      throw 'Could not launch $url';
    }
  }
}

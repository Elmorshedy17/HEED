import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final int mSeconds;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final double photoSize;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;
  final Text loadingText;
  final ImageProvider imageBackground;
  final Gradient gradientBackground;
  SplashScreen(
      {this.loaderColor,
      @required this.mSeconds,
      this.photoSize,
      this.onClick,
      this.navigateAfterSeconds,
      this.title = const Text(''),
      this.backgroundColor = Colors.white,
      this.styleTextUnderTheLoader = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      this.image,
      this.loadingText = const Text(""),
      this.imageBackground,
      this.gradientBackground});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//  Future<AudioPlayer> playLocalAsset() async {
//    AudioCache cache = new AudioCache();
//    return await cache.play('voice.wav');
//  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: widget.mSeconds), () {
      if (widget.navigateAfterSeconds is String) {
        // It's fairly safe to assume this is using the in-built material
        // named route component
        Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
      } else if (widget.navigateAfterSeconds is Widget) {
        Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => widget.navigateAfterSeconds));
      } else {
        throw new ArgumentError('widget.navigateAfterSeconds must either be a String or Widget');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//    playLocalAsset();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: widget.image,
      ),
    );
  }
}

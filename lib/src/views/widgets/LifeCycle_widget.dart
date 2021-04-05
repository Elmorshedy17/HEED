// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:heed/locator.dart';
import 'package:heed/src/services/prefs_Service.dart';

/// Stop and start long running services
class LifeCycleWidget extends StatefulWidget {
  final Widget child;
  final Function onInit;
  final Function onDispose;

  LifeCycleWidget(
      {Key key,
      @required this.child,
      @required this.onInit,
      @required this.onDispose,

        // this.analytics, this.observer
  }
        )
      : super(key: key);

  // final FirebaseAnalytics analytics;
  // final FirebaseAnalyticsObserver observer;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_LifeCycleWidgetState>().restartApp();
  }

  _LifeCycleWidgetState createState() => _LifeCycleWidgetState(
      // analytics, observer
  );
}

class _LifeCycleWidgetState extends State<LifeCycleWidget>
    with WidgetsBindingObserver {

  // final FirebaseAnalyticsObserver observer;
  // final FirebaseAnalytics analytics;

  // _LifeCycleWidgetState(this.analytics, this.observer);

  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    // locator<PrefsService>().isOnline = false;
    WidgetsBinding.instance.removeObserver(this);
    widget.onDispose();
    super.dispose();
  }
}

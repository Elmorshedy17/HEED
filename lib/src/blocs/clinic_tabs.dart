import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ClinicTabsBloc {
  final BehaviorSubject<bool> streamTabsController =
      BehaviorSubject<bool>.seeded(false);
// sink
//  Sink get TabsSink => streamTabsController.sink;
// stream
  Stream<bool> get tabsStream => streamTabsController.stream;

  bool get _currentState => streamTabsController.value;

// function to change the color
  changeTabsController() {
    streamTabsController.add(!_currentState);
  }

  dispose() {
    streamTabsController.close();
  }
}

//  Widget clinicTabs() {
//
//    bool x = false;
//
//
//
//    return StreamBuilder<Object>(
//      stream: clinicTabsBloc.TabsStream,
//      builder: (context, snapshot) {
////        halal(){
////          if(snapshot.hasData){
////            x = true;
////          }
////          if(snapshot.data == x){
////            x = false ;
////          }
////
////          return x;
////        }
//
//      if(snapshot.hasData){
//        x = snapshot.data;
//      }else{
//        x = false;
//      }
//
//        return Row(
//children: <Widget>[
//  Expanded(
//        child: FlatButton(
//          onPressed: clinicTabsBloc.changeTabsController,
//          child: Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: Center(child: Column(
//              children: <Widget>[
//                Text("Services",style: TextStyle(fontSize: MediumFont,fontWeight: medFont,color:  x ? Colors.red:Colors.blue),),
//              Divider(color:  x ? Colors.red:Colors.blue),
//              ],
//            )),
//          ),
//        ),
//  ),
//  Expanded(
//        child: FlatButton(
//          onPressed: clinicTabsBloc.changeTabsController,
//          child: Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: Center(child: Column(
//              children: <Widget>[Text("Info",style: TextStyle(fontSize: MediumFont,fontWeight: medFont,color: x ? Colors.blue:Colors.red),),
//              Divider(color:  x ? Colors.blue:Colors.red),],
//            )),
//          ),
//        ),
//
//  ),
//],
//        );
//      }
//    );
//  }
//}

//
//  Widget clinicTabs() {
//
//    bool x = false;
//
//
//
//    return StreamBuilder<Object>(
//      stream: clinicTabsBloc.TabsStream,
//      builder: (context, snapshot) {
////        halal(){
////          if(snapshot.hasData){
////            x = true;
////          }
////          if(snapshot.data == x){
////            x = false ;
////          }
////
////          return x;
////        }
//
//      if(snapshot.hasData){
//        x = snapshot.data;
//      }else{
//        x = false;
//      }
//
//        return Row(
//children: <Widget>[
//  Expanded(
//        child: FlatButton(
//          onPressed: clinicTabsBloc.changeTabsController,
//          child: Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: Center(child: Column(
//              children: <Widget>[
//                Text("Services",style: TextStyle(fontSize: MediumFont,fontWeight: medFont,color:  x ? Colors.red:Colors.blue),),
//              Divider(color:  x ? Colors.red:Colors.blue),
//              ],
//            )),
//          ),
//        ),
//  ),
//  Expanded(
//        child: FlatButton(
//          onPressed: clinicTabsBloc.changeTabsController,
//          child: Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: Center(child: Column(
//              children: <Widget>[Text("Info",style: TextStyle(fontSize: MediumFont,fontWeight: medFont,color: x ? Colors.blue:Colors.red),),
//              Divider(color:  x ? Colors.blue:Colors.red),],
//            )),
//          ),
//        ),
//
//  ),
//],
//        );
//      }
//    );
//  }

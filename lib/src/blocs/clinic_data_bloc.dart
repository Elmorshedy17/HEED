import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ClinicDataBloc {

  final BehaviorSubject _clinicDataSubject =
  BehaviorSubject();

  Stream get clinicData$ => _clinicDataSubject.stream;

  Sink get clinicDataSink => _clinicDataSubject.sink;

  String get currentClinicData => _clinicDataSubject.value;


//////////////knet//////yea///no/////////

  final BehaviorSubject _clinicDataKnetSubject =
  BehaviorSubject();

  Stream get clinicDataKnet$ => _clinicDataKnetSubject.stream;

  Sink get clinicDataKnetSink => _clinicDataKnetSubject.sink;

  String get currentClinicDataKnet => _clinicDataKnetSubject.value;



  /////////////cash//////yea//no////////

  final BehaviorSubject _clinicDataCashSubject =
  BehaviorSubject();

  Stream get clinicDataCash$ => _clinicDataCashSubject.stream;

  Sink get clinicDataCashSink => _clinicDataCashSubject.sink;

  String get currentClinicDataCash => _clinicDataCashSubject.value;








  dispose() {
    _clinicDataSubject.close();
    _clinicDataKnetSubject.close();
    _clinicDataCashSubject.close();
  }

}

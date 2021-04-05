import 'package:rxdart/rxdart.dart';

class OfflineOnlineBloc {
  PublishSubject<bool> _subject = PublishSubject<bool>();

  Sink<bool> get inFlag => _subject.sink;

  Stream<bool> get flag$ => _subject.stream;
}

import 'package:chat_server/observer/subject.dart';

abstract class IObserver {
  bool get online;
  String get name;
  void update(Subject object) {}
}

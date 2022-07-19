import 'package:chat_server/observer/subject.dart';
import 'package:chat_server/api/strategy/strategy.dart';

class NewRoom<T extends String> implements Strategy<T> {
  NewRoom({required Subject subject}) : _subject = subject;
  final Subject _subject;
  @override
  void execute(event) {}

  @override
  Subject get subject => _subject;
}

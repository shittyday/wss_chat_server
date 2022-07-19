import 'package:wss_chat_server/observer/subject.dart';
import 'package:wss_chat_server/api/strategy/strategy.dart';

class ExistChat<T extends String> implements Strategy<T> {
  ExistChat({required Subject subject}) : _subject = subject;
  final Subject _subject;
  @override
  void execute(event) {}

  @override
  Subject get subject => _subject;
}

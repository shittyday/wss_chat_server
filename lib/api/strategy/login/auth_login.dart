import 'package:wss_chat_server/observer/subject.dart';
import 'package:wss_chat_server/api/strategy/strategy.dart';
import 'dart:io';

class AuthLogin<T extends HttpRequest> implements Strategy<T> {
  AuthLogin({required Subject subject}) : _subject = subject;
  final Subject _subject;
  @override
  void execute(event) {
    if (event.method == 'POST') {
      if (event.requestedUri.queryParameters.containsKey('login')) {
        if (event.requestedUri.queryParameters['login'] == 'Alex') {
          event.response.statusCode = 201;
          event.response.write('{"token":"A14112dASDFC#!@#"}');
          event.response.close();
        }
      }
    }
  }

  @override
  Subject get subject => _subject;
}

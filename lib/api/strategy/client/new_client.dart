import 'dart:developer' as di;
import 'dart:math';

import 'package:wss_chat_server/models/user/user.dart';
import 'package:wss_chat_server/observer/observer.dart';
import 'package:wss_chat_server/observer/subject.dart';
import 'package:wss_chat_server/api/strategy/strategy.dart';
import 'dart:io';

class NewClient<T extends HttpRequest> implements Strategy<T> {
  NewClient({required Subject subject}) : _subject = subject;
  final Subject _subject;

  @override
  void execute(event) async {
    final id = Random().nextInt(255);
    di.log('new client $id');
    subject.attach(Observer(
        user: User(
            firstName: 'Alex', lastName: 'Truf', nickname: 'Shitty', id: id),
        ws: await WebSocketTransformer.upgrade(event)
          ..pingInterval = Duration(seconds: 50)));
    subject.attachState;
  }

  @override
  Subject get subject => _subject;
}

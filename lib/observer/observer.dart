import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:isolate';

import 'package:wss_chat_server/models/user/user.dart';
import 'package:wss_chat_server/observer/observer_interface.dart';
import 'package:wss_chat_server/observer/subject.dart';
import 'package:intl/intl.dart';
import 'common_types.dart';

class Observer implements IObserver {
  Observer({required this.user, required this.ws});

  final WebSocket ws;
  StreamSubscription? _subscription;

  /// Пользователь
  final User user;

  @override
  void update(Subject object) {
    switch (object.state.state) {
      case State.chat:
        if (user.id == object.state.id) {
          ws.add(
              '${DateFormat('hh - mm').format(DateTime.now())}\n${object.state.message}');
          object.clearState();
        }

        break;
      case State.room:
        if (user.id == object.state.id) {
          object.clearState();
        }
        break;

      case State.none:
        break;
      case State.attach:
        _subscription ??= ws.listen((event) {
          parseMessage(message: event, object: object);
        });
        break;
      default:
        object.clearState();
    }
  }

  Future<void> parseMessage(
      {required String message, required Subject object}) async {
    Map<String, dynamic> json = await _parseInBackground(message);

    object.sendMessage(
        text: json['message'], chatid: json['chatId'], roomId: json['roomId']);
  }

  Future<Map<String, dynamic>> _parseInBackground(String message) async {
    final p = ReceivePort();
    await Isolate.spawn(jsonIsolate, [p.sendPort, message]);
    return await p.first as Map<String, dynamic>;
  }

  static void jsonIsolate(List<dynamic> args) {
    final jsonData = jsonDecode(args[1]);
    var sendPort = args[0] as SendPort;
    Isolate.exit(sendPort, jsonData);
  }

  @override
  bool get online => ws.closeCode == null;

  @override
  String get name => user.firstName;
}

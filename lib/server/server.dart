import 'dart:async';
import 'dart:io';

import 'package:wss_chat_server/api/strategy/chat/exist_chat.dart';
import 'package:wss_chat_server/api/strategy/chat/new_chat.dart';
import 'package:wss_chat_server/api/strategy/friends/exist_friend.dart';
import 'package:wss_chat_server/api/strategy/friends/new_friend.dart';
import 'package:wss_chat_server/api/strategy/login/auth_login.dart';
import 'package:wss_chat_server/api/strategy/login/exist_login.dart';
import 'package:wss_chat_server/api/strategy/room/exist_room.dart';
import 'package:wss_chat_server/api/strategy/room/new_room.dart';
import 'package:wss_chat_server/common/common_types.dart';
import 'package:wss_chat_server/observer/subject.dart';
import 'package:wss_chat_server/api/strategy/client/new_client.dart';
import 'package:wss_chat_server/api/strategy/server_context.dart';

class Server {
  const Server._({required this.address});

  factory Server.createServer({required dynamic address}) {
    return Server._(address: address);
  }

  final dynamic address;

  Future<void> initServer() async {
    final server = await HttpServer.bind(InternetAddress.anyIPv4, 80)
      ..autoCompress = true;
    final serverContext = ServerContext();
    Subject serverSubject = Subject();
    Timer.periodic(Duration(minutes: 1), (timer) {
      serverSubject.notify();
    });
    server.listen((event) {
      if (event.headers.value('upgrade') != null) {
        if (event.method == 'GET') {
          if (event.requestedUri.path == Path.room.path) {
            serverContext.strategy = ExistRoom(subject: serverSubject);
          }
          if (event.requestedUri.path == Path.login.path) {
            serverContext.strategy = ExistLogin(subject: serverSubject);
          }
          if (event.requestedUri.path == Path.chat.path) {
            serverContext.strategy = ExistChat(subject: serverSubject);
          }
          if (event.requestedUri.path == Path.friends.path) {
            serverContext.strategy = ExistFriend(subject: serverSubject);
          }
        }
        serverContext.strategy = NewClient(subject: serverSubject);
      }
      if (event.method == 'POST') {
        if (event.requestedUri.path == Path.room.path) {
          serverContext.strategy = NewRoom(subject: serverSubject);
        }
        if (event.requestedUri.path == Path.login.path) {
          serverContext.strategy = AuthLogin(subject: serverSubject);
        }
        if (event.requestedUri.path == Path.chat.path) {
          serverContext.strategy = NewChat(subject: serverSubject);
        }
        if (event.requestedUri.path == Path.friends.path) {
          serverContext.strategy = NewFriend(subject: serverSubject);
        }
      }
      if (event.method == 'GET') {
        if (event.requestedUri.path == Path.room.path) {
          serverContext.strategy = ExistRoom(subject: serverSubject);
        }
        if (event.requestedUri.path == Path.login.path) {
          serverContext.strategy = ExistLogin(subject: serverSubject);
        }
        if (event.requestedUri.path == Path.chat.path) {
          serverContext.strategy = ExistChat(subject: serverSubject);
        }
        if (event.requestedUri.path == Path.friends.path) {
          serverContext.strategy = ExistFriend(subject: serverSubject);
        }
      }
      serverContext.strategy?.execute(event);
    });
  }
}

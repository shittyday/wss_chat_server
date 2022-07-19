import 'dart:async';
import 'dart:io';

import 'package:wss_chat_server/api/strategy/strategy.dart';
import 'package:wss_chat_server/common/common_types.dart';
import 'package:wss_chat_server/observer/subject.dart';
import 'package:wss_chat_server/api/strategy/client/new_client.dart';
import 'package:wss_chat_server/api/strategy/server_context.dart';

class Server {
  const Server._({required this.address, required this.context});

  factory Server.createServer(
      {required dynamic address, required SecurityContext context}) {
    return Server._(address: address, context: context);
  }

  final dynamic address;
  final SecurityContext context;

  Future<void> initServer() async {
    final server =
        await HttpServer.bindSecure(InternetAddress.anyIPv4, 443, context)
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
            serverContext.strategy = Strategy.existRoom(subject: serverSubject);
          }
          if (event.requestedUri.path == Path.login.path) {
            serverContext.strategy = Strategy.auth(subject: serverSubject);
          }
          if (event.requestedUri.path == Path.chat.path) {
            serverContext.strategy = Strategy.newChat(subject: serverSubject);
          }
          if (event.requestedUri.path == Path.friends.path) {
            serverContext.strategy = Strategy.newFriend(subject: serverSubject);
          }
        }
        serverContext.strategy = NewClient(subject: serverSubject);
      }
      if (event.method == 'POST') {
        if (event.requestedUri.path == Path.room.path) {
          serverContext.strategy = Strategy.existRoom(subject: serverSubject);
        }
        if (event.requestedUri.path == Path.login.path) {
          serverContext.strategy = Strategy.auth(subject: serverSubject);
        }
        if (event.requestedUri.path == Path.chat.path) {
          serverContext.strategy = Strategy.newChat(subject: serverSubject);
        }
        if (event.requestedUri.path == Path.friends.path) {
          serverContext.strategy = Strategy.newFriend(subject: serverSubject);
        }
      }
      serverContext.strategy?.execute(event);
    });
  }
}

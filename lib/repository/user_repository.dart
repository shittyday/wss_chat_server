import 'package:chat_server/models/chat/chat.dart';
import 'package:chat_server/models/messages/message.dart';
import 'package:chat_server/models/user/user.dart';
import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

class UserRepository {
  const UserRepository({required this.userId});

  final int userId;

  User get user =>
      User(firstName: '123', lastName: '321', nickname: "nickname", id: userId);

  Future<void> addMessage({required Message message}) async {
    final db = sqlite3.open('server.db');
    final stmt = db.prepare('INSERT INTO messages (text) VALUES (?)');
    try {
      stmt.execute([message.message]);
      user.messages
          ?.add(Message(message: message.message, id: db.lastInsertRowId));
    } finally {
      stmt.dispose();

      db.dispose();
    }
  }

  Future<void> newChat({required Chat chat}) async {
    final db = sqlite3.open('server.db');
    final stmt = db.prepare('INSERT INTO chat (title,description) VALUES (?)');
    try {
      stmt.execute([chat.title, chat.description]);
      user.chats?.add(Chat(
          description: chat.description,
          title: chat.title,
          id: db.lastInsertRowId));
    } finally {
      stmt.dispose();
      db.dispose();
    }
  }

  Future newRoom() async {}
}

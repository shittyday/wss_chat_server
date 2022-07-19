import 'package:chat_server/observer/subject.dart';
import 'package:chat_server/api/strategy/room/exist_room.dart';
import 'package:chat_server/api/strategy/room/new_room.dart';
import 'package:chat_server/api/strategy/friends/new_friend.dart';
import 'package:chat_server/api/strategy/friends/exist_friend.dart';
import 'package:chat_server/api/strategy/client/new_client.dart';
import 'package:chat_server/api/strategy/login/auth_login.dart';
import 'package:chat_server/api/strategy/login/exist_login.dart';
import 'package:chat_server/api/strategy/chat/exist_chat.dart';
import 'package:chat_server/api/strategy/chat/new_chat.dart';

abstract class Strategy<T> {
  /// Существующая комната
  factory Strategy.existRoom({required Subject subject}) = ExistRoom;

  /// Создание комната
  factory Strategy.newRoom({required Subject subject}) = NewRoom;

  /// Добавление друга
  factory Strategy.newFriend({required Subject subject}) = NewFriend;

  /// Существующий друг
  factory Strategy.existFriends({required Subject subject}) = ExistFriend;

  /// Добавление  нового соединения(новый вебсокет)
  factory Strategy.newClient({required Subject subject}) = NewClient;

  /// Существующий профиль
  factory Strategy.existLogin({required Subject subject}) = ExistLogin;

  /// Авторизация
  factory Strategy.auth({required Subject subject}) = AuthLogin;

  /// Существующий чат
  factory Strategy.existChat({required Subject subject}) = ExistChat;

  /// Новый чат
  factory Strategy.newChat({required Subject subject}) = NewChat;

  /// Объект управляющий
  Subject get subject;

  /// Выполнение какого либо действия
  void execute(T event);
}

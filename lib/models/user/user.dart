import 'package:chat_server/models/chat/chat.dart';
import 'package:chat_server/models/messages/message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    int? id,
    required String firstName,
    required String lastName,
    required String nickname,
    List<Message>? messages,
    List<Chat>? chats,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../messages/message.dart';

part 'chat.freezed.dart';

part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    int? id,
    String? title,
    String? description,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}

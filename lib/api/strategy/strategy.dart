import 'package:wss_chat_server/observer/subject.dart';

abstract class Strategy<T> {
  /// Объект управляющий
  Subject get subject;

  /// Выполнение какого либо действия
  void execute(T event);
}

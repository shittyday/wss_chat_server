import 'dart:developer';

import 'package:chat_server/observer/common_types.dart';
import 'package:chat_server/observer/observer_interface.dart';
import 'package:chat_server/observer/subject_state.dart';
import 'package:chat_server/observer/subjet_interface.dart';

class Subject implements ISubject {
  final _observers = <IObserver>[];
  SubjectState state = SubjectState.clear();
  bool waiting = false;
  @override
  void attach(IObserver observer) {
    pause();
    _observers.add(observer);
  }

  @override
  void detatch(IObserver observer) {
    pause();
    if (_observers.contains(observer)) {
      _observers.remove(observer);
    }
  }

  @override
  void notify() {
    waiting = true;
    for (var observer in _observers) {
      observer.update(this);
    }
    _observers.removeWhere((element) {
      var needRemove = !element.online;
      if (needRemove) {
        log('Date remove:${DateTime.now()}\n${element.name}');
      }
      return needRemove;
    });
    waiting = false;
  }

  void clearState() {
    state = SubjectState.clear();
  }

  void get attachState {
    pause();
    state = state.copyWith(state: State.attach);
    notify();
  }

  void sendMessage({int? chatid, int? roomId, required String text}) {
    pause();
    state = state.copyWith(
        state: chatid == null ? State.room : State.chat,
        id: chatid ?? roomId ?? 0,
        message: text);
    notify();
  }

  void pause() {
    while (waiting) {}
  }
}

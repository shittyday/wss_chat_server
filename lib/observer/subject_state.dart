import 'common_types.dart';

class SubjectState {
  const SubjectState._(
      {required this.state, required this.id, required this.message});

  factory SubjectState.clear() {
    return SubjectState._(id: 0, message: '', state: State.none);
  }

  SubjectState copyWith({State? state, int? id, String? message}) {
    return SubjectState._(
        state: state ?? this.state,
        id: id ?? this.id,
        message: message ?? this.message);
  }

  final State state;
  final int id;
  final String message;
}

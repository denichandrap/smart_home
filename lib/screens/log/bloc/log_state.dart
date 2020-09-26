part of 'log_bloc.dart';

abstract class LogState extends Equatable {
  const LogState();

  @override
  List<Object> get props => [];
}

class LogInitial extends LogState {}

class LogFailure extends LogState {}

class LogSuccess extends LogState {
  final List<ShowLog> logs;
  final bool hasReachedMax;

  const LogSuccess({
    this.logs,
    this.hasReachedMax,
  });

  LogSuccess copyWith({
    List<ShowLog> logs,
    bool hasReachedMax,
  }) {
    return LogSuccess(
      logs: logs ?? this.logs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [logs, hasReachedMax];

  @override
  String toString() =>
      'LogSuccess { logs: ${logs.length}, hasReachedMax: $hasReachedMax }';
}

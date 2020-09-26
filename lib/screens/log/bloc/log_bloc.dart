import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_home/models/show_log.dart';
import 'package:smart_home/rest.dart';

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  LogBloc() : super(LogInitial());

  @override
  Stream<LogState> mapEventToState(
    LogEvent event,
  ) async* {
    final currentState = state;
    if (event is LogFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is LogInitial) {
          final posts = await RestNode.getLog('pewangi', 0, 10);
          yield LogSuccess(logs: posts, hasReachedMax: false);
          return;
        }
        if (currentState is LogSuccess) {
          final posts =
              await RestNode.getLog('pewangi', currentState.logs.length, 10);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : LogSuccess(
                  logs: currentState.logs + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield LogFailure();
      }
    }
  }

  bool _hasReachedMax(LogState state) =>
      state is LogSuccess && state.hasReachedMax;
}

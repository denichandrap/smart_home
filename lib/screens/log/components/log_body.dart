import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/screens/log/bloc/log_bloc.dart';
import 'package:smart_home/screens/log/components/post_widget.dart';

import 'bottom_loader.dart';

class LogBody extends StatefulWidget {
  @override
  _LogBodyState createState() => _LogBodyState();
}

class _LogBodyState extends State<LogBody> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  LogBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<LogBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogBloc, LogState>(
      builder: (context, state) {
        if (state is LogInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LogFailure) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is LogSuccess) {
          if (state.logs.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.logs.length
                  ? BottomLoader()
                  : LogWidget(log: state.logs[index]);
            },
            itemCount:
                state.hasReachedMax ? state.logs.length : state.logs.length + 1,
            controller: _scrollController,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(LogFetched());
    }
  }
}

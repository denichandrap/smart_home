import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:smart_home/screens/log/bloc/post_bloc.dart';
import 'package:smart_home/screens/log/components/log_body.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            PostBloc(httpClient: http.Client())..add(PostFetched()),
        child: LogBody(),
      ),
    );
  }
}

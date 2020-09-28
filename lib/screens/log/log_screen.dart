import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/screens/log/bloc/log_bloc.dart';
import 'package:smart_home/screens/log/components/log_body.dart';

class LogScreen extends StatelessWidget {
  final String tabel;

  const LogScreen({Key key, this.tabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) =>
            // PostBloc(httpClient: http.Client())..add(PostFetched()),
            LogBloc(tabel)..add(LogFetched()),
        child: LogBody(),
      ),
    );

    // return Scaffold(
    //   body: ListView(
    //     children: [
    //       // Load a Lottie file from your assets
    //       // Lottie.asset('assets/LottieLogo1.json'),

    //       // Load a Lottie file from a remote url
    //       // Lottie.network(
    //       //     'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),

    //       Lottie.network(
    //           'https://labs.nearpod.com/bodymovin/demo/markus/isometric/markus2.json'),

    //       // Load an animation and its images from a zip file
    //       // Lottie.asset('assets/lottiefiles/angel.zip'),
    //     ],
    //   ),
    // );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/cubit/mesin_cubit.dart';
import 'package:smart_home/screens/home/home_screen.dart';
import 'package:smart_home/share_var.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isconnected = false;
  bool loading;
  String url1;
  String ket;

  Timer timer;
  // StreamSubscription<DataConnectionStatus> listener;

  @override
  void initState() {
    loading = true;
    _start().then((value) => print('Start execute'));

    super.initState();
  }

  // @override
  // void dispose() {
  //   listener.cancel();
  //   super.dispose();
  // }

  Future _start() async {
    //shareVar().clearall();
    await shareVar().getStr('ip').then((String s) => setState(() {
          url1 = s;
          if (s != null) {
            // context.bloc<IpCubit>().setIp(s);
            cekKoneksi();
          } else {
            _showdialog();
          }
        }));
  }

  Future cekKoneksi() async {
    final List<AddressCheckOptions> conn = List.unmodifiable([
      AddressCheckOptions(
        InternetAddress(url1),
        port: 3003,
        timeout: Duration(seconds: 5),
      ),
    ]);

    DataConnectionChecker().addresses = conn;
    isconnected = await DataConnectionChecker().hasConnection;

    print('isi koneksi');
    print(isconnected);
    print('akhir isi koneksi');

    if (isconnected) {
      //  context.bloc<IpCubit>().setIp(url1);
      timer = Timer(
          Duration(seconds: 4),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider<MesinCubit>(
                      create: (context) => MesinCubit(),
                      child: HomeScreen()))));
    } else {
      Timer(Duration(seconds: 2), () => _showdialog());
    }
  }

  void _showdialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return modalChangeIP();
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: size.width,
          height: size.height,
          color: kPrimaryColor,
          child: FutureBuilder<String>(
              future: shareVar().getStr('ip'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return buildColumn(size, '', 'Waiting For Get Data');
                  default:
                    if (snapshot.hasError) {
                      return modalChangeIP();
                      //Text('Error: ${snapshot.error}');
                    } else {
                      if (snapshot.data == null) {
                        return buildColumn(
                            size, snapshot.data, 'Data is empty');
                      } else {
                        return buildColumn(size, snapshot.data,
                            'Testing Connection to ' + snapshot.data);
                      }
                    }
                }
              })),
    );
  }

  AlertDialog modalChangeIP() {
    if (isconnected) {
      timer.cancel();
    }

    TextEditingController ipAddress = new TextEditingController();
    return AlertDialog(
        content: Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Column(children: [
              Text('Change IP'),
              Text(url1 == null ? '' : url1),
              SizedBox(
                height: kDefaultPadding / 3,
              ),
              TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                // onSubmitted: untukSave(),
                decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  labelText: 'IP Address',
                  //  hintText: 'test',
                ),
                controller: ipAddress,
              ),
              SizedBox(
                height: kDefaultPadding / 3,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    shareVar().setStr('ip', ipAddress.text);
                  });
                  Navigator.pop(context);
                  _start();
                },
                child: Text('Save'),
              )
            ])));
  }

  Column buildColumn(Size size, String url, String ket) {
    return Column(
      children: [
        InkWell(
          onDoubleTap: () {
            _showdialog();
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height / 6,
            ),
            child: Image.asset(
              'assets/images/haikids.png',
              height: size.height / 3,
              width: size.width / 3,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: kDefaultPadding,
            ),
            child: loading == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 5,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.amberAccent),
                      ),
                      Text(
                        ket,
                        style: TextStyle(
                            height: 3, fontSize: 15, color: kTextColor),
                      )
                    ],
                  )
                : Text(''),
          ),
        ),
      ],
    );
  }
}

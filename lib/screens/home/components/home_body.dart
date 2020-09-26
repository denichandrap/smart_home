import 'package:flutter/material.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/screens/home/components/home_gabungan.dart';
import 'package:smart_home/screens/home/components/home_list.dart';
import 'package:smart_home/screens/home/components/home_header.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return HomeGabungan();
    return Column(
      children: [
        HomeHeader(),
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        HomeList()
      ],
    );
  }
}

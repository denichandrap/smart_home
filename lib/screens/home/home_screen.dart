import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/screens/home/components/home_body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: DoubleBackToCloseApp(
        child: HomeBody(),
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: Text('Drawer Header'),
      //         decoration: BoxDecoration(
      //           color: kPrimaryColor,
      //         ),
      //       ),
      //       ListTile(
      //         title: Text('Item 1'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //       ListTile(
      //         title: Text('Item 2'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      elevation: 0,
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {
            // Scaffold.of(context).openDrawer();
          },
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/cubit/mesin_cubit.dart';
import 'package:smart_home/models/arduino.dart';
import 'package:smart_home/rest.dart';
import 'package:smart_home/screens/log/log_screen.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: RestNode.getArduino(),
        //  initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Arduino> data = snapshot.data;
            // print(data[1].namaMesin);
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        //print(data[index].namaMesin);
                        context.bloc<MesinCubit>().kirimdata(data[index]);
                        // context
                        //     .bloc<HeaderCubit>()
                        //     .sendData(data[index].namaMesin);
                      },
                      child: buildCard(data, index, context));
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Card buildCard(List<Arduino> data, int index, BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Color.fromRGBO(64, 75, 96, .9),
      child: ListTile(
        focusColor: kPrimaryColor,
        hoverColor: kTextColor,
        title: Text(data[index].namaMesin,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white)),
        subtitle: Text(data[index].tipe, style: TextStyle(color: Colors.white)),
        leading: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              IconData(data[index].icon, fontFamily: 'MaterialIcons'),
              color: kPrimaryColor,
              size: 55,
            ),
            onPressed: () {
              RestNode.runTrigger(
                      data[index].url + new DateTime.now().toIso8601String())
                  .then((result) {
                print(result);
              });
            }),
        trailing: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.arrow_forward_ios,
              color: kPrimaryColor,
              size: 55,
            ),
            onPressed: () {
              // print('open page detail');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LogScreen(tabel: data[index].tabel)),
              );
            }),
      ),
    );
  }

  // ListView buildListView(List<Datum> data) {
  //   return
  // }

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/cubit/mesin_cubit.dart';
import 'package:smart_home/models/arduino.dart';
import 'package:smart_home/models/detail_header.dart';
import 'package:smart_home/rest.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<MesinCubit, Arduino>(builder: (_, state) {
      return Container(
        child: Column(
          children: [
            Opacity(
              opacity: state == null ? 0 : 1,
              child: SizedBox(
                height: state == null ? 0 : size.height / 5,
                width: size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //  color: Colors.lightBlue,
                        width: size.width / 3,
                        height: double.infinity,
                        child: IconButton(
                            icon: Icon(
                              (state != null)
                                  ? IconData(state.icon,
                                      fontFamily: 'MaterialIcons')
                                  : Icons.refresh,
                              size: size.width / 3,
                            ),
                            onPressed: () {
                              print('Header Button Icon');
                              RestNode.runTrigger(state.url +
                                      new DateTime.now().toIso8601String())
                                  .then((result) {
                                print(result);
                              });
                            }),
                      ),
                      Container(
                        //  color: Colors.amber,
                        width: size.width / 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  state == null
                                      ? 'Pewangi Ruangan'
                                      : state.namaMesin,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: (state != null)
                            ? FutureBuilder(
                                future: RestNode.getDetailHeader(state.tabel),
                                //  initialData: InitialData,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    List<DetailHeader> data = snapshot.data;
                                    // print(data[1].);
                                    return builddetail(size, data);
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return CircularProgressIndicator();
                                },
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Container builddetail(Size size, List<DetailHeader> data) {
    return Container(
      // color: Colors.blue,
      // padding: const EdgeInsets.all(16.0),
      width: size.width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            //  color: Colors.white,
            child: Column(
              children: [
                Text('TOTAL COUNT  ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Text(data[0].count.toString(), textAlign: TextAlign.center)
              ],
            ),
          ),
          SizedBox(
            height: kDefaultPadding / 4,
          ),
          Container(
              width: double.infinity,
              //  color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LAST CHANGE  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Text(data[0].dtGantiServer.toString(),
                      textAlign: TextAlign.center),
                ],
              )),
        ],
      ),
    );
  }
}

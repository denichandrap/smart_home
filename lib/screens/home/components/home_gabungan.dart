import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/models/arduino.dart';
import 'package:smart_home/rest.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:smart_home/share_var.dart';

class HomeGabungan extends StatefulWidget {
  @override
  _HomeGabunganState createState() => _HomeGabunganState();
}

class _HomeGabunganState extends State<HomeGabungan> {
  var untukHeader;
  SocketIO socketIO;
  String ipa;
  String url;
  String fullurl = '';
  String url1;
  bool isstart = false;
  @override
  void initState() {
    super.initState();

    shareVar().getStr('ip').then((value) => url = value);
    if (url != null) {
      untukSocket();
    }
  }

  void untukSocket() {
    fullurl = 'http://' + url + ':3003';
    url1 = fullurl + '/insertreq_trigger/app/';

//Creating the socket
    socketIO = SocketIOManager().createSocketIO(
      fullurl,
      '/',
    );
    //Call init before doing anything with socket
    socketIO.init();
    //Subscribe to an event to listen to
    socketIO.subscribe('app', (jsonData) {
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         // Retrieve the text the that user has entered by using the
      //         // TextEditingController.
      //         content: Text(jsonData),
      //       );
      //     });
      // print(jsonData);
      final snackBar = SnackBar(content: Text(jsonData));
      Scaffold.of(context).showSnackBar(snackBar);
    });
    //Connect to the socket
    socketIO.connect();
  }

  final String url2 = 'http://192.168.100.100:3003/insertreq_trigger/app/' +
      new DateTime.now().toIso8601String();
  // String url1 = fullurl +
  //     '/insertreq_trigger/app/' +
  //     new DateTime.now().toIso8601String();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<String>(
        future: shareVar().getStr('ip'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return crContainer();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return buildColumn(size);
              }
          }
        });
  }

  Column buildColumn(Size size) {
    if (!isstart) {
      untukSocket();
      print(url1);
      isstart = true;
    }

    return Column(
      children: [
        GestureDetector(
          child: Column(
            children: [
              Opacity(
                opacity: untukHeader == null ? 0 : 1,
                child: SizedBox(
                  height: untukHeader == null ? 0 : size.height / 5,
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
                        SizedBox(
                            //  width: kDefaultPadding,
                            ),
                        Container(
                          width: size.width / 3,
                          child: IconButton(
                              icon: Icon(
                                Icons.refresh,
                                size: size.width / 3,
                              ),
                              onPressed: () async {
                                print('Header Button Icon');
                                setState(() {
                                  print(url1);
                                  RestNode.runTrigger(url1 +
                                          new DateTime.now().toIso8601String())
                                      .then((result) {
                                    print(result);
                                  });
                                });
                              }),
                        ),
                        SizedBox(
                            //  width: kDefaultPadding,
                            ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: kDefaultPadding,
                                ),
                                Text(
                                  untukHeader == null
                                      ? 'Pewangi\nRuangan'
                                      : untukHeader.namaMesin,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            //  width: kDefaultPadding,
                            ),
                        Container(
                          // padding: const EdgeInsets.all(16.0),
                          width: 0, //size.width / 3,
                          child: Column(
                            children: [
                              SizedBox(
                                height: kDefaultPadding,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('total count : 100',
                                      textAlign: TextAlign.left)
                                ],
                              ),
                              Text('trakhir ganti :',
                                  textAlign: TextAlign.left),
                              Text('2020-08-09\n13:00:00',
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        buildList()
      ],
    );
  }

  Expanded buildList() {
    return Expanded(
      child: FutureBuilder(
        future: RestNode.getArduino(),
        //  initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Arduino> data = snapshot.data;
            // print(data[4].nama);
            return buildListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return crContainer();
        },
      ),
    );
  }

  ListView buildListView(List<Arduino> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  untukHeader = data[index];
                });
                // print(new DateTime.now().toString());
                // final snackBar = SnackBar(
                //     content: Text(new DateTime.now().toIso8601String()));
                // Scaffold.of(context).showSnackBar(snackBar);
                // getdata1(data[index]);
                // print(data[index].nama);
                // senddata(data[index].nama);
                // HomeHeader(data1: data[index].nama);
                // print(data[index].nama);

                // final container = StateContainer.of(context);
                // container.updateUser(name: data[index].nama);
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color.fromRGBO(64, 75, 96, .9),
                child: Container(
                    decoration: BoxDecoration(
                        //   color: Color.fromRGBO(64, 75, 96, .9),
                        //   borderRadius: BorderRadius.circular(15.0)
                        ),
                    child: GestureDetector(
                      child: ListTile(
                        focusColor: kPrimaryColor,
                        hoverColor: kTextColor,
                        title: Text(data[index].namaMesin,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white)),
                        subtitle: Text(
                          data[index].tipe,
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              //   print('object');
                              setState(() {
                                RestNode.runTrigger(url1 +
                                        new DateTime.now().toIso8601String())
                                    .then((result) {
                                  print(result);
                                });
                              });
                            }),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              print('open page detail');
                              shareVar()
                                  .getStr('ip')
                                  .then((value) => ipa = value);
                            }),
                      ),
                    )),
              ));
        });
  }

  Container crContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              // enabled: _enabled,
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (_, __) => Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48.0,
                          height: 48.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 10.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 10.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 40.0,
                                height: 10.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

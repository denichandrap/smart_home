import 'package:flutter/material.dart';
import 'package:smart_home/models/show_log.dart';

class LogWidget extends StatelessWidget {
  final ShowLog log;

  const LogWidget({Key key, @required this.log}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${log.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(log.trigger),
      isThreeLine: true,
      subtitle: Text(log.dtArduino.toString()),
      trailing: Text(log.kodeGrup, style: TextStyle(fontSize: 10.0)),
      dense: true,
    );
  }
}

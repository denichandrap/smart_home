import 'package:flutter/material.dart';
import 'package:smart_home/models/show_log.dart';

class PostWidget extends StatelessWidget {
  final ShowLog post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.kodeGrup),
      isThreeLine: true,
      subtitle: Text(post.trigger),
      dense: true,
    );
  }
}

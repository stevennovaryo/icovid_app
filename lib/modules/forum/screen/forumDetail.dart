import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumDetail extends StatefulWidget {
    const ForumDetail({Key? key}) : super(key: key);

    @override
    State<ForumDetail> createState() => _ForumDetailState();

}

class _ForumDetailState extends State<ForumDetail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('slug'),),
    );
  }
}
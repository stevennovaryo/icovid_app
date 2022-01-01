import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icovid_app/modules/profile/screen/other_user_profile.dart';
import 'package:icovid_app/modules/profile/screen/edit_profile.dart';

class AppBariCovid extends StatefulWidget {
  const AppBariCovid({Key? key}) : super(key: key);

  @override
  _CustomeAppBar createState() => _CustomeAppBar();
}

class _CustomeAppBar extends State<AppBariCovid> {
  @override
  Widget build(BuildContext){
    return AppBar(
      leading: Container(
        child: const Image(image: AssetImage('lib/modules/profile/assets/logo_icovid.png')),
        margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      ),
      title: const Text('iCovid'),
      backgroundColor: Colors.blue.shade300,
      actions: const [
        Icon(
          Icons.list,
        ),
      ],
    );
  }
}

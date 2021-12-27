import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icovid_app/core/routers/router.dart';

class ICovid extends StatelessWidget {
  const ICovid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Splash Screen',
      initialRoute: initialRoutes,
      routes: icovidRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
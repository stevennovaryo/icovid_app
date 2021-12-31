import 'package:flutter/cupertino.dart';
import 'package:icovid_app/modules/auth/screen/login.dart';
import 'package:icovid_app/modules/auth/screen/register.dart';
import 'package:icovid_app/modules/home/screen/home.dart';
import 'package:icovid_app/modules/profile/screen/profile.dart';

String initialRoutes = '/login';

Map<String, Widget Function(BuildContext)> icovidRoutes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) => const MyHomePage(),
  '/profile': (context) => const Profile(),
};
import 'package:flutter/cupertino.dart';
import 'package:icovid_app/modules/auth/screen/login.dart';
import 'package:icovid_app/modules/auth/screen/register.dart';
import 'package:icovid_app/modules/home/screen/home.dart';
import 'package:icovid_app/modules/profile/screen/other_user_profile.dart';
import 'package:icovid_app/modules/profile/screen/profile_edit.dart';
import 'package:icovid_app/modules/tracker/screen/tracker.dart';

String initialRoutes = '/login';

Map<String, Widget Function(BuildContext)> icovidRoutes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) => const MyHomePage(),
  // '/profile': (context) => const Profile(),
  '/profile': (context) => const ProfileScreenEdit(),
  '/otherprofiles': (context) => const OtherUserProfile(),
  '/tracker': (context) => const TrackerScreen(),
};

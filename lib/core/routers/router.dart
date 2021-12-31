import 'package:flutter/cupertino.dart';
import 'package:icovid_app/modules/auth/screen/login.dart';
import 'package:icovid_app/modules/auth/screen/register.dart';
import 'package:icovid_app/modules/forum/screen/forumDetail.dart';
import 'package:icovid_app/modules/forum/screen/newPostForm.dart';
import 'package:icovid_app/modules/home/screen/home.dart';
import 'package:icovid_app/modules/forum/screen/forumHome.dart';

String initialRoutes = '/login';

Map<String, Widget Function(BuildContext)> icovidRoutes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) => const MyHomePage(),
  '/forumHome': (context) => const ForumHome(),
  '/newForum': (context) => const PostFormPage(),
  // '/forum/<str:slug>': (context) => const ForumDetail(),

};

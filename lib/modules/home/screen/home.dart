// TEMPORARY HOME SCREEN
// TODO: ADD REAL HOME SCREEN

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:icovid_app/core/core.dart';
import 'package:icovid_app/modules/auth/widgets/logout_button.dart';
import 'package:icovid_app/modules/profile/screen/profile.dart'; // EXAMPLE OF IMPORTING AUTH LIBRARY

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${networkService.username}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const LogoutButton(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              }, 
              child: const Text("Profile"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
// TEMPORARY HOME SCREEN
// TODO: ADD REAL HOME SCREEN

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:icovid_app/core/core.dart';
import 'package:icovid_app/modules/auth/widgets/logout_button.dart';
import 'package:icovid_app/modules/profile/screen/other_user_profile.dart'; // EXAMPLE OF IMPORTING AUTH LIBRARY
import 'package:flutter/material.dart';
import 'package:icovid_app/core/core.dart';
import 'package:icovid_app/modules/auth/auth.dart';
import 'package:icovid_app/modules/auth/screen/login.dart';
import 'package:icovid_app/modules/home/screen/formfeedback.dart';
import 'package:icovid_app/modules/home/screen/form.dart';
import 'package:icovid_app/modules/home/screen/formulir.dart';
import 'package:icovid_app/modules/home/screen/feedbacklist.dart'; // EXAMPLE OF IMPORTING AUTH LIBRARY
import 'package:icovid_app/modules/auth/services/services.dart';
import 'package:icovid_app/modules/news/home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("iCovid Home"),
            ),

            body:Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            child: Text("iCovid",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Container(
                            color: Colors.grey[100],
                            width: 200,
                            height: 50,
                            child: Text(
                              "iCovid is an app where people can exchange informations and discuss topics about Covid",
                              maxLines: 4,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )),
                      ]),
                  Container(
                      margin: const EdgeInsets.only(top: 30.0, bottom: 15.0),
                      child: Center(
                          child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Home() ;
                    }));
                  },
                  child: Text('Look for latest news'),
                ),)),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 320,
                          height: 100,
                          child: Row(children: [
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                width: 150,
                                height: 100,
                                ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                width: 100,
                                child: Text(
                                  'Virus Corona membuat warga semakin resah',
                                  maxLines: 3,
                                ))
                          ]),
                          //child: new Image.asset('assets/virus.jpg'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 320,
                          height: 100,
                          child: Row(children: [
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                width: 150,
                                height: 100,
                                ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                width: 100,
                                child: Text(
                                  'Data paling update covid di Indonesia',
                                  maxLines: 3,
                                ))
                          ]),
                          //child: new Image.asset('assets/virus.jpg'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 320,
                          height: 100,
                          child: Row(children: [
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                width: 150,
                                height: 100,
                                ),
                            Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                width: 100,
                                child: Text(
                                  'Cara mencegah penyebaran virus corona',
                                  maxLines: 3,
                                ))
                          ]),
                        ),
                        TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyApp() ;
                    }));
                  },
                  child: Text('Leave Us Feedback'),
                ),
            TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyFeedbackPage();
                    }));
                  },
                  child: Text('See feedbacks'),
                ),
                 ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed:(){
                    logout();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    },
                  
                    ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Logout", 
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                )
          
                      ]),
                      
                ]),
              ),
              
            )
            )
            )
            ;

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const LogoutButton(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              }, 
              child: const Text("Your Profile"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/otherprofiles');
              }, 
              child: const Text("See other user profiles!"),
            ), 
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tracker');
              }, 
              child: const Text("Tracker"),
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

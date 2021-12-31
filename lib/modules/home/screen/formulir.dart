import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:icovid_app/modules/home/screen/feedbacklist.dart';
import 'package:icovid_app/modules/home/screen/add_data.dart';
import 'package:icovid_app/modules/home/screen/home.dart';
import 'package:http/http.dart' as http;

Future<void> createFeedback(
    String pengirim, String message, String ratings) async {
  final response = await http.post(
    Uri.parse(
      'https://icovid-id.herokuapp.com/home/add-data',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'pengirim': pengirim,
      'message': message,
      'ratings': ratings
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    // return Feedbackk.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create feedback.');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  Future<Feedbackk>? _futureFeedback;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Feedback Form'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child:
              (_futureFeedback == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Input Sender Name'),
        ),
        TextField(
          controller: _controller2,
          decoration: const InputDecoration(hintText: 'Input Feedback Message'),
        ),
        TextField(
          controller: _controller3,
          decoration: const InputDecoration(hintText: 'Give Ratings (1-5)'),
        ),
        new Padding(padding: new EdgeInsets.only(top: 20.0)),
        ElevatedButton(
          onPressed: () {
            setState(() {
              createFeedback(
                  _controller.text, _controller2.text, _controller3.text);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MyHomePage();
              }));
            });
          },
          child: const Text('Create Data'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyHomePage();
            }));
          },
          child: Text('Back'),
        )
      ],
    );
  }

  FutureBuilder<Feedbackk> buildFutureBuilder() {
    return FutureBuilder<Feedbackk>(
      future: _futureFeedback,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.pengirim);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

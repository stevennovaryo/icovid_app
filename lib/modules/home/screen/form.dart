import 'package:flutter/material.dart';
import 'package:icovid_app/modules/home/screen/home.dart';
import 'package:icovid_app/modules/home/screen/feedbacklist.dart';
import 'package:icovid_app/modules/home/screen/add_data.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);
  _FormState createState() => new _FormState();
}

class _FormState extends State<FormPage> {
  String _ratings = "1";
  late String pengirim;
  late String message;
  late String ratings;

  final formKey = GlobalKey<FormState>();

  // void chooseRate(String value) {
  //   setState(() {
  //     _ratings = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Container(
          padding: new EdgeInsets.all(15.0),
          child: new Column(
            children: <Widget>[
              new Padding(padding: new EdgeInsets.only(top: 40.0)),
              Text("Feedback",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold)),
              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              // new TextField(
              //     decoration: new InputDecoration(
              //         hintText: "Nama Pengirim",
              //         labelText: "Nama Pengirim",
              //         border: new OutlineInputBorder(
              //             borderRadius: new BorderRadius.circular(20.0)))),
              // new Padding(padding: new EdgeInsets.only(top: 20.0)),
              
              TextFormField(validator: (value) {
                
                if (value?.isEmpty ?? true) {
                  return "Please write your name";
                }
                pengirim = value!;
                decoration: const InputDecoration(
                  hintText: "Sender name",
                );
              }),

              TextFormField(
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Please input your feedback";
                  }
                  message = value!;
                },
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Enter the feedback",
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 20.0)),
              new Row(
                children: <Widget>[
                  new Text("Berikan rating untuk aplikasi ini")
                ],
              ),
              new DropdownButton<String>(
                value: _ratings,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _ratings = newValue!;
                    ratings = newValue;
                  });
                },
                items: <String>['1', '2', '3', '4', '5']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              new Padding(padding: new EdgeInsets.only(top: 40.0)),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Feedbackk newFeedback =
                        Feedbackk(pengirim, message, ratings);
                    addNewFeedback(newFeedback).then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          value,
                        ))));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MyHomePage();
                    }));
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.blue)))),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyHomePage();
                  }));
                },
                child: Text('Back'),
              )
            ],
          )),
    );
  }
}

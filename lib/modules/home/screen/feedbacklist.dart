import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyFeedbackPage extends StatefulWidget {
  MyFeedbackPage();

  // final String title;

  @override
  _MyFeedbackPageState createState() => new _MyFeedbackPageState();
}

class _MyFeedbackPageState extends State<MyFeedbackPage> {

  Future<List<Feedbackk>> _getFeedbacks() async {

    var data = await http.get(Uri.parse('https://icovid-id.herokuapp.com/home/get-data/'));

    var jsonData = json.decode(data.body);

    List<Feedbackk> feedbacks = [];

    for(var u in jsonData){

      Feedbackk feedback = Feedbackk(u["pengirim"], u["message"], u["ratings"]);

      feedbacks.add(feedback);

    }

    // print(feedbacks.length);

    return feedbacks;

  }

//   Future<dynamic> register(String username, String password, String repeatPassword) async {
//   Map<String, String> postData = {
//     "username": username,
//     "password1": password,
//     "password2": repeatPassword,
//   };
// }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Feedbacks"),
      ),
      body: Container(
          child: FutureBuilder(
            future: _getFeedbacks(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              print(snapshot.data);
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...")
                  )
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int id) {
                    return ListTile(
                      title: Text(snapshot.data[id].pengirim +" rated "+ snapshot.data[id].ratings+" stars" ),
                      subtitle: Text("feedback : "+snapshot.data[id].message),
                    );
                  },
                );
              }
            },
          ),
        ),
      );
  }
}

class Feedbackk{
  final String pengirim ;
  final String message ;
  final String ratings ;
  late int id ;

  Feedbackk(this.pengirim, this.message, this.ratings);

  // factory Feedbackk.fromJson(Map<String, dynamic> json) {
  //   return Feedbackk(
  //   json['pengirim'],
  //   json['message'],
  //   json['ratings']
  //   );
  // }

  Feedbackk.fromJson(Map<String, dynamic> json)
    : pengirim = json['pengirim'],
      message = json['message'],
      ratings = json['ratings'];
}

// class Feedbackk {
//   final String pengirim ;
//   final String message ;
//   final String ratings ;
//   late int id ;

//   Feedbackk({required this.pengirim, required this.message,required this.ratings});

//   factory Feedbackk.fromJson(Map<String, dynamic> json) {
//     return Feedbackk(
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }
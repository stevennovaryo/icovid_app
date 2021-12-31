import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:icovid_app/modules/home/screen/feedbacklist.dart' ;
import 'package:icovid_app/modules/home/screen/add_data.dart' ;
import 'package:icovid_app/modules/home/screen/home.dart' ;
import 'package:http/http.dart' as http;


// Future<http.Response> updateFeedback(String pengirim,String message, String ratings) {
//   return http.put(
//     Uri.parse('http://127.0.0.1:8000/home/add-data'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'pengirim': pengirim,
//       'message': message,
//       'ratings':ratings
//     }),
//   );
// }

Future<Feedbackk> createFeedback(String pengirim,String message,String ratings) async {
  final response = await http.put(
    Uri.parse('http://10.0.2.2:8000/home/add-data'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'pengirim': pengirim,
      'message':message,
      'ratings':ratings
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Feedbackk.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to add feedback.');
  }
}

class FeedbackForm extends StatefulWidget {
  FeedbackForm({Key? key}) : super(key: key);
  
  final TextEditingController _controller = TextEditingController();
 

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  String _ratings = "1";
  
  late String pengirim;
  late String message;
  late String ratings;

  final formKey = GlobalKey<FormState>();
  Future<Feedbackk>? _futureFeedback;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFFFFFFF),
      title: const Text(
        'Add Feedback',
        textAlign: TextAlign.center,
      ),
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Please write your name";
              }
              pengirim = value!;
            },
            decoration: const InputDecoration(
              hintText: "Sender name",
            ),
            
          ),
          const SizedBox(
            height: 8,
          ),
      
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
                    ratings = newValue ;
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
          const SizedBox(
            height: 20,
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     if (formKey.currentState?.validate() ?? false) {
          //       Feedbackk newFeedback = Feedbackk(
          //         pengirim,message,ratings
          //       );
          //       addNewFeedback(newFeedback).then((value) =>
          //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //               content: Text(
          //             value,
          //           ))));
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return const MyHomePage();
          //       }));
          //     }
          //   },
          //   child: const Text(
          //     "Submit",
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(Colors.blue),
          //       padding: MaterialStateProperty.all<EdgeInsets>(
          //           const EdgeInsets.all(15)),
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //           RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(18.0),
          //               side: const BorderSide(color: Colors.blue)))),
          // ),
          ElevatedButton(
          onPressed: () {
            setState(() {
              _futureFeedback = createFeedback(pengirim,message,ratings);
            });
          },
          child: const Text('Create Data'),
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
        ]),
      ),
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


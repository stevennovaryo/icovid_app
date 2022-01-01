import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InputArticle extends StatefulWidget {
  const InputArticle({Key? key}) : super(key: key);

  @override
  State<InputArticle> createState() => _InputArticleState();
}

class _InputArticleState extends State<InputArticle> {

  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerSummary = TextEditingController();
  TextEditingController controllerBody = TextEditingController();
  TextEditingController controllerImageURL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('iCovid - News'),
          backgroundColor: Colors.blueAccent[100],
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    "Submit an Article",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 20.0)),

                  TextField(
                    controller: controllerTitle,
                    decoration: InputDecoration(
                      labelText: "Article Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 20.0)),

                  TextField(
                    controller: controllerSummary,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: "Summary",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 20.0)),
                  
                  TextField(
                    controller: controllerImageURL,
                    decoration: InputDecoration(
                      labelText: "Image URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 20.0)),

                  TextField(
                    controller: controllerBody,
                    maxLines: 15,
                    decoration: InputDecoration(
                      labelText: "Body",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 8.0)),

                  ElevatedButton(
                    child: const Text(
                      "Submit Article",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () async {
                      await http.post (
                        Uri.parse('https://icovid-id.herokuapp.com/news/post-flutter'),
                        headers: <String, String> {"Content-Type": "application/json;charset=UTF-8"},
                        body: jsonEncode(<String, String> {
                            'title': controllerTitle.text,
                            'postDate': DateTime.now().toString().substring(0, 10),
                            'articleImage': controllerImageURL.text,
                            'body': controllerBody.text,
                            'summary': controllerSummary.text
                          }
                        )
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Article Submited!', textAlign: TextAlign.center),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }  
                  )
                ],
              ),
            ),
          ],
        )
      );
  }
}
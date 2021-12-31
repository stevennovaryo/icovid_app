import 'package:flutter/material.dart';
import 'package:icovid_app/core/core.dart';
import 'package:icovid_app/modules/forum/services/services.dart';
import 'package:icovid_app/modules/home/screen/home.dart';
import 'package:http/http.dart' as http;

class PostFormPage extends StatefulWidget {
  const PostFormPage({Key? key}) : super(key: key);

  @override
  State<PostFormPage> createState() => _PostFormState();
}

class _PostFormState extends State<PostFormPage> {
  String? topic;
  String? description;

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
      appBar: AppBar(title: const Text('Add a new forum'),),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title for your post";
                  }
                  topic = value;
                },
                decoration: const InputDecoration(
                  hintText: "Topic",
                ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                description = value;
              },
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Description",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                      Map<String, dynamic> newPostData = {
                      'username': networkService.username,
                      'topic': topic,
                      'description': description,
                    };
                    // print(newPostData);
                    Navigator.pushNamed(context, '/forumHome');
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    sendNewPost(newPostData);
                  }
                    
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
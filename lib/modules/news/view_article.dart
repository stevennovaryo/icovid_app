import 'package:flutter/material.dart';

class ViewArticle extends StatelessWidget {
  final String title;
  final String summary;
  final String body;
  final String postDate;
  final String imageURL;
  const ViewArticle({Key? key, required this.title, required this.summary, required this.body, required this.postDate, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('iCovid - News'),
          backgroundColor: Colors.blueAccent[100],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 250.0,
              child: Ink.image(
                image: NetworkImage(imageURL),
                fit: BoxFit.fill,
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                alignment: Alignment.centerLeft,
            ),
            ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(postDate),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                alignment: Alignment.centerLeft,
                child: Text(body, textAlign: TextAlign.justify),
            ),
            
          ]
        )
      );
  }

  
}

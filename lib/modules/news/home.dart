import 'package:flutter/material.dart';
import 'input_article.dart';
import 'view_article.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home();
  
  @override
  State<Home> createState() => HomeState();
    
}

class HomeState extends State<Home> {
  
  Future<List<Article>> getArticles() async {

    var data = await http.get(Uri.parse('https://icovid-id.herokuapp.com/news/get-article'));

    var jsonData = json.decode(data.body);

    List<Article> articles = [];

    for(var i in jsonData){

      Article article = Article(i["title"], i["summary"], i["body"], i["postDate"], i["imageURL"]);

      articles.add(article);
      
    }
    
    return List.from(articles.reversed);

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('iCovid - News'),
          backgroundColor: Colors.blueAccent[100],
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(70, 20, 70, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const InputArticle()));
                  },
                  child: const Text(
                      "Submit an Article",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Text(
                  'Latest Post',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),              
              FutureBuilder(
                future: getArticles(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount  : 1,
                      itemBuilder: (BuildContext context, int index) {
                        return buildCard(snapshot.data[index].title, snapshot.data[index].summary, snapshot.data[index].body, snapshot.data[index].postDate, snapshot.data[index].imageURL);
                      },
                    );
                  }
                },
              ),
              const Padding(padding: EdgeInsets.all(30.0)),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'All Posts',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  )
                ),
              ), 
              FutureBuilder(
                future: getArticles(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount  : snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildCard(snapshot.data[index].title, snapshot.data[index].summary, snapshot.data[index].body, snapshot.data[index].postDate, snapshot.data[index].imageURL);
                      },
                    );
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text(
                  'No more posts to show',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );
  }

  Card buildCard(String title, String summary, String body, String date, String imageURL) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          SizedBox(
            height: 200.0,
            child: Ink.image(
              image: NetworkImage(imageURL),
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(date),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              alignment: Alignment.centerLeft,
              child: Text(summary),
          ),
          ButtonBar(
            children: [
              TextButton(
                  child: const Text('Read more'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewArticle(title: title, summary: summary, body: body, postDate: date, imageURL: imageURL)));
                  },
                ),
            ],
          )
        ],
      ),
    );
  }
}

class Article {
  final String title ;
  final String summary ;
  final String body ;
  final String postDate ;
  final String imageURL ;

  Article(this.title, this.summary, this.body, this.postDate, this.imageURL);

  Article.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      summary = json['summary'],
      body = json['body'],
      postDate = json['postDate'],
      imageURL = json['imageURL'];
}
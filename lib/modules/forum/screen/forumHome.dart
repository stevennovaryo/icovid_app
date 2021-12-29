

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumHome extends StatefulWidget {
    const ForumHome({Key? key}) : super(key: key);

    @override
    State<ForumHome> createState() => _ForumHomeState();
}
class _ForumHomeState extends State<ForumHome> {
    @override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text("ICovid - Forum")),
			body: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					thumbify(ForumPost("Greg", "Hai, dunia! 1", "Ngetest", "10-11-2021")),
					thumbify(ForumPost("Or", "Hai, dunia! 2", "Ngetest", "10-11-2021")),
					thumbify(ForumPost("Ius", "Hai, dunia! 3", "Ngetest", "10-11-2021")),
					thumbify(ForumPost("Bhis", "Hai, dunia! 4", "Ngetest", "10-11-2021")),
				],
			),
		);
	}

	Widget thumbify(ForumPost forumPost) {
		return Container(
			padding: const EdgeInsets.all(3.0),
			margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
			decoration: const BoxDecoration(
				color: Colors.grey,
				borderRadius: BorderRadius.all(Radius.circular(15.0)),
			),
			child: ListTile(
			title: Text(forumPost.topic),
			subtitle: Text(forumPost.author),
			leading: const Icon(
				Icons.dashboard,
				color: Colors.grey,
			),
			
			// onTap: () {Navigator.pushNamed(context, '/forum/1');},
			),
		);
	}
}

class ForumPost {
	String author;
	String topic;
	String description;
	String dateCreated;

	ForumPost(this.author, this.topic, this.description, this.dateCreated);
}
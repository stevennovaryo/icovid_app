// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:icovid_app/modules/forum/screen/constants.dart';
import 'package:http/http.dart' as http;

class ForumPost {
	final String author;
	final String topic;
	final String description;
	final String date_created;
	final String slug;

	ForumPost({
		required this.author,
		required this.topic,
		required this.description,
		required this.date_created,
		required this.slug,
	});
}	



Future<List<ForumPost> > fetchForumList() async {
	final response = await http.get(Uri.parse(URL_FORUM_LIST));
	List<ForumPost> listPost = <ForumPost>[];
	if (response.statusCode == 200) {
		try {
			List<dynamic > json = jsonDecode(response.body);
			for (var i = 0; i < json.length; i++) {
				listPost.add(
					ForumPost(
						author: json[i]['author'],
						topic: json[i]['topic'],
						description: json[i]['description'],
						date_created: json[i]['date_created'],
						slug: json[i]['slug'],
					)
				);
			}
			print(listPost);
			return listPost;
		} catch (e) {
			print(e);
		}
		return [];
	}
	else {
		throw Exception("Failed to get Forum List");
	}
}

sendNewPost(newPost) async {
	http.Response response = await http.post(Uri.parse(URL_NEW_FORUM), body: json.encode(newPost));
	print(response.body);
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icovid_app/modules/forum/services/services.dart';
import 'package:icovid_app/modules/forum/widgets/new_forum_button.dart';

class ForumHome extends StatefulWidget {
    const ForumHome({Key? key}) : super(key: key);

    @override
    State<ForumHome> createState() => _ForumHomeState();
}
class _ForumHomeState extends State<ForumHome> {
  List<ForumPost> _forumList = List.empty();
  List<Widget> _forumThumbList = List.empty();
  

  Future _getForumList() async {
    dynamic response = await fetchForumList();
    List<ForumPost> _tmp_list = response;
    List <Widget> _tmp = [];
    for (var i = 0; i < _tmp_list.length; i++) {
      _tmp.add(thumbify(_tmp_list[i]));
    }
    setState(() {
      _forumList = _tmp_list;
      _forumThumbList =_tmp;
      _forumThumbList.add(const NewForumButton());
    });
  }

  @override
  void initState() {
    super.initState();

    _getForumList();
  }

  @override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text("ICovid - Forum")),
			body: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: 
        // [
				// 	thumbify(ForumPost(author: "Greg", topic: "Hai, dunia! 1", description: "Ngetest", date_created: "10-11-2021", sl"hai-1" )),
				// 	thumbify(ForumPost("Or", "Hai, dunia! 2", "Ngetest", "10-11-2021", "hai-2")),
				// 	thumbify(ForumPost("Ius", "Hai, dunia! 3", "Ngetest", "10-11-2021")),
				// 	thumbify(ForumPost("Bhis", "Hai, dunia! 4", "Ngetest", "10-11-2021")),
				// ]
        _forumThumbList
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
			
			// onTap: () {Navigator.pushNamed(context, '/forum/' + forumPost.slug);},
			),
		);
	}
}
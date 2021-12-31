import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:icovid_app/modules/home/screen/feedbacklist.dart' ;

Future<dynamic> addNewFeedback(Feedbackk feedbackData) async {
  var url = Uri.parse(
      'https://icovid-id.herokuapp.com/home/add-data');
  var response = await http.post(url,
      headers: {
        "Access-Control_Allow_Origin": "*",
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode(feedbackData));
  return jsonDecode(response.body);
}

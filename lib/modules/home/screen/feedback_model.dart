import 'dart:convert' ;
import 'package:http/http.dart' as http ;

class Feedbackk{
  late String pengirim ;
  late String message ;
  late String ratings ;

  Feedbackk({
    required this.pengirim, required this.message, required this.ratings
  });

  factory Feedbackk.createFeedback(Map<String,dynamic> object){
    return Feedbackk(
      pengirim : object['pengirim'],
      message : object['message'],
      ratings : object['ratings']
    );
  }

  static Future<Feedbackk> connectoAPI() async {
    String apiUrl = 'http://127.0.0.1:8000/home/get-data/' ;
    
    var apiResult = await http.get(Uri.parse(apiUrl));
    var  jsonObject = json.decode(apiResult.body);
    var feedbackData = (jsonObject as Map<String,dynamic>)['fields'];
    
    return Feedbackk.createFeedback(feedbackData) ;


    


  }
}

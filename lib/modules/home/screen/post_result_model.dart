import 'package:http/http.dart' as http ;

class FeedbackResult
{
  late String pengirim ;
  late String message ;
  late String ratings ;
  late String created_at ;
  late String user_id ;

  FeedbackResult({
    required this.pengirim,
    required this.message,
    required this.ratings,
    required this.created_at,
    required this.user_id
  });

  // ignore: empty_constructor_bodies
  factory FeedbackResult.createFeedbackResult(Map<String,dynamic> object){
    return FeedbackResult(
      created_at: object['created_at'],
      pengirim :object['pengirim'],
      user_id :object['user_id'],
      ratings : object['ratings'],
      message : object['message']
      );
  }

}

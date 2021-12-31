import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:icovid_app/core/services/request.dart';
import 'package:icovid_app/modules/profile/screen/constants.dart';

class DataProfile {
  final String name;
  final String email;
  final String phone;
  final String city;
  final String bio;
  final String hs;
  final String vs;

  DataProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    required this.bio,
    required this.hs,
    required this.vs,
  });
}

// fetch Profile JSON
Future<List<dynamic>> fetchProfile() async {
  final response = await http.get(Uri.parse(PROFILE_JSON_URL));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> profileData = jsonDecode(response.body);
    return profileData;
  } else {
    throw Exception('Failed to load your profile');
  }
}

// Future<dynamic> postProfile(String nameUser, String emailUser, String phoneUser, 
//     String cityUser, String bioUser, String hsUser, String vsUser) async {
//   Map<String, String> postData = {
//     "username": networkService.username,
//     "nameUser": nameUser,
//     "emailUser": emailUser,
//     "phoneUser": phoneUser,
//     "cityUser": cityUser,
//     "bioUser": bioUser,
//     "hsUser": hsUser,
//     "vsUser": vsUser,
//   };

//   return await networkService.csrfProtectedPost(PROFILE_PAGE_URL, postData, null);
// }

Future<DataProfile> getProfile() async {
  Map<String, String> postData = {
    "username": networkService.username,
    "name": networkService.name,
    "email": networkService.email,
    "phone": networkService.phone,
    "city": networkService.city,
    "status": networkService.hs,
    "vaccinated_status": networkService.vs,
  };

  return await networkService.csrfProtectedPost(PROFILE_GET_URL, postData, null);
}
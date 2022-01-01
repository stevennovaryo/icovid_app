import 'package:icovid_app/core/services/request.dart';
import 'package:icovid_app/modules/auth/screen/constants.dart';

Future<dynamic> login(String username, String password) async {
  Map<String, String> postData = {
    "username": username,
    "password": password,
  };

  return await networkService.csrfProtectedPost(LOGIN_URL, postData, null);
}

Future<dynamic> register(String username, String password, String repeatPassword) async {
  Map<String, String> postData = {
    "username": username,
    "password1": password,
    "password2": repeatPassword,
  };

  return await networkService.csrfProtectedPost(REGISTER_URL, postData, null);
}

void logout() {
  networkService.cookies = <String, String>{};
  networkService.headers.removeWhere((key, value) => key == 'X-CSRFToken');
}

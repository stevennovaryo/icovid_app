// taken from https://stackoverflow.com/a/68398885
// TODO 
// 1. Add base url to networkservice class
// 2. Tidying up the codes 
// 3. CSRF token issue
//   as many of the backend's form uses csrf token, make dummy request to https://icovid-id.herokuapp.com/home/ for csrf token
//   add this to every request header
//     X-CSRFToken: <csrf-token>
//   still dunno what will happen if csrf token expired tho
//   first measurement
//   - if request returns 403, then update csrf token and try again (or maybe even session cookies)
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:icovid_app/core/services/constants.dart';

class NetworkService {
  final JsonDecoder _decoder = const JsonDecoder();
  final JsonEncoder _encoder = const JsonEncoder();

  Map<String, String> headers = {"content-type": "application/json"};
  Map<String, String> cookies = {};
  String username = "";

  void _updateCookie(http.Response response) {
    if (response.headers['content-type'] == 'text/html') return;

    String? allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');
      
      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
    }
  }

  void _setCookie(String? rawCookie) {
    if (rawCookie != null) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;
        if (key == 'csrftoken') headers['X-CSRFToken'] = value;
        cookies[key] = value;
      }
    }
  }

  void checkStatusCode(String url, int statusCode) {
    if (statusCode == 403) throw Exception("Forbidden");
    if (statusCode == 500) throw Exception("Internal server error");
    if (statusCode < 200 || statusCode > 400) throw Exception("GET $url: Error while fetching data");
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.isNotEmpty) cookie += ";";
      cookie += key + "=" + cookies[key]!;
    }

    return cookie;
  }

  Future<dynamic> updateCSRF() {
    return http.get(Uri.parse("$BACKEND_HOST/home"), headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      // print(res);

      _updateCookie(response);
      checkStatusCode("$BACKEND_HOST/home", statusCode);
      return null;
    });
  }


  Future<dynamic> get(String url) {
    return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);
      checkStatusCode(url, statusCode);
      return {'status': statusCode, 'data': _decoder.convert(res)};
    });
  }

  Future<dynamic> post(String url, Map<String, String> body, dynamic encoding) {
    return http.post(Uri.parse(url), body: _encoder.convert(body), headers: headers, encoding: encoding).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);
      checkStatusCode(url, statusCode);
      return {'status': statusCode, 'data': _decoder.convert(res)};
    });
  }

  Future<dynamic> csrfProtectedPost(String url, Map<String, String> body, dynamic encoding) async {
    try {
      return await networkService.post(url, body, null);
    } catch (e) {
      if (e.toString() == "Exception: Forbidden") {
        await networkService.updateCSRF();
        return await networkService.post(url, body, null);
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> put(String url, {body, encoding}) {
    return http.put(Uri.parse(url), body: _encoder.convert(body), headers: headers, encoding: encoding).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);
      checkStatusCode(url, statusCode);
      return {'status': statusCode, 'data': _decoder.convert(res)};
    });
  }
}

dynamic networkService = NetworkService();

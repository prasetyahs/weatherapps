import 'dart:convert';
import '../../utilities/env.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const _baseUrl = Env.API_URL;
  static Future<http.Response> post(url, body, {headers}) {
    return http.post(Uri.parse("$_baseUrl$url"),
        body: jsonEncode(body), headers: headers);
  }

  static Future<http.Response> get(url, {headers}) {
    return http.get(Uri.parse("$_baseUrl$url"), headers: headers);
  }

  static Future<http.Response> put(url, {headers, body}) {
    return http.put(Uri.parse("$_baseUrl$url"),
        headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> delete(url, {headers}) {
    return http.delete(Uri.parse("$_baseUrl$url"), headers: headers);
  }
}

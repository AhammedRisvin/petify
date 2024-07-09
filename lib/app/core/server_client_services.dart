import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'string_const.dart';

class ServerClient {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const int _timeout = 180;

  /// Get request

  static Future<List> get(String url) async {
    String? token = await _storage.read(key: StringConst.token);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "country": "india",
      "appId": "6626011bd97238113acb1105",
      "authorization": "Bearer $token",
    };
    log("token  $token");
    log("url  $url");
    try {
      var response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: _timeout));

      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Post request

  static Future<List> post(
    String url, {
    Map<String, dynamic>? data,
    bool post = true,
  }) async {
    String? token = await _storage.read(key: StringConst.token);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "country": "india",
      "appId": "6626011bd97238113acb1105",
      "authorization": "Bearer $token",
    };
    log("token  $token");
    log("url  $url");
    log("data  $data");
    try {
      var body = json.encode(data);
      var response = await http
          .post(Uri.parse(url), body: post ? body : null, headers: headers)
          .timeout(const Duration(seconds: _timeout));

      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Put request

  static Future<List> put(
    String url, {
    Map<String, dynamic>? data,
    bool put = false,
  }) async {
    String? token = await _storage.read(key: StringConst.token);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "country": "india",
      "appId": "6626011bd97238113acb1105",
      "authorization": "Bearer $token",
    };
    try {
      String? body = json.encode(data);
      var response = await http
          .put(Uri.parse(url),
              headers: headers, body: put == false ? null : body)
          .timeout(const Duration(seconds: _timeout));
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Delete request

  static Future<List> delete(
    String url, {
    bool delete = false,
    String? id,
    Map<String, dynamic>? data,
  }) async {
    String? token = await _storage.read(key: StringConst.token);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "appId": "6626011bd97238113acb1105",
      "authorization": "Bearer $token",
    };
    String? body = json.encode(data);
    var response = await http.delete(Uri.parse(url),
        headers: headers, body: delete == false ? null : body);
    return await _response(response);
  }

  // ------------------- ERROR HANDLING ------------------- \\

  static Future<List> _response(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return [response.statusCode, jsonDecode(response.body)];
      case 201:
        return [response.statusCode, jsonDecode(response.body)];
      case 400:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 401:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 403:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 404:
        return [
          response.statusCode,
          jsonDecode(response.body)["message"] ?? "Not found"
        ];
      case 500:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 503:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 504:
        return [
          response.statusCode,
          {"message": "Request timeout", "code": 504, "status": "Cancelled"}
        ];
      default:
        return [response.statusCode, jsonDecode(response.body)["message"]];
    }
  }
}

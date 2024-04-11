import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  final String appBaseUrl;

  static const String connectionIssue = 'Connection failed!';
  final int timeoutInseconds = 30;

  ApiService({required this.appBaseUrl});

  Future<Response> getPublic(String uri) async {
    try {
      http.Response response = await http.get(
        Uri.parse(appBaseUrl + uri),
      ).timeout(Duration(seconds: timeoutInseconds));
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> postPublic(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(appBaseUrl + uri),
        headers: {'Content-Type': "application/json"},
        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutInseconds));
      return parseResponse(response, appBaseUrl + uri);
    } catch (e) {
      return const Response(
        statusCode: 1,
        statusText: connectionIssue,
      );
    }
  }

  Response parseResponse(http.Response res, String uri) {
    dynamic body;

    try {
      body = jsonDecode(res.body);
    } catch (e) {
      e;
    }

    Response response = Response(
      body: body != '' ? body : res.body,
      bodyString: res.body.toString(),
      headers: res.headers,
      statusCode: res.statusCode,
      statusText: res.reasonPhrase,
    );

    if(response.statusCode != 200 && response.body != null && response.body is! String ) {
      if(response.body.toString().startsWith('{error: [{code:')) {
        response = Response(
          statusCode: response.statusCode,
          body: response.body,
          statusText: 'error',
        );
      } else if (response.body.toString().startsWith('{message')) {
        response = Response(
          statusCode: response.statusCode,
          body: response.body,
          statusText: response.body['message'],
        );
      }
    } else if (response.statusCode != 200 && response.body == null) {
      response = const Response(
        statusCode: 0,
        statusText: connectionIssue,
      );
    }
    return response;
  }

  Future<Response> postPrivate(String uri, dynamic body, String token) async {
    try {
      http.Response response = await http.post(Uri.parse(appBaseUrl + uri),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }).timeout(Duration(seconds: timeoutInseconds));
      return parseResponse(response, uri);
    }  catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }


}
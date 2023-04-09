import 'dart:convert';
import 'package:billy_app/constants.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  var client = http.Client();

// GET
  Future<dynamic> get(String api) async {
    var url = Uri.parse(apiURL+api);
    var headers = {'content-type': 'application/json'};
    final res = Res(0, {});
    try {
      var response = await client.get(url, headers: headers);
      res.statusCode = response.statusCode;
      res.body = jsonDecode(response.body);
      return res;
    } catch (error) {
      res.error = error.toString();
      print(error); // ignore: avoid_print
      return res;
    }
  }

// POST
  Future<Res> post(String api, dynamic obgect) async {
    print(apiURL);// ignore: avoid_print
    var url = Uri.parse(apiURL+api);
    var body = json.encode(obgect);
    var headers = {'content-type': 'application/json'};
    final res = Res(0, {});
    try {
      final response = await client.post(url, body: body, headers: headers);
      res.statusCode = response.statusCode;
      res.body = jsonDecode(response.body);
      return res;
    } catch (error) {
      res.error = error.toString();
      print(error); // ignore: avoid_print
      return res;
    }
  }

// PUT
  Future<Res> put(String api, dynamic obgect) async {
    var url = Uri.parse(apiURL + api);
    var body = json.encode(obgect);
    var headers = {'content-type': 'application/json'};
    final res = Res(0, {});
    try {
      var response = await client.post(url, body: body, headers: headers);
      res.statusCode = response.statusCode;
      res.body = jsonDecode(response.body);
      return res;
    } catch (error) {
      res.error = error.toString();
      print(error); // ignore: avoid_print
      return res;
    }
  }

// DELETE
  Future<dynamic> delete(String api, dynamic obgect) async {
    var url = Uri.parse(apiURL + api);
    var body = json.encode(obgect);
    var headers = {'content-type': 'application/json'};
    final res = Res(0, {});
    try {
      var response = await client.post(url, body: body, headers: headers);
      res.statusCode = response.statusCode;
      res.body = jsonDecode(response.body);
      return res;
    } catch (error) {
      res.error = error.toString();
      print(error); // ignore: avoid_print
      return res;
    }
  }
}

class Res {
  late int statusCode;
  late Map body;
  late Object message = "null";
  late String error = "null";
  late String accessToken = "null";

  Res(this.statusCode, this.body);

  String strBody() {
    return body.toString();
  }

  String strMessage() {
    return message.toString() != "null"
        ? message.toString()
        : "An error occurred. Please try again later";
  }
}

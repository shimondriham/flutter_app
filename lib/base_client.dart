import 'dart:convert';
import 'package:billy_app/providers/token_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BaseClient {
  final client = http.Client();
  String apiURL = dotenv.env['API_URL'].toString();
// GET
  Future<Res> get(String api, context) async {
    var url = Uri.parse(apiURL + api);
    var token = Provider.of<Token>(context, listen: false).token;
    var headers = {'content-type': 'application/json'};
    if (token != "") {
      headers = {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json'
      };
    }
    final res = Res();
    try {
      var response = await client.get(url, headers: headers);
      res.statusCode = response.statusCode;
      if (response.statusCode == 200) {
        final listBody = jsonDecode(response.body);
        Map<String, dynamic> mapBody = {
          "body": listBody,
        };
        res.body = mapBody;
      }
       else {
        res.body = jsonDecode(response.body);
      }
      return res;
    } catch (error) {
      res.error = error.toString();
      print(error); // ignore: avoid_print
      return res;
    }
  }

// POST
  Future<Res> post(String api, dynamic obgect, dynamic context) async {
    final token = Provider.of<Token>(context, listen: false).token;
    var headers = {'content-type': 'application/json'};
    if (token != "") {
      headers = {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json'
      };
    }    
    var url = Uri.parse(apiURL + api);
    var body = json.encode(obgect);
    final res = Res();
    try {
      final response = await client.post(url, body: body, headers: headers);
      print(response.statusCode);// ignore: avoid_print
      print(response.body);// ignore: avoid_print
      res.statusCode = response.statusCode;
      res.body = jsonDecode(response.body);
      // print(res.body["\$metadata"]);// ignore: avoid_print
      return res;
    } catch (error) {
      res.error = error.toString();
      print(error); // ignore: avoid_print
      return res;
    }
  }

// PUT
  Future<Res> put(String api, dynamic obgect, context) async {
    var url = Uri.parse(apiURL + api);
    var body = json.encode(obgect);
    var token = Provider.of<Token>(context, listen: false).token;
    var headers = {
      'Authorization': 'Bearer $token',
      'content-type': 'application/json'
    };
    final res = Res();
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
  Future<dynamic> delete(String api, dynamic obgect, context) async {
    var url = Uri.parse(apiURL + api);
    var body = json.encode(obgect);
    var token = Provider.of<Token>(context, listen: false).token;
    var headers = {
      'Authorization': 'Bearer $token',
      'content-type': 'application/json'
    };
    final res = Res();
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
  late int statusCode = 0;
  late Map body = {};
  late Object message = "null";
  late String error = "null";
  late String accessToken = "null";

  Res();

  String strBody() {
    return body.toString();
  }

  String strMessage() {
    return message.toString() != "null"
        ? message.toString()
        : "An error occurred. Please try again later";
  }
}

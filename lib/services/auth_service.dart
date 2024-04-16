
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCy0LLbGe3X_cAMAzV6-jVaEaPD9QEWpd0';

  Future<String?> createrUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password' : password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key' : _firebaseToken

    });


    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decoderResp = json.decode(resp.body);

    print(decoderResp);
  }
}
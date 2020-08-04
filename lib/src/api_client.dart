import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';

class ApiClient {
  static final _baseUrl = "http://192.168.1.2:8888";
  static final http.Client httpClient = http.Client();

  static Future<http.Response> register({
    @required String username,
    @required String password,
  }) async {
    return httpClient.post(_baseUrl + "/register",
        headers: {
          "Authorization":
              'Basic ' + base64Encode(utf8.encode('com.grafa.dart_notes:abcd')),
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }));
  }

  static Future<http.Response> login({
    @required String username,
    @required String password,
  }) async {
    return httpClient.post(_baseUrl + "/auth/token",
        headers: {
          "Authorization":
              'Basic ' + base64Encode(utf8.encode('com.grafa.dart_notes:abcd')),
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: "username=$username&password=$password&grant_type=password");
  }

  static Future<http.Response> get({
    @required String endpoint,
    @required User user,
  }) {
    return httpClient.get(_baseUrl + endpoint, headers: {
      "Authorization": "Bearer ${user.authorization['access_token']}"
    });
  }

  static Future<http.Response> post({
    @required String endpoint,
    @required User user,
    @required Map<String, dynamic> body,
  }) {
    return httpClient.post(_baseUrl + endpoint,
        headers: {
          "Authorization": "Bearer ${user.authorization['access_token']}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body));
  }

  static Future<http.Response> delete({
    @required String endpoint,
    @required User user,
  }) {
    return httpClient.delete(
      _baseUrl + endpoint,
      headers: {
        "Authorization": "Bearer ${user.authorization['access_token']}"
      },
    );
  }

  static Future<http.Response> put({
    @required String endpoint,
    @required User user,
    @required dynamic body,
  }) {
    return httpClient.put(
      _baseUrl + endpoint,
      headers: {
        "Authorization": "Bearer ${user.authorization['access_token']}"
      },
      body: body,
    );
  }
}

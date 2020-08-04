import 'dart:convert';


import '../api_client.dart';
import '../models/user.dart';
import '../storage.dart';

class AuthService {
  static Future<User> registerUser({String username, String password}) async {
    final response =
        await ApiClient.register(username: username, password: password);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = User(
        username: data['username'],
        authorization: {
          "access_token": data['authorization']['access_token'],
          "token_type": data['authorization']['token_type'],
          "expires_in": data['authorization']['expires_in'],
          "refresh_token": data['authorization']['refresh_token'],
        },
        isOffline: false,
      );
      return user;
    } else {
      return null;
    }
  }

  static Future<User> loginUser({String username, String password}) async {
    final result =
        await ApiClient.login(username: username, password: password);
    if (result.statusCode == 200) {
      final data = jsonDecode(result.body);
      return User(
        username: username,
        authorization: {
          "access_token": data['access_token'],
          "token_type": data['token_type'],
          "expires_in": data['expires_in'],
          "refresh_token": data['refresh_token'],
        },
        isOffline: false,
      );
    } else {
      return null;
    }
  }

  static Future<void> logoutUser() async {
    return deleteUserFromStorage();
  }

  static Future<User> logOffline() async {
    return User(
      username: "Anonymous",
      authorization: {},
      isOffline: true,
    );
  }
}

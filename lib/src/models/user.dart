class User {
  final String username;
  final Map<String, dynamic> authorization;
  final bool isOffline;

  const User({this.username, this.authorization, this.isOffline});

  @override
  String toString() {
    return '{"username":"$username","authorization":{"access_token":"${authorization['access_token']}","token_type":"${authorization['token_type']}","expires_in":${authorization['expires_in']},"refresh_token":"${authorization['refresh_token']}"}, "is_offline": $isOffline}';
  }
}

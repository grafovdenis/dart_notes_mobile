import '../models/user.dart';
import '../storage.dart';

class UserRepository {
  Future<User> getUser() {
    return getUserFromStorage();
  }

  Future<void> deleteUser() {
    return deleteUserFromStorage();
  }
}

import 'package:hive/hive.dart';
import 'package:tennis_court/core/shared/models/user_model.dart';

class UserLocalDataSource {
  final Box<UserModel> userBox;

  UserLocalDataSource(this.userBox);

  Future<void> saveUser(UserModel user) async {
    await userBox.put(user.email, user);
  }

  Future<UserModel?> getUser(String email) async {
    return userBox.get(email);
  }

  Future<void> saveLoggedInUser(UserModel user) async {
    await userBox.put('logged_in_user', user);
  }

  Future<UserModel?> getLoggedInUser() async {
    return userBox.get('logged_in_user');
  }

  Future<void> clearUser() async {
    await userBox.delete('logged_in_user');
  }
}

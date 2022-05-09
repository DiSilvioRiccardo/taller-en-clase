import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/random_user.dart';
import '../repositories/user_repository.dart';

// this file handles the business logic, calling the corresponding repository
class Authentication {
  UserRepository repository = Get.find();

  Future<bool> get init async => await repository.init();

  Future<void> addUser(email, password) async =>
      await repository.addUser(User(email: email, password: password));

  // if login is ok then data is stored on shared prefs
  Future<bool> login(storeUser, email, password) async {
    List<User> allUsers = await repository.getAllUsers();
  
    if (allUsers.where((element) => element.email == email && element.password == password).isNotEmpty){
        if (storeUser){
          if (await repository.isStoringUser()){
            await repository.clearStoredUser();
          }
          repository.storeUserInfo(User(email: email, password: password));
        }
        return true;
    }
    return false;
  }

  Future<void> signup(user, password) async {
    await repository.signup(User(email: user, password: password));
  }

  Future<void> logout() async {
    await repository.logout();
  }

  Future<User> getStoredUser() async {
    return await repository.getStoredUser().onError((error, stackTrace) {
      return User(email: "", password: "");
    });
  }

  Future<void> clearStoredUser() async {
    return await repository.clearStoredUser();
  }

  clearAll() async {
    await repository.clearAll();
  }

  Future<bool> isStoringUser() async {
    return repository.isStoringUser();
  }
}

import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/repository/authentication/authentication_repository.dart';
import 'package:do_thi_thong_minh/repository/users/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  // var myUser = UserModel(

  // ).obs;

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUser(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepo.getAllUsers();
  }

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }
}

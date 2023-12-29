import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:do_thi_thong_minh/controller/reflect_controller.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/repository/authentication/authentication_repository.dart';
import 'package:do_thi_thong_minh/repository/users/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final repass = TextEditingController();

  final userRepository = Get.put(UserRepository());
  final controller = Get.put(ReflectController());

  // đăng ký tài khoản với authentication
  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  // tạo tài khoản với Firebase FireStore
  Future<void> createUser (UserModel user) async {
    await userRepository.createUser(user);
  }

}
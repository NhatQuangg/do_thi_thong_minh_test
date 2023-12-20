import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/repository/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // tạo đối tượng FireStore để tương tác vs csdl
  final _db = FirebaseFirestore.instance;

  // chứa thông tin người dùng hiện tại
  late final Rx<User?> firebaseUser;

  // tạo đối tượng authenticaion
  final _authRepository = Get.put(AuthenticationRepository());

  // tạo user mới trong Firebase Firestore
  createUser(UserModel user) async {
    // lấy địa chỉ email user hiện tại
    final email = _authRepository.firebaseUser.value?.email;
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
        "Success", "Tài khoản của bạn đã được tạo.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green))
        .catchError((error, StackTrace) {
      Get.snackbar("Error", "Có 1 vài lỗi. Vui lòng thử lại!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  // Future<void> createUser(UserModel user) async {
  //   // Kiểm tra xem địa chỉ email đã tồn tại trong Firestore chưa
  //   final emailExists = await _checkEmailExists(user.email);
  //
  //   if (!emailExists) {
  //     // Email chưa tồn tại, tiến hành tạo người dùng mới
  //     await _db
  //         .collection("Users")
  //         .add(user.toJson())
  //         .whenComplete(() => Get.snackbar(
  //             "Success", "Tài khoản của bạn đã được tạo.",
  //             snackPosition: SnackPosition.BOTTOM,
  //             backgroundColor: Colors.green.withOpacity(0.1),
  //             colorText: Colors.green))
  //         .catchError((error, StackTrace) {
  //       Get.snackbar("Error", "Something went wrong. Try again",
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.redAccent.withOpacity(0.1),
  //           colorText: Colors.red);
  //       print(error.toString());
  //     });
  //   } else {
  //     // Email đã tồn tại, hiển thị thông báo lỗi
  //     Get.snackbar(
  //       "Error", "Email đã được sử dụng. Vui lòng chọn email khác.",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.redAccent.withOpacity(0.1),
  //         colorText: Colors.red
  //     );
  //   }
  // }

  Future<bool> _checkEmailExists(String? email) async {
    final result =
    await _db.collection("Users").where("Email", isEqualTo: email).get();

    return result.docs.isNotEmpty;
  }

// createUserDetail(UserModel user) async {
//   await _db.collection("Users").doc(user.email).set({
//     "FullName": user.fullName,
//     "Email": user.email,
//     "Phone": user.phoneNo,
//     "Password": user.password,
//     "Level": user.level
//   });
// }

  Future<UserModel> getUser(String email) async {
    final snapshot =
    await _db.collection("Users").where("Email", isEqualTo: email).get();

    // chuyển đổi dữ liệu từ querysnapshot -> ds các UserModel
    // .single để lấy ra đối tượng duy nhất từ ds
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _db.collection("Users").get();
    final userData =
    snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }
}

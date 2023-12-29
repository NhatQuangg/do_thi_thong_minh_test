import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_thi_thong_minh/constants/global.dart';
import 'package:do_thi_thong_minh/model/reflect_model.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/repository/authentication/authentication_repository.dart';
import 'package:do_thi_thong_minh/repository/reflects/reflect_repository.dart';
import 'package:do_thi_thong_minh/repository/users/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class ReflectController extends GetxController {
  static ReflectController get instance => Get.find();
  final idUser = TextEditingController();
  final email = TextEditingController();

  final title = TextEditingController();
  final EmailAuthProvider = TextEditingController();

  final category = TextEditingController();
  final content = TextEditingController();
  final address = TextEditingController();
  final media = TextEditingController();
  final createdAt = TextEditingController();

  final RefreshController refreshController = RefreshController();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());


  ReflectModel? reflect;

  List<ReflectModel> refl = [];

  final _reflectRepo = Get.put(ReflectRepository());

  @override
  void onInit() async {
    super.onInit();
    print("REFRESH");
    await onRefresh();
  }

  Future<void> onRefresh() async {
    await getAllReflect().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError(() {
      refreshController.loadFailed();
    });
  }

  loadAllData() async {
    try {
      var from_reflext = await FirebaseFirestore.instance
          .collection("Reflect")
          .orderBy("CreatedAt", descending: true)
          .get();
      refl;
    } catch (e) {
      print(e);
    }
  }

  Future<void> createReflect(ReflectModel reflect) async {
    await _reflectRepo.createReflect(reflect);
  }

  Future<List<ReflectModel>> getAllReflect() async {
    return await _reflectRepo.allReflect();
  }

  Future<List<ReflectModel>> getProcessedReflect() async {
    return await _reflectRepo.getReflect(0);
  }

  Future<List<ReflectModel>> getProcessingReflect() async {
    return await _reflectRepo.getReflect(1);
  }


  Future<List<ReflectModel>> getAllReflectUser() async {
    final email = _authRepo.firebaseUser.value?.email;
    print("EMAIL == $email");

    return await _reflectRepo.allReflectUser(email!);
  }

  Future<List<ReflectModel>> getProcessedReflectUser() async {
    final email = _authRepo.firebaseUser.value?.email;
    print("EMAIL == $email");

    return await _reflectRepo.getReflectUser(email!, 0);
  }

  Future<List<ReflectModel>> getProcessingReflectUser() async {
    final email = _authRepo.firebaseUser.value?.email;
    print("EMAIL == $email");

    return await _reflectRepo.getReflectUser(email!, 1);
  }

  Future<List<ReflectModel>> getAllReflecHandle2() async {
    return await _reflectRepo.allReflectActive(2);
  }

  static Future updateRef(ReflectModel reflect) async {
    final reflectCollection = FirebaseFirestore.instance.collection("Reflects");

    final docRef = reflectCollection.doc(reflect.id);

    final newReflect = ReflectModel(
        email: reflect.email,
        title: reflect.title,
        category: reflect.category,
        content: reflect.content,
        address: reflect.address,
        media: reflect.media,
        handle: reflect.handle,
        createdAt: reflect.createdAt,
    ).toJson();

    try {
      await docRef.update(newReflect);
    } catch (e) {
      print("some error $e");
    }
  }

}

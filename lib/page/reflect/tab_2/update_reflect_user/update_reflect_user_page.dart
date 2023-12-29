import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_thi_thong_minh/constants/global.dart';
import 'package:do_thi_thong_minh/controller/profile_controller.dart';
import 'package:do_thi_thong_minh/controller/reflect_controller.dart';
import 'package:do_thi_thong_minh/model/reflect_model.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/constants/icon_text.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';



class UpdateReflectUserPage extends StatefulWidget {
  const UpdateReflectUserPage({super.key, required this.reflect});
  final ReflectModel reflect;

  @override
  State<UpdateReflectUserPage> createState() => _UpdateReflectUserPageState();
}

class _UpdateReflectUserPageState extends State<UpdateReflectUserPage> {
  ProfileController profileController = Get.find<ProfileController>();

  final controllerUser = Get.put(ProfileController());
  final controller = Get.put(ReflectController());

  // List<File> listFile = [];

  String? authorName, title, desc;

  QuerySnapshot? refSnapshot;
  bool _isloading = false;
  bool accept = false;
  String? url;
  // File? image;
  // List<String> urls = [];
  // List<String> video_urls = [];
  List<String> listCategory = ['An toàn giao thông', 'Hạ tầng đô thị', 'Giao thông, trật tự đô thị'];
  String? selectNameCategogy;
  String urls = 'https://th.bing.com/th/id/R.6af6fd9c37f0de4abb34ea0fd20acce3?rik=55mqMmrTutVR0Q&pid=ImgRaw&r=0';
  String? u;
  String slectedFileName = "";
  String defaultImageUrl = 'https://th.bing.com/th/id/R.ed4c5c82883ef4309eb02f8e2417646c?rik=L7mq4JeVSZO0Gw&riu=http%3a%2f%2fradiusblocks.com%2fwp-content%2fuploads%2f2022%2f09%2fimage-grid_3.jpg&ehk=lsdi%2bBpjRQvuIvmtlegfvmYOtqp0reJX%2baon5vAL4F4%3d&risl=&pid=ImgRaw&r=0';

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseaApp = await Firebase.initializeApp();
    return firebaseaApp;
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết phản ánh",
          style: TextStyle(color: Colors.white, fontSize: 19),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                await ReflectController.updateRef(
                  ReflectModel(
                    email: getEmail(),
                    title: controller.title.text.trim(),
                    category: selectNameCategogy,
                    content: controller.content.text.trim(),
                    address: controller.address.text.trim(),
                    media: controller.media.text.trim(),
                    handle: 1,
                    createdAt: Timestamp.now(),
                    id: widget.reflect.id,
                  )
                ).then((value) {
                  AnimatedSnackBar.material(
                    "Đăng phản ánh thành công!",
                    type: AnimatedSnackBarType.success,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    // duration: Duration(milliseconds: 1),
                  ).show(context);
                  controller.title.text = '';
                  controller.content.text = '';
                  controller.address.text = '';
                });
              },
              icon: Icon(
                Icons.accessibility_new,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Form(
              // key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: Colors.grey)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Transform.translate(
                              offset: Offset(-10, 0),
                              child: Text(
                                selectNameCategogy ?? listCategory[0],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black
                                ),
                              ),
                            ),
                            items: listCategory.map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Transform.translate(
                                offset: Offset(-10, 0),
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 14,),
                                ),
                              ),
                            )).toList(),
                            value: selectNameCategogy,
                            onChanged: (value) {
                              setState(() {
                                selectNameCategogy = value as String?;
                                if (value == listCategory[0]) {
                                  selectNameCategogy = listCategory[0];
                                }
                                if (value == listCategory[1]) {
                                  selectNameCategogy = listCategory[1];
                                }
                                if (value == listCategory[2]) {
                                  selectNameCategogy = listCategory[2];
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 15.0, right: 15.0, bottom: 0.0),
                    child: TextFormField(
                      controller: controller.title,
                      obscureText: false,
                      maxLines: 2,
                      decoration: InputDecoration(
                          labelText: "Nhập tiêu đề phản ánh...",
                          labelStyle: TextStyle(
                            color: Color(0xff888888),
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBorderColor, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBorderColor, width: 1.0)),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: controller.content,
                      obscureText: false,
                      maxLines: 12,
                      decoration: InputDecoration(
                          labelText: "Nhập nội dung phản ánh...",
                          labelStyle: TextStyle(
                            color: Color(0xff888888),
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBorderColor, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBorderColor, width: 1.0)),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                    child: TextFormField(
                      controller: controller.address,
                      obscureText: false,
                      maxLines: 2,
                      decoration: InputDecoration(
                          labelText: "Nhập địa chỉ...",
                          labelStyle: TextStyle(
                            color: Color(0xff888888),
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                          ),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBorderColor, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kBorderColor, width: 1.0)),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

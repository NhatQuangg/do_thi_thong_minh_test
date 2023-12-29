import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/controller/signup_controller.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/page/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    String levelUser = '1';

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đăng ký",
          style: TextStyle(color: Colors.white),
          // textAlign: TextAlign.center,
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Họ và tên",
                    labelStyle: TextStyle(
                      color: Color(0xff888888),
                      fontSize: 15,
                      //fontWeight: FontWeight.bold,
                    ),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)
                    ),
                  ),
                  controller: controller.fullName,
                  obscureText: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: controller.email,
                  obscureText: false,
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Color(0xff888888),
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: controller.phoneNo,
                  obscureText: false,
                  decoration: InputDecoration(
                      labelText: "Số điện thoại",
                      labelStyle: TextStyle(
                        color: Color(0xff888888),
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0)
                      )
                    // controller: ,
                    // validator: ,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: controller.password,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Mật khẩu",
                      labelStyle: TextStyle(
                        color: Color(0xff888888),
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)
                      )
                    // controller: ,
                    // validator: ,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: controller.repass,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Nhập lại mật khẩu",
                      labelStyle: TextStyle(
                        color: Color(0xff888888),
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0)
                      )
                    // controller: ,
                    // validator: ,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Bạn đã có tài khoản?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        style: TextButton.styleFrom(),
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                      onPressed: () async {
                        if (controller.email.text.trim() == null || controller.email.text.trim() == "") {
                          AnimatedSnackBar.material(
                            'Vui lòng nhập email!',
                            type: AnimatedSnackBarType.error,
                            mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                          ).show(context);
                          print("not login");
                        } else if (controller.password.text.trim() == null || controller.password.text.trim() == "") {
                          AnimatedSnackBar.material(
                            'Vui lòng nhập mật khẩu!',
                            type: AnimatedSnackBarType.error,
                            mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                          ).show(context);
                        } else if (controller.repass.text != controller.password.text.trim() ||
                            controller.repass.text == "") {
                          AnimatedSnackBar.material(
                            'Nhập lại mật khẩu không chính xác!',
                            type: AnimatedSnackBarType.error,
                            mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                          ).show(context);
                        }
                        else {
                          SignUpController.instance.registerUser(
                              controller.email.text.trim(),
                              controller.password.text.trim()
                          );
                          final user = UserModel(
                            fullName: controller.fullName.text.trim(),
                            email: controller.email.text.trim(),
                            phoneNo: controller.phoneNo.text.trim(),
                            password: controller.password.text.trim(),
                            level: levelUser,
                          );
                          await SignUpController.instance.createUser(user).then((value) {
                            AnimatedSnackBar.material(
                              'Đăng ký thành công',
                              type: AnimatedSnackBarType.success,
                              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                            ).show(context);
                            controller.fullName.text = "";
                            controller.email.text = "";
                            controller.phoneNo.text = "";
                            controller.password.text = "";
                            controller.repass.text = "";
                          });
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                      ),
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

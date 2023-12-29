import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/page/home/home_page.dart';
import 'package:do_thi_thong_minh/page/signup/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool changeColor = false;

  // sfinal controller = Get.put(SignUpController());
  // final _formKey = GlobalKey<FormState>();

  // khởi tạo firebase. Trả về 1 đối tượng FirebaseApp
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseaApp = await Firebase.initializeApp();
    return firebaseaApp;
  }

  // định nghĩa 1 phương thức tĩnh static
  static Future<User?> loginUsingEmailPassword(
      {required String email,
        required String password,
        required BuildContext context}) async {
    // tạo đối tượng auth để thực hiện việc xác thực
    FirebaseAuth auth = FirebaseAuth.instance;
    // khởi tạo biến kiểu User
    User? user;
    try {
      // sử dụng phương thức signInWithEmailAndPassword để đăng nhập bằng email + pass
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Đăng nhập",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: kPrimaryColor,
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
                      child: TextFormField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                            labelText: "Email / Số điện thoại",
                            labelStyle: TextStyle(
                              color: Color(0xff888888),
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0
                                )
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
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
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Bạn chưa có tài khoản?'),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()),
                                );
                              },
                              style: TextButton.styleFrom(),
                              child: Text(
                                'Đăng ký',
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
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                            onPressed: () async {
                              print('Email: ${emailController.text}');
                              print('Email: ${passwordController.text}');
                              if (emailController.text == null || emailController.text == "") {
                                AnimatedSnackBar.material(
                                    "Vui lòng nhập email!",
                                    type: AnimatedSnackBarType.error,
                                    mobileSnackBarPosition: MobileSnackBarPosition.bottom
                                ).show(context);
                              } else
                              if (passwordController.text == null || passwordController.text == "") {
                                AnimatedSnackBar.material(
                                    'Vui lòng nhập mật khẩu!',
                                    type: AnimatedSnackBarType.error,
                                    mobileSnackBarPosition: MobileSnackBarPosition.bottom
                                ).show(context);
                              }
                              else {
                                User? user = await
                                loginUsingEmailPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context
                                );
                                print(user);
                                if (user != null) {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                      builder: (context) => HomePage()
                                  )
                                  );
                                }
                                else {
                                  AnimatedSnackBar.material(
                                      'Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại',
                                      type: AnimatedSnackBarType.error,
                                      mobileSnackBarPosition: MobileSnackBarPosition.bottom
                                  ).show(context);
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                            ),
                            child: Text(
                              'Đăng nhập',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/firebase_options.dart';
import 'package:do_thi_thong_minh/page/home/home_page.dart';
import 'package:do_thi_thong_minh/page/login/login_page.dart';
import 'package:do_thi_thong_minh/page/reflect/reflect_page.dart';
import 'package:do_thi_thong_minh/page/signup/signup_page.dart';
import 'package:do_thi_thong_minh/repository/authentication/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phản ánh đô thị 3',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        // brightness: Brightness.light,
        // primaryColor: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: const ReflectScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/page/login/login_page.dart';
import 'package:do_thi_thong_minh/page/profile/profile_page.dart';
import 'package:do_thi_thong_minh/page/reflect/reflect_page.dart';
import 'package:do_thi_thong_minh/repository/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeBottomNavbar extends StatelessWidget {
  const HomeBottomNavbar({
    super.key,
  });
  // final AuthenticationRepository _authRepository = AuthenticationRepository.instance;
  void logout() {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginScreen());
  }
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 55,
      // notchMargin: 5.0,
      shape: CircularNotchedRectangle(),
      color: kPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  )
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: logout,
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0, top: 0.0, bottom: 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Xử lý khi nút được nhấn
            },
            child: Padding(
              padding:
              const EdgeInsets.only(left: 30.0, top: 0.0, bottom: 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  )
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

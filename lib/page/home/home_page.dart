import 'dart:io';

import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/controller/home_controller.dart';
import 'package:do_thi_thong_minh/page/home/components/home_body.dart';
import 'package:do_thi_thong_minh/page/home/components/home_bottom_navbar.dart';
import 'package:do_thi_thong_minh/page/home/components/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final controllerCarouselSlider = Get.put(HomeController());
    return Scaffold(
      body: HomeBody(controllerCarouselSlider: controllerCarouselSlider),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRCodeScanner(),
              )
          );
        },
        child: Icon(
          Icons.qr_code_2,
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        // elevation: 0,
        shape: CircleBorder(),
      ),
      bottomNavigationBar: HomeBottomNavbar(),
    );
  }
}

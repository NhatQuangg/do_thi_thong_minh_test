import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/page/home/home_page.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_2/all_reflect_user/all_reflect_user_page.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_2/individual_screen.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_1/all_reflect/all_reflect_page.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_1/processed_reflect/processed_reflect_page.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_1/processing_reflect/processing_reflect_page.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_2/processed_reflect_user/processed_reflect_user_page.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_2/processing_reflect_user/processing_reflect_user_page.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({super.key});

  @override
  State<IndividualScreen> createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Phản ánh hiện trường",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 19),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Material(
              child: Container(
                height: 50,
                color: Colors.white,
                child: TabBar(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                  unselectedLabelColor: kBorderColor,
                  labelColor: kPrimaryColor,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // color: kPrimaryColor
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: kPrimaryColor, width: 1)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Toàn bộ'),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: kPrimaryColor, width: 1)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Đã xử lý'),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: kPrimaryColor, width: 1)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Đang xử lý'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllReflectUserPage(),
                  ProcessedReflectUserPage(),
                  ProcessingReflectUserPage()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

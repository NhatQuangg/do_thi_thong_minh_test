import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/constants/global.dart';
import 'package:do_thi_thong_minh/constants/icon_text.dart';
import 'package:do_thi_thong_minh/controller/profile_controller.dart';
import 'package:do_thi_thong_minh/controller/reflect_controller.dart';
import 'package:do_thi_thong_minh/model/reflect_model.dart';
import 'package:do_thi_thong_minh/page/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  final controller = Get.put(ReflectController());
  final controllerProfile = Get.put(ProfileController());
  List<dynamic> dataList = [];

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 0, top: 15.0, right: 5.0, bottom: 5.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(170, 35),
                      backgroundColor: kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      side: BorderSide(
                        color: kPrimaryColor,
                        width: 0.5,
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Tìm kiếm',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 5.0, top: 15.0, right: 0.0, bottom: 5.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(170, 35),
                      backgroundColor: kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      side: BorderSide(
                        color: kPrimaryColor,
                        width: 0.5,
                      ),
                      // shadowColor: Colors.grey,
                      // elevation: 2
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.menu_outlined,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Danh mục',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 0.0, top: 10.0, right: 5.0, bottom: 0.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(110, 35),
                      // backgroundColor: kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      side: BorderSide(
                        color: kPrimaryColor,
                        width: 0.5,
                      ),
                      // shadowColor: Colors.grey,
                      // elevation: 2
                    ),
                    onPressed: () {},
                    child: Text(
                      'Toàn bộ',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 5.0, top: 10.0, right: 5.0, bottom: 0.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(110, 35),
                      // backgroundColor: kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      side: BorderSide(
                        color: kPrimaryColor,
                        width: 0.5,
                      ),
                      // shadowColor: Colors.grey,
                      // elevation: 2
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => IndividualScreen(),
                      //     )
                      // );
                    },
                    child: Text(
                      'Đã xử lý',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 5.0, top: 10.0, right: 0.0, bottom: 0.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(115, 35),
                      // backgroundColor: kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      side: BorderSide(
                        color: kPrimaryColor,
                        width: 0.5,
                      ),
                      // shadowColor: Colors.grey,
                      // elevation: 2
                    ),
                    onPressed: () {},
                    child: Text(
                      'Đang xử lý',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.all(12),
                child: FutureBuilder<List<ReflectModel>>(
                  future: controller.getAllReflect(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime date = DateTime.parse(snapshot.data![index].createdAt!
                                .toDate()
                                .toString()
                            );
                            String formatedDate = DateFormat.yMd().format(date);
                            int? handle = snapshot.data![index].handle;
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Slidable(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 125,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 6,
                                          color: Color(0x34000000),
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEEEEEE),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.network(
                                                '${snapshot.data![index].media}'
                                              ).image,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Color(0xFF656565),
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(12, 8, 0, 0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width / 1.7,
                                                child: Text(
                                                  '${snapshot.data![index].title}',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(12, 5, 0, 0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width / 1.7,
                                                height: 50,
                                                child: Text(
                                                  '${snapshot.data![index].content}',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              //padding: EdgeInsets.all(0),
                                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width / 1.7,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    iconAndText(
                                                        textStyle: TextStyle(
                                                            fontSize: 12
                                                        ),
                                                        size: 12,
                                                        title: '${snapshot.data![index].category}',
                                                        icon: Icons.bookmark),
                                                    iconAndText(
                                                        textStyle: TextStyle(
                                                            fontSize: 12
                                                        ),
                                                        size: 12,
                                                        title: formatedDate,
                                                        icon: Icons.calendar_month
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 2,),
                                            Padding(
                                              //padding: EdgeInsets.all(0),
                                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width / 1.7,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    if (handle == 1)
                                                      Text(
                                                        'Đang xử lý',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.red
                                                        ),
                                                      )
                                                    else
                                                      Text(
                                                        'Đã xử lý',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.blue
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: Text("Something went wrong"),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

import 'package:do_thi_thong_minh/controller/profile_controller.dart';
import 'package:do_thi_thong_minh/controller/reflect_controller.dart';
import 'package:do_thi_thong_minh/model/reflect_model.dart';
import 'package:do_thi_thong_minh/page/reflect/detail_reflect/detail_reflect_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_thi_thong_minh/constants/icon_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class AllReflectPage extends StatefulWidget {
  const AllReflectPage({super.key});

  @override
  State<AllReflectPage> createState() => _AllReflectPageState();
}

class _AllReflectPageState extends State<AllReflectPage> {
  final controller = Get.put(ReflectController());
  final controllerProfile = Get.put(ProfileController());
  List<dynamic> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailReflectPage(
                                                reflect: snapshot.data![index],
                                              )),
                                    ).then((value) {
                                      setState(() {});
                                    });
                                  },
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
                                                    else if (handle == 0)
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

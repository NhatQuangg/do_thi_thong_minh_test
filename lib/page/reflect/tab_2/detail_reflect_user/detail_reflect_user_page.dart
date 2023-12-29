import 'package:do_thi_thong_minh/constants/constant.dart';
import 'package:do_thi_thong_minh/controller/profile_controller.dart';
import 'package:do_thi_thong_minh/model/reflect_model.dart';
import 'package:do_thi_thong_minh/model/user_model.dart';
import 'package:do_thi_thong_minh/page/reflect/reflect_page.dart';
import 'package:do_thi_thong_minh/page/reflect/tab_2/update_reflect_user/update_reflect_user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:do_thi_thong_minh/constants/icon_text.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';

class DetailReflectUserPage extends StatefulWidget {
  const DetailReflectUserPage({super.key, required this.reflect});
  final ReflectModel reflect;

  @override
  State<DetailReflectUserPage> createState() => _DetailReflectUserPageState();
}

class _DetailReflectUserPageState extends State<DetailReflectUserPage> {
  ProfileController profileController = Get.find<ProfileController>();
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
      ),
      body: FutureBuilder(
          future: profileController.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel user = snapshot.data as UserModel;
                // final email = TextEditingController(text: user.email);
                // final password = TextEditingController(text: user.password);
                // final fullName = TextEditingController(text: user.fullName);
                // final phoneNo = TextEditingController(text: user.phoneNo);
                // final id = TextEditingController(text: user.id);
                // final level = TextEditingController(text: user.level);
                // String idUser = id.text;
                // String nameUser = fullName.text;
                // String mailUser = email.text;
                // String levelUser = level.text;
                DateTime date = DateTime.parse(widget.reflect.createdAt!.toDate().toString());
                String formatedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);

                // print("USERPROFILE == $email $idUser $fullName $phoneNo $levelUser");
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                      const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                iconAndText(
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Colors.green
                                  ),
                                  title: widget.reflect.category!,
                                  icon: Icons.menu,
                                ),
                                widget.reflect.handle == 1
                                    ? Text(
                                    "Đang xử lý",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.red
                                    )
                                )
                                    : widget.reflect.handle == 0
                                    ? Text(
                                    "Đã xử lý",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green
                                    )
                                )
                                    : Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.red
                                    )
                                ),
                              ]
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "${widget.reflect.title}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.map),
                              SizedBox(width: 10),
                              Expanded(
                                child: widget.reflect.address == ''
                                    ? Text(
                                  'B301',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                )
                                    : Text(
                                  '${widget.reflect.address}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  maxLines: 5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.calendar_month,),
                              SizedBox(width: 10,),
                              Text(
                                  formatedDate,
                                  style: TextStyle(
                                    fontSize: 16,
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          widget.reflect.media!.length == 0
                              ? SizedBox()
                              : Image.network(widget.reflect.media!),
                          SizedBox(height: 10,),
                          Container(
                            child: Text(
                              "${widget.reflect.content}",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
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
          }),
    );
  }
}

import 'package:clone_facebook/day1/stl/custom_text_field.dart';
import 'package:clone_facebook/day2/stl/custom_line.dart';
import 'package:clone_facebook/module/user_app.dart';
import 'package:clone_facebook/provider/auth_provider.dart';

import 'package:clone_facebook/service.dart/snackbar_service.dart';
import 'package:clone_facebook/theme/app_color.dart';
import 'package:clone_facebook/theme/app_style.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SettingProfile extends StatefulWidget {
  const SettingProfile({Key? key}) : super(key: key);

  @override
  _SettingProfileState createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
  late double _sizeH;
  late double _sizeW;
  late AuthencationProvider _auth;
  bool isActive = false;
  TextEditingController text = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    text.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sizeH = MediaQuery.of(context).size.height;
    _sizeW = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
        body: isActive
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColor.kBackgruondTwo.withOpacity(.0),
                    leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                    centerTitle: true,
                    title: const Text(
                      "Chỉnh sửa trang cá nhân",
                      style: AppStyle.h5,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const CustomLine(),
                              customAppbarWidget(
                                "Tiểu Sử",
                                TextButton(
                                  onPressed: () =>
                                      show(context, "Viết tiểu sử cửa bạn",
                                          () async {
                                    Navigator.pop(context);
                                    setState(() {
                                      isActive = true;
                                    });

                                    if (text.text.isNotEmpty) {
                                      String res =
                                          await _auth.updateBio(bio: text.text);

                                      text.clear();

                                      showSnackBar(res, context, true);

                                      setState(() {
                                        isActive = false;
                                      });
                                    } else {
                                      showSnackBar("Bạn chưa nhập gì cả",
                                          context, false);
                                    }

                                    setState(() {
                                      isActive = false;
                                    });
                                  }),
                                  child: const Text("Thêm"),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Mô tả bản thân...",
                                  style:
                                      AppStyle.h5.copyWith(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const CustomLine(),
                              const SizedBox(
                                height: 10,
                              ),
                              customAppbarWidget(
                                "Chi Tiết",
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(""),
                                ),
                              ),
                              customItem(
                                "Đến từ",
                                Icons.location_on,
                                () => show(
                                  context,
                                  "Đến từ",
                                  () async {
                                    Navigator.pop(context);
                                    setState(() {
                                      isActive = true;
                                    });

                                    if (text.text.isNotEmpty) {
                                      String res = await _auth.updateLocation(
                                          location: text.text);

                                      showSnackBar(res, context, true);

                                      text.clear();

                                      setState(() {
                                        isActive = false;
                                      });
                                    } else {
                                      showSnackBar("Bạn chưa nhập gì cả",
                                          context, false);
                                    }

                                    setState(() {
                                      isActive = false;
                                    });
                                  },
                                ),
                              ),
                              customItem(
                                "Sống tại",
                                Icons.home,
                                () => show(
                                  context,
                                  "Sống tại",
                                  () async {
                                    Navigator.pop(context);
                                    setState(() {
                                      isActive = true;
                                    });

                                    if (text.text.isNotEmpty) {
                                      String res = await _auth.updateLiving(
                                          living: text.text);

                                      text.clear();

                                      showSnackBar(res, context, true);

                                      setState(() {
                                        isActive = false;
                                      });
                                    } else {
                                      showSnackBar("Bạn chưa nhập gì cả",
                                          context, false);
                                    }

                                    setState(() {
                                      isActive = false;
                                    });
                                  },
                                ),
                              ),
                              customItem("Trạng thái", Icons.favorite,
                                  () => showStatus(context)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }

  Widget customAppbarWidget(String text, TextButton text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyle.h5,
        ),
        text2,
      ],
    );
  }

  Widget customItem(String text, IconData icon, Function() func) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 5,
        ),
        Text(text),
        const Spacer(),
        IconButton(onPressed: func, icon: const Icon(Icons.note_alt_outlined)),
      ],
    );
  }

  Future show(BuildContext context, String title, Function() func) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: _sizeH * 0.2,
          width: _sizeW,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: func,
                child: const Text(
                  " Thêm ",
                ),
              ),
              CustomTextField(
                isCheck: false,
                text: title,
                controller: text,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showStatus(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: Status.values.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                Navigator.pop(context);
                setState(() {
                  isActive = true;
                });

                List<String> items = Status.values[index].toString().split(".");

                String res = await _auth.updateStatus(status: items[1]);

                showSnackBar(res, context, true);

                setState(
                  () {
                    isActive = false;
                  },
                );
              },
              child: Card(
                elevation: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    convert(
                      Status.values[index],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String convert(Status status) {
    String total = "";
    switch (status) {
      case Status.singel:
        total = "Độc thân";
        break;
      case Status.dating:
        total = "hẹn hò";
        break;
      case Status.research:
        total = "Đang tìm hiểu";
        break;
      case Status.engaged:
        total = "Đã đính hôn";
        break;
      case Status.married:
        total = "Đã Cưới";
        break;
      case Status.widow:
        total = "Goá";
        break;
      case Status.complicated:
        total = "Mối quan hệ phức tạp";
        break;
      case Status.unknown:
        total = "";
        break;
    }
    return total;
  }
}

import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clone_facebook/day1/stl/custom_button.dart';

import 'package:clone_facebook/day2/stl/custom_icon.dart';
import 'package:clone_facebook/day2/stl/custom_line.dart';
import 'package:clone_facebook/day2/stf/pick_avatar.dart';
import 'package:clone_facebook/day2/stl/update_infomation.dart';
import 'package:clone_facebook/module/user_app.dart';
import 'package:clone_facebook/provider/auth_provider.dart';
import 'package:clone_facebook/service.dart/pick_image.dart';
import 'package:clone_facebook/theme/app_color.dart';
import 'package:clone_facebook/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late double _sizeH;
  late double _sizeW;
  late AuthencationProvider _auth;

  bool isActive = false;

  Uint8List? file;

  _selectImage(BuildContext context, bool check) async {
    return showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: const Text("Change Avatar"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("take a photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List fileCamera = await pickImage(ImageSource.camera);
                if (fileCamera.isNotEmpty) {
                  setState(() {
                    file = fileCamera;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PickAvatar(
                        file: file!,
                        check: check,
                      ),
                    ),
                  );
                }
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("take a libary"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List fileGallery = await pickImage(ImageSource.gallery);
                if (fileGallery.isNotEmpty) {
                  setState(() {
                    file = fileGallery;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PickAvatar(
                        file: file!,
                        check: check,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
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
                  title: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        _auth.user.name ?? "",
                        textStyle: AppStyle.h4.copyWith(color: Colors.black),
                      )
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      profileHeader(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            customText(Icons.home, " Đến từ ",
                                _auth.user.living ?? "Error!!"),
                            const SizedBox(
                              height: 10,
                            ),
                            customText(Icons.location_on, " Sống tại ",
                                _auth.user.from ?? "Error!!"),
                            const SizedBox(
                              height: 10,
                            ),
                            customText(
                              Icons.favorite,
                              " ",
                              convert(_auth.user.status ?? Status.unknown),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            customText(
                              Icons.keyboard_control_rounded,
                              " Xem giới thiệu thông tin về bạn.",
                              "",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const CustomLine(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
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

  Widget customText(IconData icon, String text1, String text2) {
    return Row(
      children: [
        Icon(icon),
        Text.rich(
          TextSpan(
            text: text1,
            children: [
              TextSpan(
                text: text2,
                style: AppStyle.h5,
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox profileHeader() {
    return SizedBox(
      height: _sizeH * 0.45,
      width: _sizeW,
      child: Stack(
        children: [
          Positioned(
            child: SizedBox(
              height: _sizeH * 0.2,
              width: _sizeW,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        _auth.user.backgruond ?? _auth.backgruond,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CustomIcon(func: () async {
                        await _selectImage(context, false);
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: _sizeH * 0.33,
              width: _sizeW,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              NetworkImage(_auth.user.avatar ?? _auth.avatar),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CustomIcon(func: () async {
                          await _selectImage(context, true);
                        }),
                      ),
                    ],
                  ),
                  Text(
                    _auth.user.name ?? "ERROR",
                    style: AppStyle.h4.copyWith(color: Colors.black),
                  ),
                  if (_auth.user.bio != "")
                    Row(
                      children: [
                        const Spacer(),
                        Text(_auth.user.bio ?? ""),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.note_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  CustomButton(
                    sizeW: _sizeW * 0.9,
                    sizeH: _sizeH * 0.9,
                    func: () {},
                    isCheck: true,
                    color: AppColor.firstMainColor,
                    title: "Thêm vào tin",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UpdateInfomation(
                          sizeH: _sizeH,
                          sizeW: _sizeW,
                        ),
                        SizedBox(
                          height: _sizeH * 0.05,
                          width: _sizeW * 0.13,
                          child: Card(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(
                                Icons.keyboard_control_rounded,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomLine(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

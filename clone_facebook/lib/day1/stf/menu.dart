import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clone_facebook/day2/stf/profile.dart';
import 'package:clone_facebook/provider/auth_provider.dart';
import 'package:clone_facebook/theme/app_color.dart';
import 'package:clone_facebook/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late AuthencationProvider _auth;
  late double _sizeH;
  late double _sizeW;
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthencationProvider>(context);
    _sizeH = MediaQuery.of(context).size.height;
    _sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.kBackgruondTwo.withOpacity(.3),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: AppColor.kBackgruondTwo.withOpacity(.0),
            title: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  "Menu",
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 50,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              _auth.user.avatar ?? _auth.avatar,
                              scale: 1),
                        ),
                        title: Text(
                          _auth.user.name ?? "",
                          style: AppStyle.h5,
                        ),
                        subtitle: const Text("Xem trang cá nhân của bạn."),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 600,
                ),
                InkWell(
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: _sizeH * 0.06,
                    width: _sizeW,
                    child: Card(
                      color: AppColor.kBackgruondTwo.withOpacity(.6),
                      elevation: 50,
                      child: const Center(
                        child: Text(
                          "Đăng xuất",
                          style: AppStyle.h5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

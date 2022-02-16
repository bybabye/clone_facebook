import 'package:clone_facebook/day1/stf/create_accout_page.dart';
import 'package:clone_facebook/day1/stf/home_page.dart';
import 'package:clone_facebook/day1/stl/animation_custom.dart';
import 'package:clone_facebook/day1/stl/custom_button.dart';
import 'package:clone_facebook/day1/stl/custom_text_field.dart';
import 'package:clone_facebook/provider/auth_provider.dart';
import 'package:clone_facebook/theme/app_assets.dart';
import 'package:clone_facebook/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late AuthencationProvider _auth;
  bool isCheck = false;
  late double _sizeH;
  late double _sizeW;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _email.addListener(() {});
    _password.addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sizeH = MediaQuery.of(context).size.height;
    _sizeW = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.kBackgruond,
      body: _isActive
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SizedBox(
                height: _sizeH,
                width: _sizeW,
                child: AnimationCustom(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: _sizeH * 0.3,
                        width: _sizeW,
                        child: Image.asset(
                          AppAssets.bgface,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: _sizeH * 0.05,
                      ),
                      CustomTextField(
                        controller: _email,
                        isCheck: false,
                        text: "Email",
                      ),
                      SizedBox(
                        height: _sizeH * 0.01,
                      ),
                      CustomTextField(
                        controller: _password,
                        isCheck: true,
                        text: "Password",
                      ),
                      SizedBox(
                        height: _sizeH * 0.05,
                      ),
                      CustomButton(
                        sizeW: _sizeW,
                        sizeH: _sizeH,
                        title: "LOGIN",
                        func: () async {
                          setState(() {
                            _isActive = true;
                          });
                          if (_email.text.isNotEmpty &&
                              _password.text.isNotEmpty) {
                            String res = await _auth.loginUser(
                              email: _email.text,
                              pass: _password.text,
                            );

                            if (res == 'success') {
                              setState(() {
                                _isActive = false;
                              });
                              _auth.check = true;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            }
                          }
                          setState(() {
                            _isActive = false;
                          });
                        },
                        isCheck: (_email.text.isNotEmpty &&
                            _password.text.isNotEmpty),
                        color: AppColor.firstMainColor,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Quên mật khẩu?"),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: _sizeW * 0.25,
                            color: Colors.black54,
                          ),
                          const Text(" HOẶC "),
                          Container(
                            height: 1,
                            width: _sizeW * 0.25,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textColor: AppColor.firstMainColor,
                          color: Colors.blue[100],
                          minWidth: _sizeW,
                          height: _sizeH * 0.06,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CreateAccoutPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Tạo tài khoản mới",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

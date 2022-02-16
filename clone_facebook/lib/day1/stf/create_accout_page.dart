import 'package:clone_facebook/day1/stl/animation_custom.dart';
import 'package:clone_facebook/day1/stl/custom_button.dart';
import 'package:clone_facebook/day1/stl/custom_text_field.dart';
import 'package:clone_facebook/provider/auth_provider.dart';
import 'package:clone_facebook/service.dart/snackbar_service.dart';
import 'package:clone_facebook/theme/app_assets.dart';
import 'package:clone_facebook/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccoutPage extends StatefulWidget {
  const CreateAccoutPage({Key? key}) : super(key: key);

  @override
  _CreateAccoutPageState createState() => _CreateAccoutPageState();
}

class _CreateAccoutPageState extends State<CreateAccoutPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _number = TextEditingController();
  late double _sizeH;
  late double _sizeW;
  late AuthencationProvider _auth;
  bool _isCheck = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sizeH = MediaQuery.of(context).size.height;
    _sizeW = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.kBackgruond,
      body: _isCheck
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: AnimationCustom(
                child: SizedBox(
                  height: _sizeH,
                  width: _sizeW,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: _sizeH * 0.3,
                        width: _sizeW,
                        child: Image.asset(
                          AppAssets.bgface,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _lastName,
                              isCheck: false,
                              text: "Họ",
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              controller: _firstName,
                              isCheck: false,
                              text: "Tên",
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        controller: _number,
                        isCheck: false,
                        text: "Number phone",
                      ),
                      CustomTextField(
                        controller: _email,
                        isCheck: false,
                        text: "Email",
                      ),
                      CustomTextField(
                        controller: _pass,
                        isCheck: true,
                        text: "Password",
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: _sizeH * 0.1),
                        child: CustomButton(
                          sizeW: _sizeW,
                          sizeH: _sizeH,
                          func: () async {
                            setState(() {
                              _isCheck = true;
                            });
                            if (_email.text.isNotEmpty &&
                                _pass.text.isNotEmpty &&
                                _firstName.text.isNotEmpty &&
                                _lastName.text.isNotEmpty &&
                                _number.text.isNotEmpty) {
                              String res = await _auth.createUser(
                                  email: _email.text,
                                  name: _lastName.text.trim() +
                                      " " +
                                      _firstName.text.trim(),
                                  pass: _pass.text,
                                  phoneNumber: _number.text);
                              showSnackBar(res, context, true);

                              setState(() {
                                _isCheck = false;
                              });
                              Navigator.pop(context);
                            } else {
                              showSnackBar(
                                  "Vui Lòng kiểm tra Lại", context, false);
                            }
                            setState(() {
                              _isCheck = false;
                            });
                          },
                          isCheck: (_email.text.isNotEmpty &&
                              _pass.text.isNotEmpty &&
                              _firstName.text.isNotEmpty &&
                              _lastName.text.isNotEmpty &&
                              _number.text.isNotEmpty),
                          color: AppColor.firstMainColor,
                          title: "ĐĂNG KÝ",
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

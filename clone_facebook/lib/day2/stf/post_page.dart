import 'dart:io';

import 'package:clone_facebook/day1/stl/custom_text_field.dart';
import 'package:clone_facebook/provider/auth_provider.dart';
import 'package:clone_facebook/provider/post_provider.dart';
import 'package:clone_facebook/service.dart/snackbar_service.dart';
import 'package:clone_facebook/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late double _sizeH;
  late double _sizeW;
  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_final_fields
  List<XFile> _selectedFiles = [];
  late PostProvider postProvider;
  late AuthencationProvider _auth;
  bool isActive = false;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _sizeH = MediaQuery.of(context).size.height;
    _sizeW = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthencationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => PostProvider(_auth),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext context) {
        postProvider = context.watch<PostProvider>();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.kBackgruondTwo,
            title: const Text("Tạo bài viết"),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () async {
                  setState(() {
                    isActive = true;
                  });
                  if (_selectedFiles.isNotEmpty || controller.text.isNotEmpty) {
                    String res = await postProvider.post(
                      files: _selectedFiles,
                      bio: controller.text,
                    );
                    if (res == "success") {
                      showSnackBar(res, context, true);
                    } else {
                      showSnackBar(res, context, false);
                    }
                    Navigator.of(context).pop();
                  }

                  setState(() {
                    isActive = false;
                  });
                },
                child: isActive
                    ? const Text("")
                    : Text(
                        "Đăng",
                        style: TextStyle(
                          color: (_selectedFiles.isNotEmpty ||
                                  controller.text.isNotEmpty)
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
              ),
            ],
          ),
          body: isActive
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: _sizeH,
                  width: _sizeW,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: controller,
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "What do you think?",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_selectedFiles.isNotEmpty)
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: _selectedFiles.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Card(
                                        elevation: 50,
                                        child: Image.file(
                                          File(_selectedFiles[index].path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                          onPressed: () {
                                            _selectedFiles
                                                .remove(_selectedFiles[index]);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: Colors.grey,
                          height: _sizeH * 0.07,
                          width: _sizeW,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(
                                onTap: () {
                                  selectedImage();
                                },
                                child: Card(
                                  child: Row(
                                    children: const [
                                      Icon(Icons.image),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Ảnh"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Future<void> selectedImage() async {
    if (_selectedFiles != null) {
      _selectedFiles.clear();
    }
    try {
      final List<XFile>? imgs = await _picker.pickMultiImage();

      if (imgs!.isNotEmpty) {
        _selectedFiles.addAll(imgs);
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }
}

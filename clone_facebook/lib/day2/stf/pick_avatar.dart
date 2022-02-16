import 'dart:typed_data';

import 'package:clone_facebook/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickAvatar extends StatefulWidget {
  const PickAvatar({
    Key? key,
    required this.file,
    required this.check,
  }) : super(key: key);

  final Uint8List file;
  final bool check;

  @override
  State<PickAvatar> createState() => _PickAvatarState();
}

class _PickAvatarState extends State<PickAvatar> {
  bool isActive = false;
  late AuthencationProvider _auth;

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      body: isActive
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                widget.check == false
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        child: SizedBox(
                          height: sizeH * 0.25,
                          width: sizeW,
                          child: Image.memory(
                            widget.file,
                            scale: 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: sizeH,
                        width: sizeW,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 110,
                              backgroundColor: Colors.grey[200],
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                    MemoryImage(widget.file, scale: 1),
                              ),
                            )
                          ],
                        ),
                      ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        isActive = true;
                      });
                      String res = await _auth.change(
                          name: widget.check == false ? "backgruond" : "avatar",
                          id: _auth.user.id,
                          file: widget.file);
                      widget.check == false
                          ? _auth.user.backgruond = res
                          : _auth.user.setAvatar = res;
                      setState(() {
                        isActive = false;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Change"),
                  ),
                ),
              ],
            ),
    );
  }
}

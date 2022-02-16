import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key? key,
    required this.func,
  }) : super(key: key);

  final Function() func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: 18,
          child: const Icon(
            Icons.camera_alt,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

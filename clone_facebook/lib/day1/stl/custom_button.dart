import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required double sizeW,
    required double sizeH,
    required this.func,
    required this.isCheck,
    required this.color,
    required this.title,
  })  : _sizeW = sizeW,
        _sizeH = sizeH,
        super(key: key);

  final double _sizeW;
  final double _sizeH;
  final Function() func;
  final bool isCheck;
  final Color color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textColor: isCheck ? Colors.white : Colors.grey[350],
        color: color,
        minWidth: _sizeW,
        height: _sizeH * 0.06,
        onPressed: func,
        child: Text(
          title,
        ),
      ),
    );
  }
}

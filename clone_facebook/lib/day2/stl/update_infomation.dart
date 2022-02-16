import 'package:clone_facebook/day2/stf/setting_profile.dart';
import 'package:flutter/material.dart';

class UpdateInfomation extends StatelessWidget {
  const UpdateInfomation({
    Key? key,
    required double sizeH,
    required double sizeW,
  })  : _sizeH = sizeH,
        _sizeW = sizeW,
        super(key: key);

  final double _sizeH;
  final double _sizeW;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const SettingProfile(),
        ),
      ),
      child: SizedBox(
        height: _sizeH * 0.05,
        width: _sizeW * 0.77,
        child: Card(
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.note_alt_outlined),
              Text(
                "Chỉnh sửa trang cá nhân",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

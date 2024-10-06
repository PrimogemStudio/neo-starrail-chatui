import 'package:flutter/material.dart';

class StarRailAvatar extends StatelessWidget {
  StarRailAvatar({super.key, required this.avatar});
  Image avatar;
  double radius = 30;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: avatar,
    );
  }
}
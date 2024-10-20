import 'package:flutter/material.dart';

class StarRailAvatar extends StatelessWidget {
  const StarRailAvatar({super.key, required this.avatar});

  final Image avatar;
  final double radius = 30;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: avatar,
    );
  }
}
import 'package:flutter/material.dart';

import '../utils/app_layout.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required IconData name,
  })  : _name = name,
        super(key: key);

  final IconData _name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppLayout.getWidth(50),
      height: AppLayout.getWidth(50),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        shape: BoxShape.circle,
      ),
      child: Icon(_name),
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/app_layout.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    Key? key,
    required IconData name,
    required VoidCallback callBack,
  })  : _name = name,
        _callBack = callBack,
        super(key: key);

  final IconData _name;
  final VoidCallback _callBack;

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
      child: IconButton(
        onPressed: _callBack,
        icon: Icon(_name),
      ),
    );
  }
}

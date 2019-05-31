import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final Widget icon;
  final Gradient gradient;

  const GradientIcon({Key key, this.icon, this.gradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: icon,
    );
  }
  
}
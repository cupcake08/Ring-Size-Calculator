import 'package:flutter/material.dart';

class RingSizeSlider extends StatelessWidget {
  const RingSizeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: 3,
      min: 0,
      max: 10,
      onChanged: (value) {},
    );
  }
}

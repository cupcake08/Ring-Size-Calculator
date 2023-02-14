import 'package:flutter/material.dart';
import 'package:ring_size_calculator/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ring Size Calculator'),
        centerTitle: true,
      ),
      body: const RingBox(),
    );
  }
}

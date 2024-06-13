import 'package:flutter/material.dart';
class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Reports')),
      body: const Center(child: Text('Lab Reports Screen')),
    );
  }
}
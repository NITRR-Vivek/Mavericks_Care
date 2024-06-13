import 'package:flutter/material.dart';
class DiagnosisScreen extends StatelessWidget {
  const DiagnosisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diagnosis and Tests')),
      body: const Center(child: Text('Diagnosis and Tests Screen')),
    );
  }
}
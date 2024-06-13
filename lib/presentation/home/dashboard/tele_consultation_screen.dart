import 'package:flutter/material.dart';
class TeleConsultationScreen extends StatelessWidget {
  const TeleConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tele Consultation')),
      body: const Center(child: Text('Tele Consultation Screen')),
    );
  }
}
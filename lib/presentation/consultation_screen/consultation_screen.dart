import 'package:flutter/material.dart';
class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Consultation Screen",
      ),
    );
  }
}

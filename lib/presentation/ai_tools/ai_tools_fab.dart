import 'package:flutter/material.dart';
import 'package:mavericscare/presentation/ai_tools/diabetes_prediction.dart';
import 'package:mavericscare/presentation/ai_tools/pneumonia_prediction_chest_xray.dart';
import 'package:mavericscare/utils/constants.dart';

class AIToolsScreen extends StatelessWidget {
  AIToolsScreen({super.key});

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Tools',
          style: TextStyle(
            color: AppColors.darkAppColor300,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _tools.length,
          itemBuilder: (context, index) {
            final tool = _tools[index];
            return GestureDetector(
              onTap: () => _navigateToScreen(context, tool['screen']),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tool['icon'],
                        size: 40,
                        color: AppColors.darkAppColor300,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        tool['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _tools = [
    {
      'icon': Icons.build,
      'title': 'Diabetes\nPrediction',
      'screen': DiabetesPrediction(),
    },
    {
      'icon': Icons.computer,
      'title': 'Pneumonia\nPrediction',
      'screen': PneumoniaPredictionChestXray(),
    },
    // Add more tools as needed
  ];
}

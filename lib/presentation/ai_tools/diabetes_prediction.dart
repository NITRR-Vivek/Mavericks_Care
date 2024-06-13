// diabetes_prediction.dart
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/diabetic_model.dart';
import '../../service/api_service.dart';
import '../../utils/constants.dart';

class DiabetesPrediction extends StatefulWidget {
  const DiabetesPrediction({super.key});

  @override
  State<DiabetesPrediction> createState() => _DiabetesPredictionState();
}

class _DiabetesPredictionState extends State<DiabetesPrediction> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  // Define controllers for the form fields
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _highBP = false;
  bool _highChol = false;
  bool _diffWalk = false;
  bool _sex = false;
  bool _isLoading = false;

  String? _prediction;

  Future<void> _predict() async {
    if (_formKey.currentState!.validate()) {
      final data = Diabetic(
        highBP: _highBP,
        highChol: _highChol,
        bmi: int.parse(_bmiController.text),
        diffWalk: _diffWalk,
        sex: _sex,
        age: int.parse(_ageController.text),
      );
      setState(() {
        _isLoading = true;
      });
      try {
        final result = await _apiService.predictDiabetes(data);
        setState(() {
          _prediction = result;
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _bmiController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CheckboxListTile(
                title: const Text('High Blood Pressure'),
                value: _highBP,
                onChanged: (bool? value) {
                  setState(() {
                    _highBP = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('High Cholesterol'),
                value: _highChol,
                onChanged: (bool? value) {
                  setState(() {
                    _highChol = value ?? false;
                  });
                },
              ),
              TextFormField(
                controller: _bmiController,
                decoration: const InputDecoration(labelText: 'BMI'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter BMI';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: const Text('Difficulty Walking'),
                value: _diffWalk,
                onChanged: (bool? value) {
                  setState(() {
                    _diffWalk = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Sex (Male: Checked, Female: Unchecked)'),
                value: _sex,
                onChanged: (bool? value) {
                  setState(() {
                    _sex = value ?? false;
                  });
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _predict,
                child: const Text('Predict'),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const SpinKitThreeInOut(
                  color: AppColors.darkAppColor300,
                  size: 50.0,
                ),
              const SizedBox(height: 20),
              if (_prediction != null)
                Text(
                  'Prediction: $_prediction',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

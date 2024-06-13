// pneumonia_prediction_chest_xray.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mavericscare/utils/constants.dart';

import '../../models/prediction_response.dart';
import '../../service/api_service.dart';

class PneumoniaPredictionChestXray extends StatefulWidget {
  const PneumoniaPredictionChestXray({super.key});

  @override
  State<PneumoniaPredictionChestXray> createState() => _PneumoniaPredictionChestXrayState();
}

class _PneumoniaPredictionChestXrayState extends State<PneumoniaPredictionChestXray> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  PredictionResponse? _prediction;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _prediction = null;
      });
    }
  }

  Future<void> _predictPneumonia() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final prediction = await ApiService().predictPneumonia(_image!);
      setState(() {
        _prediction = prediction;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pneumonia Prediction from Chest X-ray'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              if (_image != null)
                Image.file(_image!, height: 300),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(height: 20),
              if (_image != null)
                ElevatedButton(
                  onPressed: _predictPneumonia,
                  child: const Text('Predict Pneumonia'),
                ),
              const SizedBox(height: 20),
              if (_isLoading)
                const SpinKitPulsingGrid(
                  color: AppColors.darkAppColor300,
                  size: 50.0,
                ),
              if (_prediction != null)
                Column(
                  children: [
                    Text('Predicted Class: ${_prediction!.predictedClass}'),
                    Text('Confidence: ${_prediction!.confidence.toStringAsFixed(2)}'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

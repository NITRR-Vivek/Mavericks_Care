import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/diabetic_model.dart';
import '../models/prediction_response.dart';

class ApiService {
  static const String apiUrl = 'https://diabetes-predict-tanh.onrender.com/predict';
  final String _baseUrl = 'https://chest-x-ray-2.onrender.com/predict/';

  Future<String> predictDiabetes(Diabetic data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['prediction'];
      } else {
        throw Exception('Failed to get prediction');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
  Future<PredictionResponse> predictPneumonia(File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse(_baseUrl));
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final Map<String, dynamic> data = json.decode(responseData.body);
      return PredictionResponse.fromJson(data);
    } else {
      throw Exception('Failed to predict pneumonia');
    }
  }
}

class PredictionResponse {
  final String predictedClass;
  final double confidence;

  PredictionResponse({required this.predictedClass, required this.confidence});

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      predictedClass: json['predicted_class'],
      confidence: json['confidence'],
    );
  }
}

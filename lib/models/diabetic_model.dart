// diabetic_model.dart
class Diabetic {
  final bool highBP;
  final bool highChol;
  final int bmi;
  final bool diffWalk;
  final bool sex;
  final int age;

  Diabetic({
    required this.highBP,
    required this.highChol,
    required this.bmi,
    required this.diffWalk,
    required this.sex,
    required this.age,
  });

  Map<String, dynamic> toJson() {
    return {
      'HighBP': highBP ? 1 : 0,
      'HighChol': highChol ? 1 : 0,
      'BMI': bmi,
      'DiffWalk': diffWalk ? 1 : 0,
      'Sex': sex ? 1 : 0,
      'Age': age,
    };
  }
}

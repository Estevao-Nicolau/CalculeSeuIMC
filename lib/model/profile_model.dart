class ProfileModel {
  final String name;
  final double weight;
  final double height;
  final String date;
  late String classification; // You can calculate and set this in the constructor.
  late double valueIMC;


  ProfileModel({
    required this.name,
    required this.weight,
    required this.height,
    required this.date,
  }) {
    // Calculate IMC and set classification in the constructor.
    valueIMC = calculateIMC(weight, height);
    classification = getClassification(valueIMC);
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      weight: json['weight'] ?? 0.0,
      height: json['height'] ?? 0.0,
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
      'height': height,
      'date': date,
    };
  }

  double calculateIMC(double weight, double height) {
    final imc = weight / (height * height);
    return imc;
  }

  String getClassification(double imc) {
    if (imc < 16) {
      return "Magreza grave";
    } else if (imc < 17) {
      return "Magreza moderada";
    } else if (imc < 18.5) {
      return "Magreza leve";
    } else if (imc < 25) {
      return "Saudável";
    } else if (imc < 30) {
      return "Sobrepeso";
    } else if (imc < 35) {
      return "Obesidade Grau 1";
    } else if (imc < 40) {
      return "Obesidade Grau 2";
    } else {
      return "Obesidade Grau 3";
    }
  }
}

class ProfileModel {
  final String name;
  final double weight;
  final double height;
  final String date;

  ProfileModel({
    required this.name,
    required this.weight,
    required this.height,
    required this.date,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      weight: json['peso'] ?? 0.0,
      height: json['altura'] ?? 0.0,
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
    double imc = weight / (height * height);
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

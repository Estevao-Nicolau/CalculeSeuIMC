import 'package:flutter/material.dart';
import 'package:imc_calculator/screen/calculated_history_list/card_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/profile_model.dart';

class ProfileListScreen extends StatelessWidget {
  final List<ProfileModel> metricsList;

  ProfileListScreen({super.key, required this.metricsList});

  // Função para salvar o IMC em SharedPreferences
  Future<void> saveIMC(double imc) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('imc', imc);
  }

  // Função para recuperar o IMC de SharedPreferences
  Future<double?> getSavedIMC() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('imc');
  }

  final List<ProfileModel> profiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: metricsList.length,
        itemBuilder: (context, index) {
          final metrics = metricsList[index];
          final imc = metrics.calculateIMC(metrics.weight, metrics.height);

          saveIMC(imc);
          return ProfileCard(
            profile: profiles[index],
          );
        },
      ),
    );
  }
}

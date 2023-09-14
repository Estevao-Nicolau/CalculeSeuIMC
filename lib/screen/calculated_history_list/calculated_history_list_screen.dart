import 'dart:convert';

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

  // Save the list of ProfileModel objects to shared preferences
  Future<void> saveProfiles(List<ProfileModel> profiles) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonProfiles = profiles.map((profile) => profile.toJson()).toList();
    await prefs.setString('profiles', json.encode(jsonProfiles));
  }

  // Retrieve the list of ProfileModel objects from shared preferences
  Future<List<ProfileModel>> getSavedProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('profiles');
    if (jsonString != null) {
      final jsonProfiles = json.decode(jsonString) as List<dynamic>;
      return jsonProfiles.map((json) => ProfileModel.fromJson(json)).toList();
    } else {
      return [];
    }
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
          final classification = metrics.getClassification(imc);
          saveIMC(imc);
          profiles.add(metrics);
          saveProfiles(profiles);
          return ProfileCard(
            profile: metrics,
          );
        },
      ),
    );
  }
}

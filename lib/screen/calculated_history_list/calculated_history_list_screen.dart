import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imc_calculator/screen/calculated_history_list/card_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/profile_model.dart';

class ProfileListScreen extends StatefulWidget {
  final List<ProfileModel> metricsList;

  const ProfileListScreen({super.key, required this.metricsList});

  @override
  State<ProfileListScreen> createState() => _ProfileListScreenState();
}

class _ProfileListScreenState extends State<ProfileListScreen> {
  final List<ProfileModel> profiles = [];

  @override
  void initState() {
    super.initState();
    loadSavedProfiles();
  }

  Future<void> loadSavedProfiles() async {
    final savedProfiles = await getSavedProfiles();
    setState(() {
      profiles.addAll(savedProfiles);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: profiles.length, // Use a lista profiles aqui
        itemBuilder: (context, index) {
          final metrics = profiles[index];
          final imc = metrics.calculateIMC(metrics.weight, metrics.height);
          final classification = metrics.getClassification(imc);
          saveIMC(imc);
          
          saveProfiles(profiles);
          return ProfileCard(
            profile: metrics,
          );
        },
      ),
    );
  }
}

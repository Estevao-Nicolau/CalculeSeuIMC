import 'package:flutter/material.dart';
import 'package:imc_calculator/model/profile_model.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nome: ${profile.name}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Peso: ${profile.weight}',
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              'Altura: ${profile.height}',
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              'Valor Total: $profile',
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              'Data: ${profile.date}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:imc_calculator/model/profile_model.dart';

import '../../utils/custom_text_form_field.dart';
import '../calculated_history_list/calculated_history_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  List<ProfileModel> metricsList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5.0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 300.0,
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'João Silva  ',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '  04/09/2023',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      CustomFormTextField(
                        controller: _weightController,
                        icon: Icons.balance_rounded,
                        label: 'Peso',
                      ),
                      CustomFormTextField(
                        controller: _heightController,
                        icon: Icons.height,
                        label: 'Altura',
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final weight = double.parse(_heightController.text);
                          final height = double.parse(_heightController.text);
                          if (weight > 0 && height > 0) {
                            final metrics = ProfileModel(
                              name: 'nicolau',
                              weight: weight,
                              height: height,
                              date: '08/09/2023',
                            );
                            metricsList.add(metrics);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileListScreen(
                                  metricsList: metricsList,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Calcular'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileListScreen(
                  metricsList: const [],
                ),
              ),
            );
          },
          tooltip: 'Abrir Lista',
          child: const Icon(Icons.list),
        ),
      ),
    );
  }
}

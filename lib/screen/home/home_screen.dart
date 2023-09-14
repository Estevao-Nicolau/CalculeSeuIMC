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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
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
                elevation: 8.0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 300.0,
                  child: Column(
                    children: [
                      CustomFormTextField(
                        controller: _nameController,
                        icon: Icons.person,
                        label: 'Nome',
                      ),
                      CustomFormTextField(
                        controller: _dataController,
                        icon: Icons.date_range,
                        label: 'Data',
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomFormTextField(
                              controller: _weightController,
                              icon: Icons.balance_rounded,
                              label: 'Peso',
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: CustomFormTextField(
                              controller: _heightController,
                              icon: Icons.height,
                              label: 'Altura',
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final weight =
                              double.tryParse(_weightController.text);
                          final height =
                              double.tryParse(_heightController.text);
                          final name = _nameController.text;
                          final date = _dataController.text;

                          if (weight != null &&
                              height != null &&
                              name.isNotEmpty &&
                              date.isNotEmpty) {
                            final metrics = ProfileModel(
                              name: name,
                              weight: weight,
                              height: height,
                              date: date,
                            );
                            metrics.valueIMC =
                                metrics.calculateIMC(weight, height);
                            metrics.classification =
                                metrics.getClassification(metrics.valueIMC);

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

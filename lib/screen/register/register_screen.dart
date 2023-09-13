import 'package:flutter/material.dart';
import 'package:imc_calculator/database/data.base.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:sqflite/sqflite.dart';

import '../../utils/custom_text_form_field.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String cadastro = "                     Cadastro";
    String linkImage =
        'https://cdn.pixabay.com/photo/2014/07/28/11/18/scale-403585_1280.jpg';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  cadastro,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Image.network(
                  linkImage,
                  height: 250,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: _emailController,
                  icon: Icons.email,
                  label: 'Email',
                  // validator: emailValidator,
                ),
                CustomFormTextField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  label: 'Senha',
                  isSecret: true,
                  // validator: passwordValidator,
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  height: 20,
                  minWidth: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    // Save email in the database
                    Database database = await DB().fetchData();
                    await database.insert('User', {'email': email});

                    // Save password using shared_preferences
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('password', password);

                    print(email);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "já tem uma conta | ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()));
                      },
                      child: Text(
                        "Entrar ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

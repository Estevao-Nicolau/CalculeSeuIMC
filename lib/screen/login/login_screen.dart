import 'package:flutter/material.dart';
import 'package:imc_calculator/database/data.base.dart';
import 'package:imc_calculator/utils/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, String? savedEmail, String? savedPassword})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials(); // Load saved credentials when the widget initializes
  }

  _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    if (savedEmail != null) {
      _emailController.text = savedEmail;
    }

    if (savedPassword != null) {
      _passwordController.text = savedPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    String linkImage =
        "https://media.istockphoto.com/id/1169486621/pt/foto/female-leg-stepping-on-weigh-scales-healthy-lifestyle-food-and-sport-concept.webp?b=1&s=612x612&w=0&k=20&c=ydRffPY6Y_3N1kWUd1tHkPc1hQebYpVp6fLUiNFDFs4=";
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
                  height: 50,
                ),
                Image.network(
                  linkImage,
                  height: 200,
                  width: 400,
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
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  label: 'Senha',
                  isSecret: true,
                  // validator: passwordValidator,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  height: 20,
                  minWidth: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    final enteredEmail = _emailController.text;
                    final enteredPassword = _passwordController.text;

                    final emailExists = await DB().doesEmailExist(enteredEmail);

                    if (emailExists) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final savedPassword = prefs.getString('password');

                      if (savedPassword == enteredPassword) {
                        // Passwords match, proceed with the login
                        // Save email and password for future use
                        prefs.setString('email', enteredEmail);
                        prefs.setString('password', enteredPassword);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      } else {
                        // Passwords do not match, handle incorrect password
                        print('Incorrect password');
                      }
                    } else {
                      // Email does not exist in the database
                      // Handle non-existent email
                      print('Email not found');
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "não tem conta | ",
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
                                builder: (_) => const RegisterScreen()));
                      },
                      child: Text(
                        "Inscrever-se",
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

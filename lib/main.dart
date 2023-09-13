import 'package:flutter/material.dart';
import 'package:imc_calculator/screen/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final savedEmail = prefs.getString('email');
  final savedPassword = prefs.getString('password');

  runApp(MyApp(savedEmail: savedEmail, savedPassword: savedPassword));
}

class MyApp extends StatelessWidget {
  final String? savedEmail;
  final String? savedPassword;

  const MyApp({Key? key, this.savedEmail, this.savedPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(savedEmail: savedEmail, savedPassword: savedPassword),
    );
  }
}

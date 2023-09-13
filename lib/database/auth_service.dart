// import 'package:hive/hive.dart';
// import 'package:imc_calculator/db/user_hive.dart';

// class AuthService {
//   final Box<UserHive> userBox = Hive.box<UserHive>('userBox');

//   Future<bool> registerUser(UserHive user) async {
//     if (userBox.containsKey(user.email)) {
//       // Usuário já existe, não é possível registrar novamente.
//       return false;
//     }
//     userBox.put(user.email, user);
//     return true;
//   }

//   bool loginUser(String email, String senha) {
//     final user = userBox.get(email);
//     if (user != null && user.senha == senha) {
//       return true; // Autenticação bem-sucedida.
//     }
//     return false; // Autenticação falhou.
//   }
// }

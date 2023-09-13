import 'package:imc_calculator/database/data.base.dart';
import 'package:imc_calculator/model/user_model.dart';

class UserDB {
  Future<List<UserDbModel>> fetchData() async {
    List<UserDbModel> users = [];
    var db = await DB().fetchData();
    var result = await db.rawQuery(
        'SELECT id, name, email, data, weight, height, description FROM user');
    for (var elemet in result) {
      users.add(
        UserDbModel(
          int.parse(elemet['id'].toString()),
          elemet['name'].toString(),
          elemet['email'].toString(),
          double.parse(elemet['weight'].toString()),
          double.parse(elemet['height'].toString()),
          elemet['description'].toString(),
        ),
      );
    }
    return users;
  }

  Future<void> saveData(UserDbModel userDbModel) async {
    var db = await DB().fetchData();
    await db.rawInsert(
        'INSERT INTO user (id,name,email,data,weight,height,description) values(?,?)',
        [
          userDbModel.name,
          userDbModel.email,
          userDbModel.data,
          userDbModel.weight,
          userDbModel.height,
          userDbModel.description
        ]);
  }

  Future<void> update(UserDbModel userDbModel) async {
    var db = await DB().fetchData();
    await db.rawInsert(
        'UPDATE user SET id = ?,name = ?,email = ?,data = ?,weight = ?,height = ?,description = ? WHERE id = ?',
        [
          userDbModel.name,
          userDbModel.email,
          userDbModel.data,
          userDbModel.weight,
          userDbModel.height,
          userDbModel.description
        ]);
  }

  Future<void> delete(int id) async {
    var db = await DB().fetchData();
    await db.rawInsert('DELETE user WHERE id = ?', [id]);
  }
}

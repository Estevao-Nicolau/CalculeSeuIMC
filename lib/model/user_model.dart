class UserDbModel {
  int _id = 0;
  String _name = '';
  String _email = '';
  String _data = '';
  double _weight = 0.0;
  double _height = 0.0;
  String _description = '';

  UserDbModel(
    this._id,
    this._email,
    this._data,
    this._weight,
    this._height,
    this._description,
  );
  int get id => _id;
  set id(int id) {
    _id = id;
  }

  String get name => _name;
  set name(String name) {
    _name = name;
  }
  String get email => _email;
  set email(String email) {
    _email = email;
  }
  String get data => _data;
  set date(String data) {
    _data = data;
  }
  double get weight => _weight;
  set weight(double weight) {
    _weight = weight;
  }
  double get height => _height;
  set height(double height) {
    _height = height;
  }

  String get description=> _description;
  set description(String description) {
    _description = description;
  }
}

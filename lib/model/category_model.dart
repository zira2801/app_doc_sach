class Category {
  int _id;
  String _name;
  String _Description;

  Category(this._id, this._name, this._Description);

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get Description => _Description;

  set Description(String Description) {
    _Description = Description;
  }
}
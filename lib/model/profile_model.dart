class Profile {
  int _id;
  String _fullName;
  String _email;
  DateTime _age;
  String _image;
  String _phone;
  String _gender;
  String _address;

  Profile(this._id, this._fullName, this._email, this._age, this._image, this._phone, this._gender, this._address);

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get fullName => _fullName;

  set fullName(String fullName) {
    _fullName = fullName;
  }

    String get email => _email;

  set email(String email) {
    _email = email;
  }

  DateTime get age => _age;

  set age(DateTime age) {
    _age = age;
  }

  String get image => _image;

  set image(String image) {
    _image = image;
  }

  String get phone => _phone;

  set phone(String phone) {
    _phone = phone;
  }

  String get gender => _gender;

  set gender(String gender) {
    _gender = gender;
  }

  String get address => _address;

  set address(String address) {
    _address = address;
  }
}

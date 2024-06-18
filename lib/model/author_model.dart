class Author {
  int _id;
  String _authorName;
  DateTime _birthDate;
  String _born;
  String _telphone;
  String _nationality;
  String _bio;

  Author(this._id, this._authorName, this._birthDate, this._born, this._telphone,this._nationality, this._bio);

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get authorName => _authorName;

  set authorName(String authorName) {
    _authorName = authorName;
  }

  DateTime get birthDate => _birthDate;

  set birthDate(DateTime birthDate) {
    _birthDate = birthDate;
  }

  String get born => _born;

  set born(String born) {
    _born = authorName;
  }

  String get telphone => _telphone;

  set telphone(String telphone) {
    _telphone = telphone;
  }

  String get nationality => _nationality;

  set nationality(String nationality) {
    _nationality = nationality;
  }

  String get bio => _bio;

  set bio(String bio) {
    _bio = bio;
  }
}
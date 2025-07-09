class UserModel {
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      registrationTokenList: List<String>.from(map['registrationTokenList'] ?? []),
    );
  }
  String _userName;
  String _password;
  String _email;
  final List<String> _registrationTokenList;

  UserModel({
    required String userName,
    required String email,
    required String password,
    required List<String> registrationTokenList
  })  : _userName = userName,
        _email = email,
        _password = password,
        _registrationTokenList = registrationTokenList,
        assert(email != '', '_Email cant be null'),
        assert(password != '', '_Password cant be null'),
        assert(registrationTokenList.isNotEmpty, 'An error has ocurred');

  String get getUserName => _userName;
  String get getPassword => _password;
  String get getEmail => _email;
  List<String> get getRegistrationTokenList => _registrationTokenList;

  set setUserName(String newUserName) {
    _userName = newUserName;
  }

  set setPassword(String newPassword) {
    _password = newPassword;
  }

  set setEmail(String newEmail) {
    _email = newEmail;
  }

  void setRegistrationTokenList(String registrationToken) {
    _registrationTokenList.add(registrationToken);
  }
}
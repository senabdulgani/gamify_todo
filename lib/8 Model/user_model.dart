class UserModel {
  int id;
  String email;
  String password;
  Duration creditProgress;
  int userCredit;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    this.creditProgress = const Duration(hours: 0, minutes: 0, seconds: 0),
    this.userCredit = 0,
  });
}

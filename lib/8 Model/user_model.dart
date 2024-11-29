class UserModel {
  int id;
  String username;
  String email;
  String password;
  Duration tasksTotalProgressForCalculateCredit;
  int userCredit;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.tasksTotalProgressForCalculateCredit = const Duration(hours: 0, minutes: 0, seconds: 0),
    this.userCredit = 0,
  });
}

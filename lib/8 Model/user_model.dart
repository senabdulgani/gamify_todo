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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    Duration stringToDuration(String timeString) {
      List<String> split = timeString.split(':');
      return Duration(hours: int.parse(split[0]), minutes: int.parse(split[1]), seconds: int.parse(split[2]));
    }

    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      creditProgress: stringToDuration(json['credit_progress']),
      userCredit: json['user_credit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'creditProgress': creditProgress.inSeconds,
      'userCredit': userCredit,
    };
  }
}

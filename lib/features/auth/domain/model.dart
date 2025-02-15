class UserApp {
  int? id;
  String? username;
  String? email;
  String? apiToken;

  UserApp({
    this.id,
    this.username,
    this.email,
    this.apiToken,
  });

  // factory FirstLogin.fromJson(Map<String, dynamic> json) => FirstLogin(
  //       estado: json["estado"],
  //       message: json["message"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "estado": estado,
  //       "message": message,
  //     };
}

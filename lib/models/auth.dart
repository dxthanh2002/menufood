class LoginResponse {
  final bool? error;
  final LoginData? data;

  LoginResponse({this.error, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    error: json["error"],
    data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"error": error, "data": data?.toJson()};
}

class LoginData {
  final String? accessToken;
  final bool? isNewUser;
  final UserData? user;

  LoginData({this.accessToken, this.isNewUser, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    accessToken: json["accessToken"],
    isNewUser: json["isNewUser"],
    user: json["user"] == null ? null : UserData.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "isNewUser": isNewUser,
    "user": user?.toJson(),
  };
}

class UserData {
  final String? id;
  final String? type;

  UserData({this.id, this.type});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      UserData(id: json["id"], type: json["type"]);

  Map<String, dynamic> toJson() => {"id": id, "type": type};
}

class Auth {
  int authID;
  String username;
  String password;
  int level;

  Auth({this.authID, this.username, this.password, this.level});

  Auth.fromJson(Map<String, dynamic> json) {
    authID = json['authID'];
    username = json['username'];
    password = json['password'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authID'] = this.authID;
    data['username'] = this.username;
    data['password'] = this.password;
    data['level'] = this.level;
    return data;
  }
}
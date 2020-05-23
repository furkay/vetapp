class User {
  int userID;
  String name;
  String adress;
  String number;
  String level;
  String password;
  int petID;

  User({this.userID, this.name, this.adress, this.number,this.level, this.petID,this.password});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    name = json['name'];
    adress = json['adress'];
    number = json['number'];
    level=json['level'];
    petID = json['petID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['adress'] = this.adress;
    data['number'] = this.number;
    data['level']=this.level;
    data['petID'] = this.petID;
    return data;
  }
}
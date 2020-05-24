class Pet {
  int petID;
  String petType;
  String year;
  String userName;

  Pet({this.petID, this.petType, this.year,this.userName});

  Pet.fromJson(Map<String, dynamic> json) {
    petID = json['petID'];
    petType = json['petType'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petID'] = this.petID;
    data['petType'] = this.petType;
    data['year'] = this.year;
    return data;  
  }
}
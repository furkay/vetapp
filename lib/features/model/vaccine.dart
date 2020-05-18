class Vaccine {
  int petID;
  String vaccineName;
  String vaccineDate;

  Vaccine({this.petID, this.vaccineName, this.vaccineDate});

  Vaccine.fromJson(Map<String, dynamic> json) {
    petID = json['petID'];
    vaccineName = json['vaccineName'];
    vaccineDate = json['vaccineDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petID'] = this.petID;
    data['vaccineName'] = this.vaccineName;
    data['vaccineDate'] = this.vaccineDate;
    return data;
  }
}
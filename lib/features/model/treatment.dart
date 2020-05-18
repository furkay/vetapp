class Treatment {
  int petID;
  String treatmentName;
  String treatmentDate;
  String medicineNames;

  Treatment(
      {this.petID, this.treatmentName, this.treatmentDate, this.medicineNames});

  Treatment.fromJson(Map<String, dynamic> json) {
    petID = json['petID'];
    treatmentName = json['treatmentName'];
    treatmentDate = json['treatmentDate'];
    medicineNames = json['medicineNames'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petID'] = this.petID;
    data['treatmentName'] = this.treatmentName;
    data['treatmentDate'] = this.treatmentDate;
    data['medicineNames'] = this.medicineNames;
    return data;
  }
}
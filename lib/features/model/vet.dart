class Vet {
  int vetID;
  int vergiNo;
  String klinik;

  Vet({this.vetID, this.vergiNo, this.klinik});

  // Vet.fromJson(Map<String, dynamic> json) {
  //   vetID = json['vetID'];
  //   name = json['name'];
  //   adress = json['adress'];
  //   number = json['number'];
  //   level=json['level'];
  //   klinik = json['klinik'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['vetID'] = this.vetID;
  //   data['name'] = this.name;
  //   data['adress'] = this.adress;
  //   data['number'] = this.number;
  //   data['level']=this.level;
  //   data['klinik'] = this.klinik;
  //   return data;
  // }
}
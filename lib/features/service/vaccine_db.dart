import 'package:flutter/material.dart';
import 'package:vetapp/core/service/db_conn.dart';
import 'package:vetapp/features/model/vaccine.dart';

class VaccineDB {
  List<Vaccine> globalVaccineList = [];
  VaccineDB() {
    createTable();
  }
  Future createTable() async {
    var client = await DBConn.db;
    client.query("""CREATE TABLE if not exists vaccines (
      petID int NOT NULL  , 
      vaccineName varchar(255) NOT NULL , 
      vaccineDate varchar(255),
      primary key(petID,vaccineName)
       )""");

    //await client.close();
  }

  Future addVaccine(Vaccine vaccine) async {
    var client = await DBConn.db;
    await client.query(
        'insert into vaccines (petID, vaccineName,vaccineDate) values (?,?,?)',
        [vaccine.petID, vaccine.vaccineName, vaccine.vaccineDate]);
    //   await client.close();
  }

  Future deleteVaccine(String vaccineName,int petID) async {
    var client = await DBConn.db;
    await client.query(
        'delete from vaccines WHERE vaccineName = "$vaccineName" AND petID = $petID').catchError((onError){print(onError);});
    //   await client.close();
  }


  Future fetchVaccine({@required int petID}) async {
    List<Vaccine> vaccines = [];
    var client = await DBConn.db;
    var results =
        await client.query('select * from vaccines where petID=$petID');

    results.forEach((rs) {
      Vaccine vaccine = Vaccine();
      vaccine.petID = rs[0];
      vaccine.vaccineName = rs[1];
      vaccine.vaccineDate = rs[2];
      vaccines.add(vaccine);
    });

    //   await client.close();
    globalVaccineList = vaccines;
  }
}

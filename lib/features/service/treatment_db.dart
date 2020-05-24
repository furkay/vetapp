import 'package:flutter/cupertino.dart';
import 'package:vetapp/core/service/db_conn.dart';
import 'package:vetapp/features/model/treatment.dart';

class TreatmentDB {
  List<Treatment> globalTreatments = [];
  TreatmentDB() {
    createTable();
  }
  Future createTable() async {
    var client = await DBConn.db;
    client.query("""CREATE TABLE if not exists treatments (
      petID int NOT NULL  , 
      medicineNames varchar(255), 
      treatmentName varchar(255), 
      treatmentDate varchar(255),
      primary key(petID,treatmentDate)
       )""");

    //await client.close();
  }

  Future addTreatment(Treatment treatment) async {
    var client = await DBConn.db;
    await client.query(
        'insert into treatments (petID, medicineNames,treatmentName,treatmentDate) values (?,?,?,?)',
        [
          treatment.petID,
          treatment.medicineNames,
          treatment.treatmentName,
          treatment.treatmentDate
        ]);
    //   await client.close();
  }

  Future deleteTreatment(String treatmentName, int petID) async {
    var client = await DBConn.db;
    await client
        .query(
            'delete from treatments WHERE treatmentName = "$treatmentName" AND petID = $petID')
        .catchError((onError) {
      print(onError);
    });
    //   await client.close();
  }

  Future fetchTreatments({@required int petID}) async {
    List<Treatment> treatments = [];
    var client = await DBConn.db;
    var results =
        await client.query('select * from treatments where petID=$petID');

    results.forEach((rs) {
      Treatment treatment = Treatment();
      treatment.petID = rs[0];
      treatment.medicineNames = rs[1];
      treatment.treatmentName = rs[2];
      treatment.treatmentDate = rs[3];
      treatments.add(treatment);
    });

    //   await client.close();
    globalTreatments = treatments;
  }
}

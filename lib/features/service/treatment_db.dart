import 'package:vetapp/core/service/db_conn.dart';
import 'package:vetapp/features/model/treatment.dart';

class TreatmentDB {
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
        [treatment.petID, treatment.medicineNames, treatment.treatmentName,treatment.treatmentDate ]);
 //   await client.close();
  }
}
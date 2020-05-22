import 'package:vetapp/core/service/db_conn.dart';
import 'package:vetapp/features/model/vaccine.dart';

class VaccineDB {
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
}
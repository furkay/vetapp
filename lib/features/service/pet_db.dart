import 'package:vetapp/core/service/db_conn.dart';
import 'package:vetapp/features/model/pet.dart';

class PetDB {
  
  PetDB() {
    createTable();
  }
  Future createTable() async {
    var client = await DBConn.db;
    client.query("""CREATE TABLE if not exists pets (
      id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
      petType varchar(255), 
      year varchar(255)
       )""");

    //await client.close();
  }

  Future addPet(Pet pet) async {
    var client = await DBConn.db;
    await client.query('insert into pets (petType, year) values (?,?)',
        [pet.petType, pet.year]);
    //   await client.close();
   
  }

  Future<Pet> fetchPet() async {
    //kullanici objesinden çekilecek normalde -id
    int id = 4;

    var client = await DBConn.db;
    var results =
        await client.query('select petType, year from pets where id=$id');

    Pet pet = Pet();
    results.forEach((element) {
      pet.petID = id;
      pet.petType = element[0];
      pet.year = element[1];
    });

    //   await client.close();
    return pet;
  }
}

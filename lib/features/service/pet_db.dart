import 'package:flutter/widgets.dart';
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
      year varchar(255),
      userName varchar(255) 
       )""");

    //await client.close();
  }

  Future addPet(Pet pet) async {
    var client = await DBConn.db;
    await client.query(
        'insert into pets (petType, year, userName) values (?,?,?)',
        [pet.petType, pet.year, pet.userName]);

    //   await client.close();
  }

  Future <List<Pet>> fetchPet({@required String userName}) async {
    //kullanici objesinden çekilecek normalde -id
    List<Pet> pets=[];
    var client = await DBConn.db;
    var results = await client
        .query(
            'select petType, year,userName,id from pets where userName="$userName"')
        .catchError((onError) {
      throw onError;
    });

    
    results.forEach((element) {
      Pet pet = Pet();
      pet.petID = element[3];
      pet.petType = element[0];
      pet.year = element[1];
      pet.userName = element[2];
      pets.add(pet);
    });

    //   await client.close();
    return pets;
  }
}

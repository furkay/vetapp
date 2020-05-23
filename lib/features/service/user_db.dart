import 'package:vetapp/core/service/db_conn.dart';
import 'package:vetapp/features/model/user.dart';

class UserDB {
  UserDB() {
    createTable();
  }
  Future createTable() async {
    var client = await DBConn.db;
    client.query("""CREATE TABLE if not exists users (
      id int NOT NULL, 
      name varchar(255) PRIMARY KEY, 
      adress varchar(255),
      number varchar(11),
      level varchar(15),
      petID int
       )""");

    //await client.close();
  }

  Future<String> addUser(User user) async {
    var client = await DBConn.db;
    String hata;
    await client.query(
        'insert into users (name, adress, number,level,petID) values (?,?,?,?,?)',
        [user.name,
        user.adress,
        user.number,
        user.level,
        user.petID
        ]).catchError((error){hata = error.toString();});
    //   await client.close();
    return hata;
  }
}

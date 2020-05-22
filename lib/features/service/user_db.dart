import 'package:vetapp/core/service/db_conn.dart';
import 'package:vetapp/features/model/user.dart';

class UserDB {
  UserDB() {
    createTable();
  }
  Future createTable() async {
    var client = await DBConn.db;
    client.query("""CREATE TABLE if not exists users (
      id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
      name varchar(255), 
      adress varchar(255),
      number varchar(11),
      level int,
      petID int
       )""");
      
    //await client.close();
  }

  Future addUser(User user) async {
    var client = await DBConn.db;
   await client.query(
        'insert into users (name, adress, number,level,petID) values (?,?,?,?,?)',
        [user.name, user.adress, user.number, user.level, user.petID]);
 //   await client.close();
  }
}

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
      password varchar(255),
      level varchar(15),
      petID int
       )""");

    //await client.close();
  }

  String hata;
  Future<String> addUser(User user) async {
    var client = await DBConn.db;

    await client.query(
        'insert into users (name, adress, number,level,password,petID) values (?,?,?,?,?,?)',
        [
          user.name,
          user.adress,
          user.number,
          user.level,
          user.password,
          user.petID
        ]).catchError((error) {
      hata = error.toString();
    });
    //   await client.close();
    return hata;
  }

  Future<User> updateUserValues(String username, User user) async {
    var client = await DBConn.db;

    await client
        .query(
            ' UPDATE users SET adress = "${user.adress}", number= "${user.number}", password = "${user.password}" where name = "$username" ')
        .catchError((error) {
      hata = error.toString();
    });
    //   await client.close();
    return user;
  }

  Future<User> authControl(String username, String pass) async {
    var client = await DBConn.db;
    var rs = await client
        .query(
            'select * from users where name= "$username" AND password = "$pass" ')
        .catchError((error) {
      hata = error.toString();
    });
    User user = User();
    rs.forEach((element) {
      user.name = element[1];
      user.adress = element[2];
      user.number = element[3];
      user.password = element[4];
      user.level = element[5];
      user.petID = element[6] ?? null;
    });
    //   await client.close();
    return user;
  }

  Future<List<User>> fetchUser() async {
    List<User> users = [];
    var client = await DBConn.db;
    var results = await client
        .query('select name, adress, number from users where level="Uye" ')
        .catchError((onError) {
      throw onError;
    });

    results.forEach((element) {
      User user = User();
      user.name = element[0];
      user.adress = element[1];
      user.number = element[2];
      users.add(user);
    });

    //   await client.close();
    return users;
  }
}

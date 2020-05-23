import 'package:vetapp/core/service/db_conn.dart';
import 'package:vetapp/features/model/vet.dart';

class VetDB {
  VetDB() {
    createTable();
  }
  Future createTable() async {
    var client = await DBConn.db;
    client.query("""CREATE TABLE if not exists vets (
      id int NOT NULL, 
      vergiNo varchar(255),
      kullaniciAdi varchar(255) PRIMARY KEY,
      klinik varchar(255)
       )""");

    //await client.close();
  }

  Future<String> addVet(Vet vet) async {
    var client = await DBConn.db;
    String hata;
    await client.query(
        'insert into vets (id, klinik, kullaniciAdi,vergiNo) values (?,?,?,?)',
        [
          vet.vetID,
          vet.klinik,
          vet.kullaniciAdi,
          vet.vergiNo,
        ]).catchError((error) {
      hata = error.toString();
    });
    //   await client.close();
    return hata;
  }
}

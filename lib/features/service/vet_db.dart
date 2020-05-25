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
      klinik varchar(255),
      sifre varchar(255)
       )""");

    //await client.close();
  }

  Future<String> addVet(Vet vet) async {
    var client = await DBConn.db;
    String hata;
    await client.query(
        'insert into vets (id, klinik, kullaniciAdi,vergiNo,sifre) values (?,?,?,?,?)',
        [
          vet.vetID,
          vet.klinik,
          vet.kullaniciAdi,
          vet.vergiNo,
          vet.sifre
        ]).catchError((error) {
      hata = error.toString();
    });
    //   await client.close();
    return hata;
  }

  Future fetchVetAllData(String klinikName) async {
    List klinikVets = [];
    // Map<String, String> vets = Map();
    var client = await DBConn.db;
    var results = await client.query(
        """SELECT users.name, vets.klinik, users.adress,users.number,users.level,vets.vergiNo
FROM users
INNER JOIN vets ON vets.kullaniciAdi = users.name  group by users.name, vets.klinik, users.adress,users.number,users.level,vets.vergiNo having klinik='$klinikName' """).catchError((onError) {
      print(onError);
    });

    results.forEach((element) {

     // print(element);
      // vets['name'] = element['name'];
      // vets['klinik'] = element['klinik'];
      // vets['adress'] = element['adress'];
      // vets['number'] = element['number'];
      // vets['level'] = element['level'];
      // vets['vergiNo'] = element['vergiNo'];

     

     // print(element.toList());
       klinikVets.add(element.toList());
      //index++;
    });
    // klinikVets.add(vets);
    //   await client.close();
    //print(klinikVets);
  //  print(klinikVets);
    return klinikVets;
  }

  Future<List<Vet>> fetchVet() async {
    List<Vet> vets = [];
    var client = await DBConn.db;
    var results = await client
        .query('select DISTINCT klinik from vets')
        .catchError((onError) {
      print(onError);
    });

    results.forEach((element) {
      Vet vet = Vet();
      vet.klinik = element[0];
      vets.add(vet);
    });

    //   await client.close();
    return vets;
  }
}

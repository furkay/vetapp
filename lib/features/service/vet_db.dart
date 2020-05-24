import 'package:flutter/material.dart';
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

  Future<List<Vet>> fetchVet() async {
    List<Vet> vets = [];
    var client = await DBConn.db;
    var results = await client
        .query('select klinik, kullaniciAdi from vets')
        .catchError((onError) {
      throw onError;
    });

    results.forEach((element) {
      Vet vet = Vet();
      vet.klinik = element[0];
      vet.kullaniciAdi = element[1];
      vets.add(vet);
    });

    //   await client.close();
    return vets;
  }
}

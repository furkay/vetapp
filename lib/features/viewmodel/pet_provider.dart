import 'package:flutter/material.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/features/model/pet.dart';
import 'package:vetapp/features/service/pet_db.dart';

class PetProvider extends ChangeNotifier {
  PetProvider();
  List<Pet> _petList = [];
  void addPet(Pet pet) {
    _petList.add(pet);
    notifyListeners();
  }

  void addAllPet(List<Pet> list) {
    _petList.addAll(list);
    notifyListeners();
  }

  getData(String userName) async {
    await sl<PetDB>().fetchPet(userName: userName);
    notifyListeners();
  }

  List<Pet> get getPetList => _petList;
}

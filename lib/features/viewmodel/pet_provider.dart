import 'package:flutter/material.dart';
import 'package:vetapp/features/model/pet.dart';

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

  List<Pet> get getPetList => _petList;
}

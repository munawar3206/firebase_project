import 'package:firebase/model/techname_model.dart';
import 'package:firebase/services/firebase_service.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class technameProvider extends ChangeNotifier {
  final FirebaseServices firebaseServices = FirebaseServices();
  TextEditingController studname = TextEditingController();
  TextEditingController studbatch = TextEditingController();
  TextEditingController studphone = TextEditingController();
  String? selectedGroup;
  List<TechModel> technames = [];

  Future<void> fetchtechname() async {
    technames = await firebaseServices.fetchtechname();
    notifyListeners();
  }

  Future<void> deletetechname(String docID) async {
    firebaseServices.deletetechname(docID);
    await fetchtechname();
    notifyListeners();
  }

  void setSelectedGroup(String value) {
    selectedGroup = value;
    notifyListeners();
  }

  void addtechname() async {
    final techname = TechModel(
        id: "",
        name: studname.text,
        batch: studbatch.text,
        phone: studphone.text,
        domain: selectedGroup);
    firebaseServices.addtechname(techname);
    await fetchtechname();
    notifyListeners();
  }

  void updatetechname(String docID) async {
    final techname = TechModel(
        id: docID,
        name: studname.text,
        batch: studbatch.text,
        phone: studphone.text,
        domain: selectedGroup);
    firebaseServices.updatetechname(techname);
    await fetchtechname();
    notifyListeners();
  }
}

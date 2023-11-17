import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/techname_model.dart';

class FirebaseServices {
  final CollectionReference techname =
      FirebaseFirestore.instance.collection('techname');

  Future<List<TechModel>> fetchtechname() async {
    final snapshot = await techname.orderBy('name').get();
    return snapshot.docs.map(
      (doc) {
        return TechModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      },
    ).toList();
  }

  void deletetechname(String docID) {
    techname.doc(docID).delete();
  }

  void addtechname(TechModel techname1) {
    final data = techname1.toMap();
    techname.add(data);
  }

  void updatetechname(TechModel techname1) {
    final data = techname1.toMap();
    techname.doc(techname1.id).update(data);
  }
}

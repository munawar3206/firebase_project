import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final domains = [
    "Mern,",
    "Mean",
    "Flutter",
    ".net",
    "Python",
    "C-sharp",
    "Node",
    "React",
    "Golang"
  ];
  String? selectedGroup;
  final CollectionReference techname =
      FirebaseFirestore.instance.collection('techname');
  TextEditingController studname = TextEditingController();
  TextEditingController studbatch = TextEditingController();
  TextEditingController studphone = TextEditingController();

  void updatetechname(docID) {
    final data = {
      'name': studname.text,
      'batch': studbatch.text,
      'phone': studphone.text,
      'domain': selectedGroup
    };
    techname.doc(docID).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    studname.text = args['name'];
    studbatch.text = args['phone'];
    studphone.text = args['batch'];
    selectedGroup = args["domain"];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 70, 54, 244),
        title: const Text("Updates"),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextFormField(
            controller: studname,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Devops Name"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: studbatch,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text("Batch")),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: studphone,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text("Phone Number")),
            maxLength: 10,
          ),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                  label: Text("Select Domain"),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 70, 54, 244))),
              items: domains
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) {
                selectedGroup = val;
              }),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              updatetechname(docId);
            },
            style: const ButtonStyle(
                minimumSize:
                    MaterialStatePropertyAll(Size(double.infinity, 50)),
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 70, 54, 244))),
            child: const Text(
              "Update",
              style: TextStyle(fontSize: 20),
            ),
          )
        ]),
      ),
    );
  }
}
